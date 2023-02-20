-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Sun Feb 19 11:56:54 2023
-- Host        : tsharpe-5950x running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top registerfile_vio -prefix
--               registerfile_vio_ registerfile_vio_stub.vhdl
-- Design      : registerfile_vio
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registerfile_vio is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in4 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in5 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in6 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in7 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in8 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in9 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in10 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in11 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in12 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in13 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in14 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in15 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in16 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in17 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in18 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in19 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in20 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in21 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in22 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in23 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in24 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in25 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in26 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in27 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in28 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in29 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in30 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in31 : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end registerfile_vio;

architecture stub of registerfile_vio is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[31:0],probe_in1[31:0],probe_in2[31:0],probe_in3[31:0],probe_in4[31:0],probe_in5[31:0],probe_in6[31:0],probe_in7[31:0],probe_in8[31:0],probe_in9[31:0],probe_in10[31:0],probe_in11[31:0],probe_in12[31:0],probe_in13[31:0],probe_in14[31:0],probe_in15[31:0],probe_in16[31:0],probe_in17[31:0],probe_in18[31:0],probe_in19[31:0],probe_in20[31:0],probe_in21[31:0],probe_in22[31:0],probe_in23[31:0],probe_in24[31:0],probe_in25[31:0],probe_in26[31:0],probe_in27[31:0],probe_in28[31:0],probe_in29[31:0],probe_in30[31:0],probe_in31[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2022.2";
begin
end;
