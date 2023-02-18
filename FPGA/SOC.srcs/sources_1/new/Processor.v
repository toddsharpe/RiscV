`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 10:26:41 AM
// Design Name: 
// Module Name: Processor
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


module Processor(
    input clk,
    input reset,
    output [31:0] mem_addr,
    input [31:0] mem_rdata,
    output mem_rstrb,
    output [31:0] mem_wdata,
    output [3:0] mem_wmask
);

    //Program counter
    wire [31:1] PC;

    //Instruction register
    reg [31:0] instr;

    //Decoder signals
    wire isLUI;
    wire isAUIPC;
    wire isJAL;
    wire isJALR;
    wire isBranch;
    wire isLoad;
    wire isStore;
    wire isALUimm;
    wire isALUreg;
    wire isSYSTEM;

    //Register select signals
    wire [4:0] rs1Id;
    wire [4:0] rs2Id;
    wire [4:0] rdId;

    //Selected Registers
    wire [31:0] rd1;
    wire [31:0] rd2;

    //Alu signals
    wire aluOp;
    wire alu2Sel;
    wire [31:0] alu2Imm;
    wire EQ;
    wire LT;
    wire LTU;
    wire [31:0] aluIn1;
    wire [31:0] aluIn2;
    wire [31:0] aluOut;

    //PC calculation
    wire [31:0] pcImm;

    //Register file
    RegisterFile registers(
        .clk(clk),
        .reset(reset),
        .rs1Id(rs1Id),
        .rs2Id(rs2Id),
        .rdId(rdId),
        .writeback(),
        .DATA(),
        .rd1(rd1),
        .rd2(rd2)
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

    //Branch control
    wire takeBranch;
    BranchCalc branch(
        .branchOp(branchOp),
        .EQ(EQ),
        .LT(LT),
        .LTU(LTU),
        .takeBranch(takeBranch)
    );

    //Program counter
    wire [2:0] pcOp = ((isBranch && takeBranch) || isJAL) ? PC_REL :
                                                   isJALR ? PC_ABS :
                                                   PC_NEXT;
    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .pcOp(pcOp),
        .pcImm(pcImm),
        .pcAbsolute({aluOut[31:1],1'b0}),
        .PC(PC)
    );

    //ALU
    assign aluIn1 = rd1;
    assign aluIn2 = alu2Sel ? rd2 : alu2Imm;
    ALU alu(
        .op(aluControl),
        .aluIn1(aluIn1),
        .aluIn2(aluIn2),
        .aluOut(aluOut),
        .EQ(EQ),
        .LT(LT),
        .LTU(LTU)
    );

endmodule
