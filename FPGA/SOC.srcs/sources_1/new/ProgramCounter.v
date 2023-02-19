`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2023 09:48:59 PM
// Design Name: 
// Module Name: ProgramCounter
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


`include "DEFINES.vinc"

module ProgramCounter(
    input clk,
    input reset,
    input halt,
    input [2:0] pcOp,
    input [31:0] pcImm,
    input [31:0] pcAbsolute,
    output reg [31:0] PC
);

    //PC calculations
    wire [31:0] PCplusImm = PC + pcImm;
    wire [31:0] PCplus4 = PC + 4;

    always @(posedge clk) begin
        if (reset) begin
            PC <= 0;
        end else if (!halt) begin
            case (pcOp)
                PC_NEXT: PC <= PCplus4;
                PC_REL: PC <= PCplusImm;
                PC_ABS: PC <= pcAbsolute;
                default: PC <= PCplus4;
            endcase
        end
    end

endmodule
