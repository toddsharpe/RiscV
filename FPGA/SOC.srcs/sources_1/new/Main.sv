`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 10:48:41 AM
// Design Name: 
// Module Name: Main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Main(
    input clk,
    input btnC,
    input [6:0] sw,
    input sw15,
    output [3:0] an,
    output [6:0] seg
);

    //SOC IO
    wire reset = sw15;
    wire halt;
    
    //Peripherals
    wire [15:0] led_out;

    //Clocks
    wire manual_clk;
    wire clk_8hz;
    wire clk_16hz;
    wire clk_32hz;
    wire clk_64hz;
    wire clk_128hz;
    wire clk_256hz;
    wire clk_512hz;

    button_pressed btnC_pressed(
        .clk(clk),
        .button(btnC),
        .pressed(manual_clk)
    );

    clock_divider #(.FREQ(8)) clk_8(
        .clk(clk),
        .reset(),
        .clk_div(clk_8hz)
    );

    clock_divider #(.FREQ(16)) clk_16(
        .clk(clk),
        .reset(),
        .clk_div(clk_16hz)
    );

    clock_divider #(.FREQ(32)) clk_32(
        .clk(clk),
        .reset(),
        .clk_div(clk_32hz)
    );

    clock_divider #(.FREQ(64)) clk_64(
        .clk(clk),
        .reset(),
        .clk_div(clk_64hz)
    );

    clock_divider #(.FREQ(128)) clk_128(
        .clk(clk),
        .reset(),
        .clk_div(clk_128hz)
    );

    clock_divider #(.FREQ(256)) clk_256(
        .clk(clk),
        .reset(),
        .clk_div(clk_256hz)
    );

    clock_divider #(.FREQ(512)) clk_512(
        .clk(clk),
        .reset(),
        .clk_div(clk_512hz)
    );

    assign cpu_clk = (sw[6] ? clk_512hz :
                        (sw[5] ? clk_256hz : 
                            (sw[4] ? clk_128hz : 
                                (sw[3] ? clk_64hz : 
                                    (sw[2] ? clk_32hz : 
                                        (sw[1] ? clk_16hz : 
                                            (sw[0] ? clk_8hz :
                                                manual_clk))))))) & (~halt | reset);

    //SoC
    SoC soc(
        .clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .halt(halt),
        .led_out(led_out)
    );

    //LED Peripheral
    LedSegmentsController segDisplay(.clk(clk), .value(led_out), .an(an), .seg(seg));
endmodule
