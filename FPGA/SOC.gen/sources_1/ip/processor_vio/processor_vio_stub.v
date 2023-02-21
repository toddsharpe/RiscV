// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Feb 20 22:35:53 2023
// Host        : tsharpe-5950x running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/todds/GitHub/toddsharpe/RiscV/FPGA/SOC.gen/sources_1/ip/processor_vio/processor_vio_stub.v
// Design      : processor_vio
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2022.2" *)
module processor_vio(clk, probe_in0, probe_in1, probe_in2, probe_in3, 
  probe_in4, probe_in5, probe_in6, probe_in7, probe_in8, probe_in9)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[2:0],probe_in1[0:0],probe_in2[31:0],probe_in3[0:0],probe_in4[31:0],probe_in5[0:0],probe_in6[31:0],probe_in7[0:0],probe_in8[31:0],probe_in9[3:0]" */;
  input clk;
  input [2:0]probe_in0;
  input [0:0]probe_in1;
  input [31:0]probe_in2;
  input [0:0]probe_in3;
  input [31:0]probe_in4;
  input [0:0]probe_in5;
  input [31:0]probe_in6;
  input [0:0]probe_in7;
  input [31:0]probe_in8;
  input [3:0]probe_in9;
endmodule
