-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Mon Feb 27 14:40:03 2023
-- Host        : tsharpe-5950x running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/todds/GitHub/toddsharpe/RiscV/FPGA/SOC.gen/sources_1/ip/decoder_vio/decoder_vio_stub.vhdl
-- Design      : decoder_vio
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_vio is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    probe_in2 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    probe_in3 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    probe_in4 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in5 : in STD_LOGIC_VECTOR ( 6 downto 0 )
  );

end decoder_vio;

architecture stub of decoder_vio is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[31:0],probe_in1[4:0],probe_in2[4:0],probe_in3[4:0],probe_in4[2:0],probe_in5[6:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2022.2";
begin
end;