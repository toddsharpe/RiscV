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
    input cpu_clk,
    input reset,
    output halt,
    output [31:0] mem_addr,
    input [31:0] mem_rdata,
    output mem_rstrb,
    output [31:0] mem_wdata,
    output [3:0] mem_wmask
);

    //Program counter
    wire [31:0] PC;

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
    wire [31:0] rs1;
    wire [31:0] rs2;
    wire regLatch;
    wire [31:0] regData;

    //Alu signals
    wire [3:0] aluOp;
    wire alu2Sel;
    wire [31:0] alu2Imm;
    wire EQ;
    wire LT;
    wire LTU;
    wire [31:0] aluIn1;
    wire [31:0] aluIn2;
    wire [31:0] aluOut;

    //PC calculation
    wire pcInc;
    wire [31:0] pcImm;
    wire [2:0] branchOp;

    //Store signals
    wire [31:0] storeImm;

    //Register file
    RegisterFile registers(
        .clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .rs1Id(rs1Id),
        .rs2Id(rs2Id),
        .rdId(rdId),
        .latch(regLatch),
        .dataIn(regData),
        .rs1(rs1),
        .rs2(rs2)
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

    //Decoder VIO
    decoder_vio decoder_vio (
        .clk(clk),              // input wire clk
        .probe_in0(instr),  // input wire [31 : 0] probe_in0
        .probe_in1(rs1Id),  // input wire [4 : 0] probe_in1
        .probe_in2(rs2Id),  // input wire [4 : 0] probe_in2
        .probe_in3(rdId),  // input wire [4 : 0] probe_in3
        .probe_in4(aluOp),  // input wire [3 : 0] probe_in4
        .probe_in5(alu2Sel),  // input wire [0 : 0] probe_in5
        .probe_in6(alu2Imm),  // input wire [31 : 0] probe_in6
        .probe_in7(pcImm),  // input wire [31 : 0] probe_in7
        .probe_in8(branchOp)  // input wire [2 : 0] probe_in8
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

    branchcalc_vio branchcalc_vio (
        .clk(clk),              // input wire clk
        .probe_in0(branchOp),  // input wire [2 : 0] probe_in0
        .probe_in1(EQ),  // input wire [0 : 0] probe_in1
        .probe_in2(LT),  // input wire [0 : 0] probe_in2
        .probe_in3(LTU),  // input wire [0 : 0] probe_in3
        .probe_in4(takeBranch)  // input wire [0 : 0] probe_in4
    );

    //Program counter
    wire [2:0] pcOp = ((isBranch && takeBranch) || isJAL) ? PC_REL :
                                                   isJALR ? PC_ABS :
                                                   PC_NEXT;
    wire [31:0] pcAbsolute = {aluOut[31:1],1'b0};
    ProgramCounter pc(
        //.clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .inc(pcInc),
        .pcOp(pcOp),
        .pcImm(pcImm),
        .pcAbsolute(pcAbsolute),
        .PC(PC)
    );

    //Program counter VIO
    programcounter_vio programcounter_vio (
        .clk(clk),              // input wire clk
        .probe_in0(pcInc),  // input wire [0 : 0] probe_in0
        .probe_in1(pcOp),  // input wire [2 : 0] probe_in1
        .probe_in2(pcImm),  // input wire [31 : 0] probe_in2
        .probe_in3(pcAbsolute),  // input wire [31 : 0] probe_in3
        .probe_in4(PC)  // input wire [31 : 0] probe_in4
    );

    //ALU
    assign aluIn1 = rs1;
    assign aluIn2 = alu2Sel ? rs2 : alu2Imm;
    ALU alu(
        .op(aluOp),
        .aluIn1(aluIn1),
        .aluIn2(aluIn2),
        .aluOut(aluOut),
        .EQ(EQ),
        .LT(LT),
        .LTU(LTU)
    );

    //ALU VIO
    alu_vio alu_vio (
        .clk(clk),              // input wire clk
        .probe_in0(aluOp),  // input wire [3 : 0] probe_in0
        .probe_in1(aluIn1),  // input wire [31 : 0] probe_in1
        .probe_in2(aluIn2),  // input wire [31 : 0] probe_in2
        .probe_in3(aluOut),  // input wire [31 : 0] probe_in3
        .probe_in4(EQ),  // input wire [0 : 0] probe_in4
        .probe_in5(LT),  // input wire [0 : 0] probe_in5
        .probe_in6(LTU)  // input wire [0 : 0] probe_in6
    );

    wire mem_byteAccess     = branchOp[1:0] == 2'b00;
    wire mem_halfwordAccess = branchOp[1:0] == 2'b01;

    //Load
    wire [15:0] LOAD_halfword =
	       loadstore_addr[1] ? mem_rdata[31:16] : mem_rdata[15:0];

   wire  [7:0] LOAD_byte =
	       loadstore_addr[0] ? LOAD_halfword[15:8] : LOAD_halfword[7:0];

wire LOAD_sign =
	!branchOp[2] & (mem_byteAccess ? LOAD_byte[7] : LOAD_halfword[15]);

   wire [31:0] LOAD_data =
         mem_byteAccess ? {{24{LOAD_sign}},     LOAD_byte} :
     mem_halfwordAccess ? {{16{LOAD_sign}}, LOAD_halfword} :
                          mem_rdata ;

    //Stores
    wire [31:0] loadstore_addr = rs1 + storeImm;
    assign mem_wdata[ 7: 0] = rs2[7:0];
    assign mem_wdata[15: 8] = loadstore_addr[0] ? rs2[7:0]  : rs2[15: 8];
    assign mem_wdata[23:16] = loadstore_addr[1] ? rs2[7:0]  : rs2[23:16];
    assign mem_wdata[31:24] = loadstore_addr[0] ? rs2[7:0]  : loadstore_addr[1] ? rs2[15:8] : rs2[31:24];

    //
    // The memory write mask:
   //    1111                     if writing a word
   //    0011 or 1100             if writing a halfword
   //                                (depending on loadstore_addr[1])
   //    0001, 0010, 0100 or 1000 if writing a byte
   //                                (depending on loadstore_addr[1:0])

   wire [3:0] STORE_wmask =
	      mem_byteAccess      ?
	            (loadstore_addr[1] ?
		          (loadstore_addr[0] ? 4'b1000 : 4'b0100) :
		          (loadstore_addr[0] ? 4'b0010 : 4'b0001)
                    ) :
	      mem_halfwordAccess ?
	            (loadstore_addr[1] ? 4'b1100 : 4'b0011) :
              4'b1111;

    //State machine
    localparam FETCH_INSTR = 0;
    localparam WAIT_INSTR  = 1;
    localparam EXECUTE     = 2;
    localparam LOAD        = 3;
   localparam WAIT_DATA   = 4;
   localparam STORE       = 5;
    reg [2:0] state = FETCH_INSTR;

    always @(posedge cpu_clk) begin
        if(reset) begin
            state <= FETCH_INSTR;
        end else begin
            case(state)
                FETCH_INSTR: begin
                    state <= WAIT_INSTR;
                end
                WAIT_INSTR: begin
                    instr <= mem_rdata;
                    state <= EXECUTE;
                end
                EXECUTE: begin
                    state <= isLoad  ? LOAD  : 
                            isStore ? STORE : 
		                    FETCH_INSTR;
                end
                LOAD: begin
                    state <= WAIT_DATA;
                end
                WAIT_DATA: begin
                    state <= FETCH_INSTR;
                end
                STORE: begin
                    state <= FETCH_INSTR;
                end
            endcase
        end
    end

    assign mem_addr = (state == WAIT_INSTR || state == FETCH_INSTR) ? PC : loadstore_addr ;
    assign mem_rstrb = (state == FETCH_INSTR || state == LOAD);
    assign mem_wmask = {4{(state == STORE)}} & STORE_wmask;

    assign pcInc = (state == EXECUTE);
    assign regLatch = (state==EXECUTE && !isBranch && !isStore && !isLoad) ||
			(state==WAIT_DATA);

    wire [31:0] PCplusImm = PC + pcImm;
    wire [31:0] PCplus4 = PC + 4;

    assign regData = (isJAL || isJALR) ? PCplus4   :
			      isLUI         ? Uimm      :
			      isAUIPC       ? PCplusImm :
			      isLoad        ? LOAD_data :
			                      aluOut;
    assign halt = isSYSTEM;

    //Processor VIO
    processor_vio processor_vio (
        .clk(clk),              // input wire clk
        .probe_in0(state),  // input wire [2 : 0] probe_in0
        .probe_in1(pcInc),  // input wire [0 : 0] probe_in1
        .probe_in2(regData),  // input wire [31 : 0] probe_in2
        .probe_in3(regLatch),  // input wire [0 : 0] probe_in3
        .probe_in4(mem_addr),  // input wire [31 : 0] probe_in4
        .probe_in5(mem_rstrb),  // input wire [0 : 0] probe_in5
        .probe_in6(mem_rdata),  // input wire [31 : 0] probe_in6
        .probe_in7(halt),  // input wire [0 : 0] probe_in7
        .probe_in8(mem_wdata),  // input wire [31 : 0] probe_in8
        .probe_in9(mem_wmask)  // input wire [3 : 0] probe_in9
    );

endmodule
