`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 07:46:45 PM
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input clk,
    input reset,
    input [4:0] rs1Id,
    input [4:0] rs2Id,
    input [4:0] rdId,
    input writeback,
    input [31:0] DATA,
    output [31:0] rd1,
    output [31:0] rd2
);

    integer i;

    //X0-X32. X0 is always 0
    reg [31:0] REGISTERS [0:31];

    //Initialize
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            REGISTERS[i] = 0;
        end
    end

    //Writeback
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                REGISTERS[i] = 0;
            end
        end else begin
            if (writeback && (rdId != 0)) begin
                REGISTERS[rdId] <= DATA;
            end
        end
    end

    assign rd1 = REGISTERS[rs1Id];
    assign rd2 = REGISTERS[rs2Id];
endmodule
