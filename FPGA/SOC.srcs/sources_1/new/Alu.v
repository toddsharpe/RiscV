`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2023 07:23:10 AM
// Design Name: 
// Module Name: ALU
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

module ALU(
    input [3:0] op,
    input [31:0] aluIn1,
    input [31:0] aluIn2,
    output reg [31:0] aluOut,
    output EQ,
    output LT,
    output LTU
);

    //SPEC: Page 130.
    //Func3
    //000: ADD/SUB,ADDI
    //001: SLL,SLLI
    //010: SLT,SLTI
    //011: SLTU,SLTIU
    //100: XOR,XORI
    //101: SRL/SRA,SRLI/SRAI
    //110: OR,ORI
    //111: AND,ANDI

    always @(*) begin
        case(op)
            ALU_ADD:
                aluOut <= aluIn1 + aluIn2;
            ALU_SUB:
                aluOut <= aluIn1 - aluIn2;
            ALU_SLL:
                aluOut <= aluIn1 << aluIn2;
            ALU_SLT:
                aluOut <= $signed(aluIn1) < $signed(aluIn2);
            ALU_SLTU:
                aluOut <= aluIn1 < aluIn2;
            ALU_XOR:
                aluOut <= aluIn1 ^ aluIn2;
            ALU_SRL:
                aluOut <= aluIn1 >> aluIn2;
            ALU_SRA:
                aluOut <= aluIn1 >>> aluIn2;
            ALU_OR:
                aluOut <= aluIn1 | aluIn2;
            ALU_AND:
                aluOut <= aluIn1 & aluIn2;
            default:
                aluOut <= 0;
        endcase
   end

    assign EQ = aluOut == 0;
    assign LT = $signed(aluOut) < 0;
    assign LTU = aluOut < 0;
endmodule
