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
    input clk,
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

    //VIO
    memory_vio memory_vio (
        .clk(clk),
        .probe_in0(MEM[0]),
        .probe_in1(MEM[1]),
        .probe_in2(MEM[2]),
        .probe_in3(MEM[3]),
        .probe_in4(MEM[4]),
        .probe_in5(MEM[5]),
        .probe_in6(MEM[6]),
        .probe_in7(MEM[7]),
        .probe_in8(MEM[8]),
        .probe_in9(MEM[9]),
        .probe_in10(MEM[10]),
        .probe_in11(MEM[11]),
        .probe_in12(MEM[12]),
        .probe_in13(MEM[13]),
        .probe_in14(MEM[14]),
        .probe_in15(MEM[15])
    );

endmodule
