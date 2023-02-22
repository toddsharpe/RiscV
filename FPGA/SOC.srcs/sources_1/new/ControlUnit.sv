`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2023 10:14:13 PM
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [31:0] instr,
    input [31:0] pc
);

    //Decoder
    Decoder decoder(
        .instr(instr),
        .rs1Id(rs1Id),
        .rs2Id(rs2Id),
        .rdId(rdId),
        .aluOp(aluOp),
        .alu2Sel(alu2Sel),
        .alu2Imm(alu2Imm),

        .pcImm(pcImm),
        .branchOp(branchOp),

        .storeImm(storeImm),

        .isLUI(isLUI),
        .isAUIPC(isAUIPC),
        .isJAL(isJAL),
        .isJALR(isJALR),
        .isBranch(isBranch),
        .isLoad(isLoad),
        .isStore(isStore),
        .isALUimm(isALUimm),
        .isALUreg(isALUreg),
        .isSYSTEM(isSYSTEM)
    );
endmodule
