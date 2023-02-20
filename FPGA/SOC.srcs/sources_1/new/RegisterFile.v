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
    input cpu_clk,
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

    //VIO
    //Register file_vio
    registerfile_vio register_vio(
        .clk(clk),
        .probe_in0(REGISTERS[0]),
        .probe_in1(REGISTERS[1]),
        .probe_in2(REGISTERS[2]),
        .probe_in3(REGISTERS[3]),
        .probe_in4(REGISTERS[4]),
        .probe_in5(REGISTERS[5]),
        .probe_in6(REGISTERS[6]),
        .probe_in7(REGISTERS[7]),
        .probe_in8(REGISTERS[8]),
        .probe_in9(REGISTERS[9]),
        .probe_in10(REGISTERS[10]),
        .probe_in11(REGISTERS[11]),
        .probe_in12(REGISTERS[12]),
        .probe_in13(REGISTERS[13]),
        .probe_in14(REGISTERS[14]),
        .probe_in15(REGISTERS[15]),
        .probe_in16(REGISTERS[16]),
        .probe_in17(REGISTERS[17]),
        .probe_in18(REGISTERS[18]),
        .probe_in19(REGISTERS[19]),
        .probe_in20(REGISTERS[20]),
        .probe_in21(REGISTERS[21]),
        .probe_in22(REGISTERS[22]),
        .probe_in23(REGISTERS[23]),
        .probe_in24(REGISTERS[24]),
        .probe_in25(REGISTERS[25]),
        .probe_in26(REGISTERS[26]),
        .probe_in27(REGISTERS[27]),
        .probe_in28(REGISTERS[28]),
        .probe_in29(REGISTERS[29]),
        .probe_in30(REGISTERS[30]),
        .probe_in31(REGISTERS[031])
    );

    //Initialize
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            REGISTERS[i] = 0;
        end
    end

    //Writeback
    always @(posedge cpu_clk) begin
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
