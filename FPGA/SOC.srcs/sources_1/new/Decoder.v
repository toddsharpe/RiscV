`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2023 09:11:55 PM
// Design Name: 
// Module Name: Decoder
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

//SPEC: Docs\RiscV\riscv-spec-20191213.pdf
module Decoder(
    input [31:0] instr,

    //Register selects
    output [4:0] rs1Id,
    output [4:0] rs2Id,
    output [4:0] rdId,

    //ALU signals
    output [3:0] aluOp,
    output alu2Sel,//1: aluIn2 = rs2; 0: aluIn2 = imm
    output [31:0] alu2Imm,

    //PC signals
    output [31:0] pcImm,
    output [2:0] branchOp,

    //Control Signals
    output isLUI,
    output isAUIPC,
    output isJAL,
    output isJALR,
    output isBranch,
    output isLoad,
    output isStore,
    output isALUimm,
    output isALUreg,
    output isSYSTEM
);

    wire [6:0] opcode;

    //SPEC: P130. The 10 RISC-V instructions
    assign opcode = instr[6:0];
    assign isLUI     =  (opcode == 7'b0110111); // rd <- Uimm
    assign isAUIPC   =  (opcode == 7'b0010111); // rd <- PC + Uimm
    assign isJAL     =  (opcode == 7'b1101111); // rd <- PC+4; PC<-PC+Jimm
    assign isJALR    =  (opcode == 7'b1100111); // rd <- PC+4; PC<-rs1+Iimm
    assign isBranch  =  (opcode == 7'b1100011); // if(rs1 OP rs2) PC<-PC+Bimm
    assign isLoad    =  (opcode == 7'b0000011); // rd <- mem[rs1+Iimm]
    assign isStore   =  (opcode == 7'b0100011); // mem[rs1+Simm] <- rs2
    assign isALUimm  =  (opcode == 7'b0010011); // rd <- rs1 OP Iimm
    assign isALUreg  =  (opcode == 7'b0110011); // rd <- rs1 OP rs2
    assign isSYSTEM  =  (opcode == 7'b1110011); // special

    // The 5 immediate formats
    wire [31:0] Uimm={    instr[31],   instr[30:12], {12{1'b0}}};
    wire [31:0] Iimm={{21{instr[31]}}, instr[30:20]};
    wire [31:0] Simm={{21{instr[31]}}, instr[30:25],instr[11:7]};
    wire [31:0] Bimm={{20{instr[31]}}, instr[7],instr[30:25],instr[11:8],1'b0};
    wire [31:0] Jimm={{12{instr[31]}}, instr[19:12],instr[20],instr[30:21],1'b0};

    //SPEC: P130. Register selects
    assign rs1Id = instr[19:15];
    assign rs2Id = instr[24:20];
    assign rdId  = instr[11:7];

    //SPEC: P130. Function3/7 selects
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];

    function [3:0] AluOpSelect(input [2:0] func, input isSub, input isA);
        begin
            case(func)
            3'b000: AluOpSelect = isSub ? ALU_SUB : ALU_ADD;
            3'b001: AluOpSelect = ALU_SLL;
            3'b010: AluOpSelect = ALU_SLT;
            3'b011: AluOpSelect = ALU_SLTU;
            3'b100: AluOpSelect = ALU_XOR;
            3'b101: AluOpSelect = isA ? ALU_SRA : ALU_SRL;
            3'b110: AluOpSelect = ALU_OR;
            3'b111: AluOpSelect = ALU_AND;
            endcase
        end
    endfunction : AluOpSelect;

    // The ALU
    //isSub: funct7[5] selects add/sub, instr[5] ensures this is unsigned (vs ADDI which is signed).
    wire isSub = funct7[5] & instr[5];
    wire isA = funct7[5];
    assign aluOp = AluOpSelect(funct3, isSub, isA);
    assign alu2Sel = isALUreg | isBranch;
    assign alu2Imm = Iimm;

    // Address computation
    // An adder used to compute branch address, JAL address and AUIPC.
    // branch->PC+Bimm    AUIPC->PC+Uimm    JAL->PC+Jimm
    // Equivalent to PCplusImm = PC + (isJAL ? Jimm : isAUIPC ? Uimm : Bimm)
    assign pcImm = (isJAL ? Jimm[31:0] :
                        isAUIPC ? Uimm[31:0] :
                                  Bimm[31:0] );
    assign branchOp = funct3;
    

endmodule
