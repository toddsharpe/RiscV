`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 05:32:30 PM
// Design Name: 
// Module Name: SoC
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


module SoC(
    input clk,
    input cpu_clk,
    input reset,
    output halt,
    output [15:0] displayOut,
    output [15:0] ledsOut
);

    wire [31:0] mem_addr;
    wire [31:0] mem_rdata;
    wire mem_rstrb;
    wire [31:0] mem_wdata;
    wire [3:0]  mem_wmask;

    //TODO: Memory controller for memorymapped peripherals (LEDs, switches, etc.)
    //0-1023: Memory
    //1024 (int32): LED display
    //1028 (int32): LEDs
    wire isLedDisplay = mem_addr == 1024;
    GpioPort ledDisplayPort(
        //.clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .enable(isLedDisplay),
        .data_in(mem_wdata[15:0]),
        .data_out(displayOut)
    );

    wire isLeds = mem_addr == 1028;
    GpioPort gpio1(
        //.clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .enable(isLeds),
        .data_in(mem_wdata[15:0]),
        .data_out(ledsOut)
    );

    wire isMemory = mem_addr < 1024;
    Memory memory(
        .clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .enable(isMemory),
        .mem_addr(mem_addr),
        .mem_rdata(mem_rdata),
        .mem_rstrb(mem_rstrb),
        .mem_wdata(mem_wdata),
        .mem_wmask(mem_wmask)
    );

    Processor processor(
        .clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .halt(halt),
        .mem_addr(mem_addr),
        .mem_rdata(mem_rdata),
        .mem_rstrb(mem_rstrb),
        .mem_wdata(mem_wdata),
        .mem_wmask(mem_wmask)
    );

endmodule
