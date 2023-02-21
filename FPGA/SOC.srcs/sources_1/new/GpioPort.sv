`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2023 10:55:39 PM
// Design Name: 
// Module Name: GpioPort
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


module GpioPort(
    input clk,
    input cpu_clk,
    input reset,
    input enable,
    input [15:0] data_in,
    output reg [15:0] data_out
);

    always @(posedge cpu_clk)
    begin
        if (reset)
        begin
            data_out <= 16'b0;
        end
        else if (enable)
        begin
            data_out <= data_in;
        end
    end

endmodule
