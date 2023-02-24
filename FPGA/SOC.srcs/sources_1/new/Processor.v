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

    //Registers
    reg [31:0] pc;
    reg [31:0] instr;

    //Register signals
    wire [4:0] rs1Id;
    wire [4:0] rs2Id;
    wire [4:0] rdId;
    wire regLatch;
    wire [31:0] regIn;
    wire [31:0] rs1;
    wire [31:0] rs2;

    //Register file
    RegisterFile registers(
        .clk(clk),
        .cpu_clk(cpu_clk),
        .reset(reset),
        .rs1Id(rs1Id),
        .rs2Id(rs2Id),
        .rdId(rdId),
        .latch(regLatch),
        .dataIn(regIn),
        .rs1(rs1),
        .rs2(rs2)
    );

    //Control signals
    wire [31:0] pcIn;
    wire controlRegLatch;
    wire [31:0] loadstore_addr;
    wire [3:0] STORE_wmask;
    wire isLoad;
    wire isStore;

    //ControlUnit
    ControlUnit controlUnit(
        .clk(clk),
        .instr(instr),
        .rs1(rs1),
        .rs2(rs2),
        .pc(pc),
        .mem_rdata(mem_rdata),
        .rs1Id(rs1Id),
        .rs2Id(rs2Id),
        .rdId(rdId),
        .regLatch(controlRegLatch),
        .regIn(regIn),
        .pcIn(pcIn),
        .loadstore_addr(loadstore_addr),
        .mem_wdata(mem_wdata),
        .STORE_wmask(STORE_wmask),
        .isLoad(isLoad),
        .isStore(isStore),
        .halt(halt)
    );

    //State machine states
    localparam FETCH_INSTR = 0;
    localparam WAIT_INSTR  = 1;
    localparam EXECUTE     = 2;
    localparam LOAD        = 3;
    localparam WAIT_DATA   = 4;
    localparam STORE       = 5;

    //Drive state machine
    reg [2:0] state = FETCH_INSTR;
    always @(posedge cpu_clk) begin
        if(reset) begin
            state <= FETCH_INSTR;
            pc <= 32'h0;
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
                    pc <= pcIn;
                    state <= isLoad ? LOAD : isStore ? STORE : FETCH_INSTR;
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

    assign mem_addr = (state == WAIT_INSTR || state == FETCH_INSTR) ? pc : loadstore_addr ;
    assign mem_rstrb = (state == FETCH_INSTR || state == LOAD);
    assign mem_wmask = {4{(state == STORE)}} & STORE_wmask;
    assign regLatch = (state==EXECUTE && controlRegLatch) || (state==WAIT_DATA);

    //VIO
    processor_vio processor_vio (
        .clk(clk),              // input wire clk
        .probe_in0(state),  // input wire [2 : 0] probe_in0
        .probe_in1(pc),  // input wire [31 : 0] probe_in1
        .probe_in2(mem_addr),  // input wire [31 : 0] probe_in2
        .probe_in3(mem_rdata),  // input wire [31 : 0] probe_in3
        .probe_in4(mem_rstrb),  // input wire [0 : 0] probe_in4
        .probe_in5(mem_wdata),  // input wire [31 : 0] probe_in5
        .probe_in6(mem_wmask),  // input wire [3 : 0] probe_in6
        .probe_in7(regLatch),  // input wire [0 : 0] probe_in7
        .probe_in8(regIn),  // input wire [31 : 0] probe_in8
        .probe_in9(instr)  // input wire [31 : 0] probe_in9
    );

endmodule
