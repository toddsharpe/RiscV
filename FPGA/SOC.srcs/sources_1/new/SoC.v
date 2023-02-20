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
    output [15:0] led_out
);

    wire [31:0] mem_addr;
    wire [31:0] mem_rdata;
    wire mem_rstrb;
    wire [31:0] mem_wdata;
    wire [3:0]  mem_wmask;

    //TODO: Memory controller for memorymapped peripherals (LEDs, switches, etc.)
    
    Memory memory(
        .clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
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
        .mem_addr(mem_addr),
        .mem_rdata(mem_rdata),
        .mem_rstrb(mem_rstrb),
        .mem_wdata(mem_wdata),
        .mem_wmask(mem_wmask)
    );

    //TODO: connect perhipheral to memory controller
    assign led_out = 16'hFF00;
endmodule
