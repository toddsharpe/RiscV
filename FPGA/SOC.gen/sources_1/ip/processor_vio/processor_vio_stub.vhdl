-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Thu Feb 23 10:33:16 2023
-- Host        : tsharpe-surface running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/todds/GitHub/toddsharpe/RiscV/FPGA/SOC.gen/sources_1/ip/processor_vio/processor_vio_stub.vhdl
-- Design      : processor_vio
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity processor_vio is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in5 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in6 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_in7 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in8 : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end processor_vio;

architecture stub of processor_vio is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[2:0],probe_in1[31:0],probe_in2[31:0],probe_in3[31:0],probe_in4[0:0],probe_in5[31:0],probe_in6[3:0],probe_in7[0:0],probe_in8[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2022.2";
begin
end;
