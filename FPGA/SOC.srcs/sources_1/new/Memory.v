`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 06:11:25 AM
// Design Name: 
// Module Name: Memory
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


module Memory(
    //input clk,
    input cpu_clk,
    input reset,
    input [31:0] mem_addr,
    output reg [31:0] mem_rdata,
    input mem_rstrb,
    input [31:0] mem_wdata,
    input [3:0] mem_wmask
);

    reg [31:0] MEM [0:255];

    initial begin
        $display("Loading RAM.");
        $readmemh("count.mem", MEM);
    end

    wire [29:0] word_addr = mem_addr[31:2];

    always @(posedge cpu_clk) begin
        if (reset) begin
            $readmemh("count.mem", MEM);
        end else begin
            if(mem_rstrb) mem_rdata <= MEM[word_addr];
            if(mem_wmask[0]) MEM[word_addr][ 7:0 ] <= mem_wdata[ 7:0 ];
            if(mem_wmask[1]) MEM[word_addr][15:8 ] <= mem_wdata[15:8 ];
            if(mem_wmask[2]) MEM[word_addr][23:16] <= mem_wdata[23:16];
            if(mem_wmask[3]) MEM[word_addr][31:24] <= mem_wdata[31:24];	 
        end
    end

endmodule
