`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2023 10:00:11 PM
// Design Name: 
// Module Name: BranchCalc
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

module BranchCalc(
    input [2:0] branchOp,
    input EQ,
    input LT,
    input LTU,
    output reg takeBranch
);

    // The predicate for branch instructions
    always_comb
        case(branchOp)
            B_EQ: takeBranch <= EQ;
            B_NE: takeBranch <= !EQ;
            B_LT: takeBranch <= LT;
            B_GE: takeBranch <= !LT;
            B_LTU: takeBranch <= LTU;
            B_GEU: takeBranch <= !LTU;
            default: takeBranch <= 1'b0;
        endcase

endmodule
