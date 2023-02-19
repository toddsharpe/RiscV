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
    input sw15,
    output [3:0] an,
    output [6:0] seg
);

    //Peripherals
    wire [15:0] led_out;

    //SoC
    SoC soc(
        .clk(clk),
        .reset(sw15),
        .led_out(led_out)
    );

    //LED Peripheral
    LedSegmentsController segDisplay(.clk(clk), .value(led_out), .an(an), .seg(seg));
endmodule
