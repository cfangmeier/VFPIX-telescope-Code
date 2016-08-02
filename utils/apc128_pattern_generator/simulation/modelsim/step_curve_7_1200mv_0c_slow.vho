-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Full Version"

-- DATE "01/30/2015 15:01:02"

-- 
-- Device: Altera EP3C120F780C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	step_curve_top IS
    PORT (
	SEB : OUT std_logic;
	clk : IN std_logic;
	reset_gen : IN std_logic;
	IS1 : OUT std_logic;
	IS2 : OUT std_logic;
	SR : OUT std_logic;
	CS : OUT std_logic;
	gnd1 : OUT std_logic;
	gnd2 : OUT std_logic;
	CAL : OUT std_logic;
	SBI : OUT std_logic;
	SPHI1 : OUT std_logic;
	SPHI2 : OUT std_logic;
	RESET : OUT std_logic;
	R12 : OUT std_logic;
	LE : OUT std_logic;
	RPHI2 : OUT std_logic;
	RPHI1 : OUT std_logic;
	RBI : OUT std_logic;
	reset_gen_out : OUT std_logic
	);
END step_curve_top;

-- Design Ports Information
-- SEB	=>  Location: PIN_M8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- IS1	=>  Location: PIN_T4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- IS2	=>  Location: PIN_U3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- SR	=>  Location: PIN_T3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- CS	=>  Location: PIN_R3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- gnd1	=>  Location: PIN_Y4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- gnd2	=>  Location: PIN_U1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- CAL	=>  Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- SBI	=>  Location: PIN_V2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- SPHI1	=>  Location: PIN_M7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- SPHI2	=>  Location: PIN_V1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- RESET	=>  Location: PIN_Y3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- R12	=>  Location: PIN_U4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LE	=>  Location: PIN_V3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- RPHI2	=>  Location: PIN_W1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- RPHI1	=>  Location: PIN_R4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- RBI	=>  Location: PIN_W2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- reset_gen_out	=>  Location: PIN_R1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- reset_gen	=>  Location: PIN_AD7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- clk	=>  Location: PIN_AH15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF step_curve_top IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_SEB : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset_gen : std_logic;
SIGNAL ww_IS1 : std_logic;
SIGNAL ww_IS2 : std_logic;
SIGNAL ww_SR : std_logic;
SIGNAL ww_CS : std_logic;
SIGNAL ww_gnd1 : std_logic;
SIGNAL ww_gnd2 : std_logic;
SIGNAL ww_CAL : std_logic;
SIGNAL ww_SBI : std_logic;
SIGNAL ww_SPHI1 : std_logic;
SIGNAL ww_SPHI2 : std_logic;
SIGNAL ww_RESET : std_logic;
SIGNAL ww_R12 : std_logic;
SIGNAL ww_LE : std_logic;
SIGNAL ww_RPHI2 : std_logic;
SIGNAL ww_RPHI1 : std_logic;
SIGNAL ww_RBI : std_logic;
SIGNAL ww_reset_gen_out : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \SEB~output_o\ : std_logic;
SIGNAL \IS1~output_o\ : std_logic;
SIGNAL \IS2~output_o\ : std_logic;
SIGNAL \SR~output_o\ : std_logic;
SIGNAL \CS~output_o\ : std_logic;
SIGNAL \gnd1~output_o\ : std_logic;
SIGNAL \gnd2~output_o\ : std_logic;
SIGNAL \CAL~output_o\ : std_logic;
SIGNAL \SBI~output_o\ : std_logic;
SIGNAL \SPHI1~output_o\ : std_logic;
SIGNAL \SPHI2~output_o\ : std_logic;
SIGNAL \RESET~output_o\ : std_logic;
SIGNAL \R12~output_o\ : std_logic;
SIGNAL \LE~output_o\ : std_logic;
SIGNAL \RPHI2~output_o\ : std_logic;
SIGNAL \RPHI1~output_o\ : std_logic;
SIGNAL \RBI~output_o\ : std_logic;
SIGNAL \reset_gen_out~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~combout\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~COUT\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~combout\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~COUT\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~combout\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~COUT\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~combout\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~COUT\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~combout\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~COUT\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~combout\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~COUT\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita6~combout\ : std_logic;
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\ : std_logic;
SIGNAL \reset_gen~input_o\ : std_logic;
SIGNAL \inst|stage_iter[0]~16_combout\ : std_logic;
SIGNAL \inst|counter[0]~32_combout\ : std_logic;
SIGNAL \inst|Equal435~0_combout\ : std_logic;
SIGNAL \inst|counter[9]~52\ : std_logic;
SIGNAL \inst|counter[10]~53_combout\ : std_logic;
SIGNAL \inst|counter[10]~54\ : std_logic;
SIGNAL \inst|counter[11]~55_combout\ : std_logic;
SIGNAL \inst|counter[11]~56\ : std_logic;
SIGNAL \inst|counter[12]~57_combout\ : std_logic;
SIGNAL \inst|counter[12]~58\ : std_logic;
SIGNAL \inst|counter[13]~59_combout\ : std_logic;
SIGNAL \inst|counter[13]~60\ : std_logic;
SIGNAL \inst|counter[14]~61_combout\ : std_logic;
SIGNAL \inst|counter[14]~62\ : std_logic;
SIGNAL \inst|counter[15]~63_combout\ : std_logic;
SIGNAL \inst|counter[15]~64\ : std_logic;
SIGNAL \inst|counter[16]~65_combout\ : std_logic;
SIGNAL \inst|counter[16]~66\ : std_logic;
SIGNAL \inst|counter[17]~67_combout\ : std_logic;
SIGNAL \inst|counter[17]~68\ : std_logic;
SIGNAL \inst|counter[18]~69_combout\ : std_logic;
SIGNAL \inst|counter[18]~70\ : std_logic;
SIGNAL \inst|counter[19]~71_combout\ : std_logic;
SIGNAL \inst|counter[19]~72\ : std_logic;
SIGNAL \inst|counter[20]~73_combout\ : std_logic;
SIGNAL \inst|counter[20]~74\ : std_logic;
SIGNAL \inst|counter[21]~75_combout\ : std_logic;
SIGNAL \inst|counter[21]~76\ : std_logic;
SIGNAL \inst|counter[22]~77_combout\ : std_logic;
SIGNAL \inst|counter[22]~78\ : std_logic;
SIGNAL \inst|counter[23]~79_combout\ : std_logic;
SIGNAL \inst|counter[23]~80\ : std_logic;
SIGNAL \inst|counter[24]~81_combout\ : std_logic;
SIGNAL \inst|counter[24]~82\ : std_logic;
SIGNAL \inst|counter[25]~83_combout\ : std_logic;
SIGNAL \inst|SPHI1~77_combout\ : std_logic;
SIGNAL \inst|SPHI1~75_combout\ : std_logic;
SIGNAL \inst|SPHI1~76_combout\ : std_logic;
SIGNAL \inst|SPHI1~74_combout\ : std_logic;
SIGNAL \inst|SPHI1~78_combout\ : std_logic;
SIGNAL \inst|counter[25]~84\ : std_logic;
SIGNAL \inst|counter[26]~85_combout\ : std_logic;
SIGNAL \inst|counter[26]~86\ : std_logic;
SIGNAL \inst|counter[27]~87_combout\ : std_logic;
SIGNAL \inst|counter[27]~88\ : std_logic;
SIGNAL \inst|counter[28]~89_combout\ : std_logic;
SIGNAL \inst|counter[28]~90\ : std_logic;
SIGNAL \inst|counter[29]~91_combout\ : std_logic;
SIGNAL \inst|counter[29]~92\ : std_logic;
SIGNAL \inst|counter[30]~93_combout\ : std_logic;
SIGNAL \inst|counter[30]~94\ : std_logic;
SIGNAL \inst|counter[31]~95_combout\ : std_logic;
SIGNAL \inst|SPHI1~79_combout\ : std_logic;
SIGNAL \inst|SPHI1~80_combout\ : std_logic;
SIGNAL \inst|Equal430~0_combout\ : std_logic;
SIGNAL \inst|Equal435~1_combout\ : std_logic;
SIGNAL \inst|Equal436~2_combout\ : std_logic;
SIGNAL \inst|counter[3]~36_combout\ : std_logic;
SIGNAL \inst|counter[0]~33\ : std_logic;
SIGNAL \inst|counter[1]~34_combout\ : std_logic;
SIGNAL \inst|counter[1]~35\ : std_logic;
SIGNAL \inst|counter[2]~37_combout\ : std_logic;
SIGNAL \inst|counter[2]~38\ : std_logic;
SIGNAL \inst|counter[3]~39_combout\ : std_logic;
SIGNAL \inst|counter[3]~40\ : std_logic;
SIGNAL \inst|counter[4]~41_combout\ : std_logic;
SIGNAL \inst|counter[4]~42\ : std_logic;
SIGNAL \inst|counter[5]~43_combout\ : std_logic;
SIGNAL \inst|counter[5]~44\ : std_logic;
SIGNAL \inst|counter[6]~45_combout\ : std_logic;
SIGNAL \inst|counter[6]~46\ : std_logic;
SIGNAL \inst|counter[7]~47_combout\ : std_logic;
SIGNAL \inst|counter[7]~48\ : std_logic;
SIGNAL \inst|counter[8]~49_combout\ : std_logic;
SIGNAL \inst|counter[8]~50\ : std_logic;
SIGNAL \inst|counter[9]~51_combout\ : std_logic;
SIGNAL \inst|Equal4~3_combout\ : std_logic;
SIGNAL \inst|Equal4~4_combout\ : std_logic;
SIGNAL \inst|Equal29~0_combout\ : std_logic;
SIGNAL \inst|Equal3~2_combout\ : std_logic;
SIGNAL \inst|Equal440~0_combout\ : std_logic;
SIGNAL \inst|stage_iter[0]~17\ : std_logic;
SIGNAL \inst|stage_iter[1]~18_combout\ : std_logic;
SIGNAL \inst|stage_iter[1]~19\ : std_logic;
SIGNAL \inst|stage_iter[2]~20_combout\ : std_logic;
SIGNAL \inst|stage_iter[2]~21\ : std_logic;
SIGNAL \inst|stage_iter[3]~22_combout\ : std_logic;
SIGNAL \inst|stage_iter[3]~23\ : std_logic;
SIGNAL \inst|stage_iter[4]~24_combout\ : std_logic;
SIGNAL \inst|stage_iter[4]~25\ : std_logic;
SIGNAL \inst|stage_iter[5]~26_combout\ : std_logic;
SIGNAL \inst|stage_iter[5]~27\ : std_logic;
SIGNAL \inst|stage_iter[6]~28_combout\ : std_logic;
SIGNAL \inst|stage_iter[6]~29\ : std_logic;
SIGNAL \inst|stage_iter[7]~30_combout\ : std_logic;
SIGNAL \inst|stage_iter[15]~32_combout\ : std_logic;
SIGNAL \inst|stage_iter[15]~33_combout\ : std_logic;
SIGNAL \inst|Equal437~0_combout\ : std_logic;
SIGNAL \inst|stage_iter[7]~31\ : std_logic;
SIGNAL \inst|stage_iter[8]~34_combout\ : std_logic;
SIGNAL \inst|Equal437~1_combout\ : std_logic;
SIGNAL \inst|stage_iter[8]~35\ : std_logic;
SIGNAL \inst|stage_iter[9]~36_combout\ : std_logic;
SIGNAL \inst|stage_iter[9]~37\ : std_logic;
SIGNAL \inst|stage_iter[10]~38_combout\ : std_logic;
SIGNAL \inst|stage_iter[10]~39\ : std_logic;
SIGNAL \inst|stage_iter[11]~40_combout\ : std_logic;
SIGNAL \inst|stage_iter[11]~41\ : std_logic;
SIGNAL \inst|stage_iter[12]~42_combout\ : std_logic;
SIGNAL \inst|stage_iter[12]~43\ : std_logic;
SIGNAL \inst|stage_iter[13]~44_combout\ : std_logic;
SIGNAL \inst|stage_iter[13]~45\ : std_logic;
SIGNAL \inst|stage_iter[14]~46_combout\ : std_logic;
SIGNAL \inst|stage_iter[14]~47\ : std_logic;
SIGNAL \inst|stage_iter[15]~48_combout\ : std_logic;
SIGNAL \inst|Equal437~3_combout\ : std_logic;
SIGNAL \inst|Equal437~2_combout\ : std_logic;
SIGNAL \inst|Equal437~4_combout\ : std_logic;
SIGNAL \inst|stage~0_combout\ : std_logic;
SIGNAL \inst|stage~1_combout\ : std_logic;
SIGNAL \inst|Equal1~0_combout\ : std_logic;
SIGNAL \inst|Equal3~0_combout\ : std_logic;
SIGNAL \inst|Equal3~1_combout\ : std_logic;
SIGNAL \inst|SEB~4_combout\ : std_logic;
SIGNAL \inst|Equal4~0_combout\ : std_logic;
SIGNAL \inst|Equal428~0_combout\ : std_logic;
SIGNAL \inst|Equal6~0_combout\ : std_logic;
SIGNAL \inst|Equal428~1_combout\ : std_logic;
SIGNAL \inst|Equal4~1_combout\ : std_logic;
SIGNAL \inst|Equal135~0_combout\ : std_logic;
SIGNAL \inst|Equal4~2_combout\ : std_logic;
SIGNAL \inst|Equal2~0_combout\ : std_logic;
SIGNAL \inst|Equal2~1_combout\ : std_logic;
SIGNAL \inst|Equal2~2_combout\ : std_logic;
SIGNAL \inst|Equal1~1_combout\ : std_logic;
SIGNAL \inst|SEB~2_combout\ : std_logic;
SIGNAL \inst|SEB~3_combout\ : std_logic;
SIGNAL \inst|Equal392~0_combout\ : std_logic;
SIGNAL \inst|Equal309~0_combout\ : std_logic;
SIGNAL \inst|SEB~0_combout\ : std_logic;
SIGNAL \inst|Equal41~2_combout\ : std_logic;
SIGNAL \inst|Equal9~0_combout\ : std_logic;
SIGNAL \inst|Equal153~0_combout\ : std_logic;
SIGNAL \inst|Equal391~2_combout\ : std_logic;
SIGNAL \inst|SEB~1_combout\ : std_logic;
SIGNAL \inst|SEB~5_combout\ : std_logic;
SIGNAL \inst|SEB~q\ : std_logic;
SIGNAL \inst|ISSR~0_combout\ : std_logic;
SIGNAL \inst|ISSR~1_combout\ : std_logic;
SIGNAL \inst|ISSR~q\ : std_logic;
SIGNAL \inst|SPHI1~81_combout\ : std_logic;
SIGNAL \inst|Equal37~3_combout\ : std_logic;
SIGNAL \inst|Equal37~2_combout\ : std_logic;
SIGNAL \inst|Equal293~4_combout\ : std_logic;
SIGNAL \inst|CAL~0_combout\ : std_logic;
SIGNAL \inst|CAL~q\ : std_logic;
SIGNAL \inst|RBI~0_combout\ : std_logic;
SIGNAL \inst|Equal175~0_combout\ : std_logic;
SIGNAL \inst|Equal397~1_combout\ : std_logic;
SIGNAL \inst|Equal397~2_combout\ : std_logic;
SIGNAL \inst|SBI~6_combout\ : std_logic;
SIGNAL \inst|Equal6~1_combout\ : std_logic;
SIGNAL \inst|Equal229~1_combout\ : std_logic;
SIGNAL \inst|Equal262~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~20_combout\ : std_logic;
SIGNAL \inst|Equal245~0_combout\ : std_logic;
SIGNAL \inst|Equal143~0_combout\ : std_logic;
SIGNAL \inst|Equal17~0_combout\ : std_logic;
SIGNAL \inst|Equal394~0_combout\ : std_logic;
SIGNAL \inst|Equal264~0_combout\ : std_logic;
SIGNAL \inst|Equal8~2_combout\ : std_logic;
SIGNAL \inst|Equal136~3_combout\ : std_logic;
SIGNAL \inst|Equal3~3_combout\ : std_logic;
SIGNAL \inst|Equal8~0_combout\ : std_logic;
SIGNAL \inst|Equal8~1_combout\ : std_logic;
SIGNAL \inst|Equal101~0_combout\ : std_logic;
SIGNAL \inst|Equal134~0_combout\ : std_logic;
SIGNAL \inst|Equal6~2_combout\ : std_logic;
SIGNAL \inst|SBI~2_combout\ : std_logic;
SIGNAL \inst|SBI~3_combout\ : std_logic;
SIGNAL \inst|SBI~4_combout\ : std_logic;
SIGNAL \inst|SBI~5_combout\ : std_logic;
SIGNAL \inst|SBI~q\ : std_logic;
SIGNAL \inst|Equal363~2_combout\ : std_logic;
SIGNAL \inst|SPHI1~195_combout\ : std_logic;
SIGNAL \inst|SPHI1~84_combout\ : std_logic;
SIGNAL \inst|SPHI1~85_combout\ : std_logic;
SIGNAL \inst|Equal397~0_combout\ : std_logic;
SIGNAL \inst|Equal407~0_combout\ : std_logic;
SIGNAL \inst|Equal399~0_combout\ : std_logic;
SIGNAL \inst|Equal413~0_combout\ : std_logic;
SIGNAL \inst|Equal395~0_combout\ : std_logic;
SIGNAL \inst|Equal377~0_combout\ : std_logic;
SIGNAL \inst|Equal395~1_combout\ : std_logic;
SIGNAL \inst|Equal409~0_combout\ : std_logic;
SIGNAL \inst|Equal401~0_combout\ : std_logic;
SIGNAL \inst|Equal231~0_combout\ : std_logic;
SIGNAL \inst|Equal411~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~189_combout\ : std_logic;
SIGNAL \inst|SPHI1~190_combout\ : std_logic;
SIGNAL \inst|SPHI1~191_combout\ : std_logic;
SIGNAL \inst|SPHI1~187_combout\ : std_logic;
SIGNAL \inst|SPHI1~151_combout\ : std_logic;
SIGNAL \inst|SPHI1~188_combout\ : std_logic;
SIGNAL \inst|SPHI1~192_combout\ : std_logic;
SIGNAL \inst|SPHI2~21_combout\ : std_logic;
SIGNAL \inst|SPHI1~194_combout\ : std_logic;
SIGNAL \inst|SPHI1~82_combout\ : std_logic;
SIGNAL \inst|SPHI1~83_combout\ : std_logic;
SIGNAL \inst|Equal229~0_combout\ : std_logic;
SIGNAL \inst|Equal392~1_combout\ : std_logic;
SIGNAL \inst|SPHI1~88_combout\ : std_logic;
SIGNAL \inst|SPHI1~89_combout\ : std_logic;
SIGNAL \inst|Equal103~2_combout\ : std_logic;
SIGNAL \inst|Equal103~3_combout\ : std_logic;
SIGNAL \inst|Equal245~1_combout\ : std_logic;
SIGNAL \inst|Equal123~0_combout\ : std_logic;
SIGNAL \inst|Equal367~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~184_combout\ : std_logic;
SIGNAL \inst|Equal363~3_combout\ : std_logic;
SIGNAL \inst|SPHI1~207_combout\ : std_logic;
SIGNAL \inst|SPHI1~185_combout\ : std_logic;
SIGNAL \inst|Equal393~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~86_combout\ : std_logic;
SIGNAL \inst|SPHI1~208_combout\ : std_logic;
SIGNAL \inst|SPHI1~87_combout\ : std_logic;
SIGNAL \inst|Equal7~1_combout\ : std_logic;
SIGNAL \inst|Equal7~0_combout\ : std_logic;
SIGNAL \inst|Equal7~2_combout\ : std_logic;
SIGNAL \inst|Equal15~0_combout\ : std_logic;
SIGNAL \inst|Equal325~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~94_combout\ : std_logic;
SIGNAL \inst|SPHI1~196_combout\ : std_logic;
SIGNAL \inst|SPHI1~95_combout\ : std_logic;
SIGNAL \inst|Equal434~4_combout\ : std_logic;
SIGNAL \inst|Equal11~2_combout\ : std_logic;
SIGNAL \inst|Equal11~3_combout\ : std_logic;
SIGNAL \inst|Equal333~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~96_combout\ : std_logic;
SIGNAL \inst|Equal355~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~97_combout\ : std_logic;
SIGNAL \inst|Equal249~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~181_combout\ : std_logic;
SIGNAL \inst|SPHI1~182_combout\ : std_logic;
SIGNAL \inst|Equal9~1_combout\ : std_logic;
SIGNAL \inst|SPHI1~92_combout\ : std_logic;
SIGNAL \inst|SPHI1~90_combout\ : std_logic;
SIGNAL \inst|SPHI1~91_combout\ : std_logic;
SIGNAL \inst|SPHI1~93_combout\ : std_logic;
SIGNAL \inst|SPHI1~104_combout\ : std_logic;
SIGNAL \inst|SPHI1~204_combout\ : std_logic;
SIGNAL \inst|SPHI1~105_combout\ : std_logic;
SIGNAL \inst|Equal7~3_combout\ : std_logic;
SIGNAL \inst|Equal7~4_combout\ : std_logic;
SIGNAL \inst|SPHI1~98_combout\ : std_logic;
SIGNAL \inst|SPHI1~99_combout\ : std_logic;
SIGNAL \inst|Equal45~0_combout\ : std_logic;
SIGNAL \inst|Equal227~0_combout\ : std_logic;
SIGNAL \inst|Equal235~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~100_combout\ : std_logic;
SIGNAL \inst|SPHI1~101_combout\ : std_logic;
SIGNAL \inst|SPHI1~102_combout\ : std_logic;
SIGNAL \inst|SPHI1~103_combout\ : std_logic;
SIGNAL \inst|Equal285~0_combout\ : std_logic;
SIGNAL \inst|Equal279~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~175_combout\ : std_logic;
SIGNAL \inst|SPHI1~176_combout\ : std_logic;
SIGNAL \inst|Equal295~0_combout\ : std_logic;
SIGNAL \inst|Equal11~5_combout\ : std_logic;
SIGNAL \inst|SPHI1~177_combout\ : std_logic;
SIGNAL \inst|SPHI1~178_combout\ : std_logic;
SIGNAL \inst|SPHI1~179_combout\ : std_logic;
SIGNAL \inst|SPHI1~106_combout\ : std_logic;
SIGNAL \inst|SPHI1~107_combout\ : std_logic;
SIGNAL \inst|SPHI1~108_combout\ : std_logic;
SIGNAL \inst|SPHI1~109_combout\ : std_logic;
SIGNAL \inst|SPHI1~112_combout\ : std_logic;
SIGNAL \inst|SPHI2~22_combout\ : std_logic;
SIGNAL \inst|SPHI1~111_combout\ : std_logic;
SIGNAL \inst|SPHI1~113_combout\ : std_logic;
SIGNAL \inst|Equal231~1_combout\ : std_logic;
SIGNAL \inst|SPHI1~110_combout\ : std_logic;
SIGNAL \inst|SPHI1~197_combout\ : std_logic;
SIGNAL \inst|SPHI1~119_combout\ : std_logic;
SIGNAL \inst|Equal207~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~120_combout\ : std_logic;
SIGNAL \inst|SPHI1~116_combout\ : std_logic;
SIGNAL \inst|Equal3~4_combout\ : std_logic;
SIGNAL \inst|SPHI1~117_combout\ : std_logic;
SIGNAL \inst|SPHI1~198_combout\ : std_logic;
SIGNAL \inst|SPHI1~114_combout\ : std_logic;
SIGNAL \inst|SPHI1~115_combout\ : std_logic;
SIGNAL \inst|SPHI1~118_combout\ : std_logic;
SIGNAL \inst|Equal4~5_combout\ : std_logic;
SIGNAL \inst|Equal151~0_combout\ : std_logic;
SIGNAL \inst|Equal199~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~171_combout\ : std_logic;
SIGNAL \inst|Equal139~1_combout\ : std_logic;
SIGNAL \inst|Equal193~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~170_combout\ : std_logic;
SIGNAL \inst|Equal107~5_combout\ : std_logic;
SIGNAL \inst|SPHI1~168_combout\ : std_logic;
SIGNAL \inst|SPHI1~203_combout\ : std_logic;
SIGNAL \inst|SPHI1~169_combout\ : std_logic;
SIGNAL \inst|SPHI1~172_combout\ : std_logic;
SIGNAL \inst|SPHI1~121_combout\ : std_logic;
SIGNAL \inst|SPHI1~122_combout\ : std_logic;
SIGNAL \inst|SPHI1~199_combout\ : std_logic;
SIGNAL \inst|SPHI1~127_combout\ : std_logic;
SIGNAL \inst|SPHI1~128_combout\ : std_logic;
SIGNAL \inst|Equal53~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~205_combout\ : std_logic;
SIGNAL \inst|SPHI1~125_combout\ : std_logic;
SIGNAL \inst|SPHI1~123_combout\ : std_logic;
SIGNAL \inst|SPHI1~124_combout\ : std_logic;
SIGNAL \inst|SPHI1~126_combout\ : std_logic;
SIGNAL \inst|Equal107~4_combout\ : std_logic;
SIGNAL \inst|SPHI1~206_combout\ : std_logic;
SIGNAL \inst|Equal111~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~202_combout\ : std_logic;
SIGNAL \inst|Equal7~5_combout\ : std_logic;
SIGNAL \inst|Equal135~1_combout\ : std_logic;
SIGNAL \inst|SPHI1~164_combout\ : std_logic;
SIGNAL \inst|SPHI1~165_combout\ : std_logic;
SIGNAL \inst|SPHI1~133_combout\ : std_logic;
SIGNAL \inst|SPHI1~134_combout\ : std_logic;
SIGNAL \inst|SPHI1~135_combout\ : std_logic;
SIGNAL \inst|Equal139~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~129_combout\ : std_logic;
SIGNAL \inst|SPHI1~130_combout\ : std_logic;
SIGNAL \inst|SPHI1~131_combout\ : std_logic;
SIGNAL \inst|SPHI1~132_combout\ : std_logic;
SIGNAL \inst|SPHI1~139_combout\ : std_logic;
SIGNAL \inst|Equal103~4_combout\ : std_logic;
SIGNAL \inst|Equal83~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~140_combout\ : std_logic;
SIGNAL \inst|Equal99~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~138_combout\ : std_logic;
SIGNAL \inst|SPHI1~141_combout\ : std_logic;
SIGNAL \inst|SPHI2~24_combout\ : std_logic;
SIGNAL \inst|SPHI1~142_combout\ : std_logic;
SIGNAL \inst|SPHI1~143_combout\ : std_logic;
SIGNAL \inst|SPHI2~23_combout\ : std_logic;
SIGNAL \inst|SPHI1~136_combout\ : std_logic;
SIGNAL \inst|SPHI1~137_combout\ : std_logic;
SIGNAL \inst|SPHI1~149_combout\ : std_logic;
SIGNAL \inst|SPHI1~148_combout\ : std_logic;
SIGNAL \inst|SPHI1~150_combout\ : std_logic;
SIGNAL \inst|Equal29~1_combout\ : std_logic;
SIGNAL \inst|SPHI1~158_combout\ : std_logic;
SIGNAL \inst|SPHI1~201_combout\ : std_logic;
SIGNAL \inst|Equal43~0_combout\ : std_logic;
SIGNAL \inst|Equal45~1_combout\ : std_logic;
SIGNAL \inst|SPHI1~159_combout\ : std_logic;
SIGNAL \inst|SPHI1~160_combout\ : std_logic;
SIGNAL \inst|SPHI1~161_combout\ : std_logic;
SIGNAL \inst|SPHI1~155_combout\ : std_logic;
SIGNAL \inst|SPHI1~156_combout\ : std_logic;
SIGNAL \inst|Equal11~4_combout\ : std_logic;
SIGNAL \inst|Equal3~5_combout\ : std_logic;
SIGNAL \inst|SPHI1~154_combout\ : std_logic;
SIGNAL \inst|SPHI1~152_combout\ : std_logic;
SIGNAL \inst|SPHI1~153_combout\ : std_logic;
SIGNAL \inst|SPHI1~157_combout\ : std_logic;
SIGNAL \inst|Equal61~0_combout\ : std_logic;
SIGNAL \inst|Equal67~0_combout\ : std_logic;
SIGNAL \inst|SPHI1~200_combout\ : std_logic;
SIGNAL \inst|SPHI1~145_combout\ : std_logic;
SIGNAL \inst|SPHI1~146_combout\ : std_logic;
SIGNAL \inst|SPHI1~144_combout\ : std_logic;
SIGNAL \inst|SPHI1~147_combout\ : std_logic;
SIGNAL \inst|SPHI1~162_combout\ : std_logic;
SIGNAL \inst|SPHI1~163_combout\ : std_logic;
SIGNAL \inst|SPHI1~166_combout\ : std_logic;
SIGNAL \inst|SPHI1~167_combout\ : std_logic;
SIGNAL \inst|SPHI1~173_combout\ : std_logic;
SIGNAL \inst|SPHI1~174_combout\ : std_logic;
SIGNAL \inst|SPHI1~180_combout\ : std_logic;
SIGNAL \inst|SPHI1~183_combout\ : std_logic;
SIGNAL \inst|SPHI1~186_combout\ : std_logic;
SIGNAL \inst|SPHI1~193_combout\ : std_logic;
SIGNAL \inst|SPHI1~q\ : std_logic;
SIGNAL \inst|SPHI2~85_combout\ : std_logic;
SIGNAL \inst|SPHI2~86_combout\ : std_logic;
SIGNAL \inst|SPHI2~126_combout\ : std_logic;
SIGNAL \inst|Equal405~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~26_combout\ : std_logic;
SIGNAL \inst|SPHI2~25_combout\ : std_logic;
SIGNAL \inst|SPHI2~29_combout\ : std_logic;
SIGNAL \inst|SPHI2~28_combout\ : std_logic;
SIGNAL \inst|SPHI2~30_combout\ : std_logic;
SIGNAL \inst|SPHI2~27_combout\ : std_logic;
SIGNAL \inst|Equal405~1_combout\ : std_logic;
SIGNAL \inst|SPHI2~135_combout\ : std_logic;
SIGNAL \inst|SPHI2~136_combout\ : std_logic;
SIGNAL \inst|Equal13~0_combout\ : std_logic;
SIGNAL \inst|Equal149~3_combout\ : std_logic;
SIGNAL \inst|Equal369~4_combout\ : std_logic;
SIGNAL \inst|Equal149~2_combout\ : std_logic;
SIGNAL \inst|SPHI2~121_combout\ : std_logic;
SIGNAL \inst|SPHI2~122_combout\ : std_logic;
SIGNAL \inst|Equal249~1_combout\ : std_logic;
SIGNAL \inst|Equal117~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~123_combout\ : std_logic;
SIGNAL \inst|SPHI2~124_combout\ : std_logic;
SIGNAL \inst|Equal17~1_combout\ : std_logic;
SIGNAL \inst|SPHI2~31_combout\ : std_logic;
SIGNAL \inst|SPHI2~128_combout\ : std_logic;
SIGNAL \inst|SPHI2~32_combout\ : std_logic;
SIGNAL \inst|SPHI2~33_combout\ : std_logic;
SIGNAL \inst|SPHI2~34_combout\ : std_logic;
SIGNAL \inst|SPHI2~35_combout\ : std_logic;
SIGNAL \inst|SPHI2~133_combout\ : std_logic;
SIGNAL \inst|Equal37~4_combout\ : std_logic;
SIGNAL \inst|Equal25~0_combout\ : std_logic;
SIGNAL \inst|Equal17~2_combout\ : std_logic;
SIGNAL \inst|Equal13~2_combout\ : std_logic;
SIGNAL \inst|Equal57~2_combout\ : std_logic;
SIGNAL \inst|SPHI2~117_combout\ : std_logic;
SIGNAL \inst|SPHI2~118_combout\ : std_logic;
SIGNAL \inst|Equal237~2_combout\ : std_logic;
SIGNAL \inst|Equal241~2_combout\ : std_logic;
SIGNAL \inst|SPHI2~116_combout\ : std_logic;
SIGNAL \inst|SPHI2~119_combout\ : std_logic;
SIGNAL \inst|SPHI2~129_combout\ : std_logic;
SIGNAL \inst|SPHI2~130_combout\ : std_logic;
SIGNAL \inst|Equal317~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~36_combout\ : std_logic;
SIGNAL \inst|SPHI2~37_combout\ : std_logic;
SIGNAL \inst|Equal53~1_combout\ : std_logic;
SIGNAL \inst|SPHI2~38_combout\ : std_logic;
SIGNAL \inst|SPHI2~39_combout\ : std_logic;
SIGNAL \inst|SPHI2~40_combout\ : std_logic;
SIGNAL \inst|SPHI2~41_combout\ : std_logic;
SIGNAL \inst|SPHI2~42_combout\ : std_logic;
SIGNAL \inst|SPHI2~43_combout\ : std_logic;
SIGNAL \inst|SPHI2~44_combout\ : std_logic;
SIGNAL \inst|SPHI2~45_combout\ : std_logic;
SIGNAL \inst|SPHI2~46_combout\ : std_logic;
SIGNAL \inst|SPHI2~47_combout\ : std_logic;
SIGNAL \inst|SPHI2~48_combout\ : std_logic;
SIGNAL \inst|SPHI2~114_combout\ : std_logic;
SIGNAL \inst|SPHI2~49_combout\ : std_logic;
SIGNAL \inst|SPHI2~50_combout\ : std_logic;
SIGNAL \inst|Equal21~0_combout\ : std_logic;
SIGNAL \inst|Equal261~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~51_combout\ : std_logic;
SIGNAL \inst|SPHI2~56_combout\ : std_logic;
SIGNAL \inst|SPHI2~55_combout\ : std_logic;
SIGNAL \inst|SPHI2~131_combout\ : std_logic;
SIGNAL \inst|SPHI2~52_combout\ : std_logic;
SIGNAL \inst|SPHI2~53_combout\ : std_logic;
SIGNAL \inst|SPHI2~54_combout\ : std_logic;
SIGNAL \inst|SPHI2~57_combout\ : std_logic;
SIGNAL \inst|SPHI2~58_combout\ : std_logic;
SIGNAL \inst|Equal73~0_combout\ : std_logic;
SIGNAL \inst|Equal145~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~109_combout\ : std_logic;
SIGNAL \inst|Equal133~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~110_combout\ : std_logic;
SIGNAL \inst|SPHI2~111_combout\ : std_logic;
SIGNAL \inst|SPHI2~112_combout\ : std_logic;
SIGNAL \inst|SPHI2~59_combout\ : std_logic;
SIGNAL \inst|SPHI2~60_combout\ : std_logic;
SIGNAL \inst|Equal136~2_combout\ : std_logic;
SIGNAL \inst|SPHI2~65_combout\ : std_logic;
SIGNAL \inst|Equal181~0_combout\ : std_logic;
SIGNAL \inst|Equal113~0_combout\ : std_logic;
SIGNAL \inst|Equal41~4_combout\ : std_logic;
SIGNAL \inst|SPHI2~62_combout\ : std_logic;
SIGNAL \inst|Equal109~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~61_combout\ : std_logic;
SIGNAL \inst|SPHI2~63_combout\ : std_logic;
SIGNAL \inst|SPHI2~64_combout\ : std_logic;
SIGNAL \inst|SPHI2~72_combout\ : std_logic;
SIGNAL \inst|Equal137~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~73_combout\ : std_logic;
SIGNAL \inst|Equal105~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~105_combout\ : std_logic;
SIGNAL \inst|SPHI2~104_combout\ : std_logic;
SIGNAL \inst|SPHI2~103_combout\ : std_logic;
SIGNAL \inst|SPHI2~106_combout\ : std_logic;
SIGNAL \inst|SPHI2~69_combout\ : std_logic;
SIGNAL \inst|SPHI2~70_combout\ : std_logic;
SIGNAL \inst|SPHI2~66_combout\ : std_logic;
SIGNAL \inst|SPHI2~67_combout\ : std_logic;
SIGNAL \inst|SPHI2~68_combout\ : std_logic;
SIGNAL \inst|SPHI2~71_combout\ : std_logic;
SIGNAL \inst|SPHI2~74_combout\ : std_logic;
SIGNAL \inst|SPHI2~75_combout\ : std_logic;
SIGNAL \inst|SPHI2~76_combout\ : std_logic;
SIGNAL \inst|SPHI2~100_combout\ : std_logic;
SIGNAL \inst|SPHI2~101_combout\ : std_logic;
SIGNAL \inst|Equal101~1_combout\ : std_logic;
SIGNAL \inst|SPHI2~78_combout\ : std_logic;
SIGNAL \inst|Equal85~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~77_combout\ : std_logic;
SIGNAL \inst|SPHI2~132_combout\ : std_logic;
SIGNAL \inst|SPHI2~79_combout\ : std_logic;
SIGNAL \inst|Equal49~0_combout\ : std_logic;
SIGNAL \inst|SPHI2~95_combout\ : std_logic;
SIGNAL \inst|Equal29~2_combout\ : std_logic;
SIGNAL \inst|SPHI2~96_combout\ : std_logic;
SIGNAL \inst|Equal41~3_combout\ : std_logic;
SIGNAL \inst|SPHI2~97_combout\ : std_logic;
SIGNAL \inst|SPHI2~98_combout\ : std_logic;
SIGNAL \inst|SPHI2~87_combout\ : std_logic;
SIGNAL \inst|SPHI2~81_combout\ : std_logic;
SIGNAL \inst|SPHI2~82_combout\ : std_logic;
SIGNAL \inst|Equal61~1_combout\ : std_logic;
SIGNAL \inst|SPHI2~83_combout\ : std_logic;
SIGNAL \inst|Equal57~3_combout\ : std_logic;
SIGNAL \inst|SPHI2~80_combout\ : std_logic;
SIGNAL \inst|SPHI2~84_combout\ : std_logic;
SIGNAL \inst|SPHI2~88_combout\ : std_logic;
SIGNAL \inst|SPHI2~89_combout\ : std_logic;
SIGNAL \inst|Equal13~1_combout\ : std_logic;
SIGNAL \inst|Equal17~3_combout\ : std_logic;
SIGNAL \inst|SPHI2~90_combout\ : std_logic;
SIGNAL \inst|SPHI2~92_combout\ : std_logic;
SIGNAL \inst|Equal9~2_combout\ : std_logic;
SIGNAL \inst|SPHI2~93_combout\ : std_logic;
SIGNAL \inst|SPHI2~91_combout\ : std_logic;
SIGNAL \inst|SPHI2~94_combout\ : std_logic;
SIGNAL \inst|SPHI2~99_combout\ : std_logic;
SIGNAL \inst|SPHI2~102_combout\ : std_logic;
SIGNAL \inst|SPHI2~107_combout\ : std_logic;
SIGNAL \inst|SPHI2~108_combout\ : std_logic;
SIGNAL \inst|SPHI2~113_combout\ : std_logic;
SIGNAL \inst|SPHI2~115_combout\ : std_logic;
SIGNAL \inst|SPHI2~120_combout\ : std_logic;
SIGNAL \inst|SPHI2~134_combout\ : std_logic;
SIGNAL \inst|SPHI2~125_combout\ : std_logic;
SIGNAL \inst|SPHI2~127_combout\ : std_logic;
SIGNAL \inst|SPHI2~q\ : std_logic;
SIGNAL \inst|RESET~2_combout\ : std_logic;
SIGNAL \inst|RESET~0_combout\ : std_logic;
SIGNAL \inst|Equal5~0_combout\ : std_logic;
SIGNAL \inst|Equal5~1_combout\ : std_logic;
SIGNAL \inst|RESET~1_combout\ : std_logic;
SIGNAL \inst|RESET~3_combout\ : std_logic;
SIGNAL \inst|RESET~q\ : std_logic;
SIGNAL \inst|LE~1_combout\ : std_logic;
SIGNAL \inst|LE~0_combout\ : std_logic;
SIGNAL \inst|LE~2_combout\ : std_logic;
SIGNAL \inst|LE~q\ : std_logic;
SIGNAL \inst|Equal431~2_combout\ : std_logic;
SIGNAL \inst|RPHI2~1_combout\ : std_logic;
SIGNAL \inst|RPHI2~0_combout\ : std_logic;
SIGNAL \inst|RPHI2~2_combout\ : std_logic;
SIGNAL \inst|RPHI2~q\ : std_logic;
SIGNAL \inst|RPHI1~1_combout\ : std_logic;
SIGNAL \inst|RPHI1~2_combout\ : std_logic;
SIGNAL \inst|Equal430~1_combout\ : std_logic;
SIGNAL \inst|Equal433~0_combout\ : std_logic;
SIGNAL \inst|RPHI1~3_combout\ : std_logic;
SIGNAL \inst|Equal434~5_combout\ : std_logic;
SIGNAL \inst|RPHI1~0_combout\ : std_logic;
SIGNAL \inst|RPHI1~4_combout\ : std_logic;
SIGNAL \inst|RPHI1~q\ : std_logic;
SIGNAL \inst|RBI~2_combout\ : std_logic;
SIGNAL \inst|Equal430~2_combout\ : std_logic;
SIGNAL \inst|RBI~1_combout\ : std_logic;
SIGNAL \inst|RBI~3_combout\ : std_logic;
SIGNAL \inst|RBI~q\ : std_logic;
SIGNAL \inst|stage_iter\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \inst|stage\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \inst|counter\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_reset_gen~input_o\ : std_logic;

BEGIN

SEB <= ww_SEB;
ww_clk <= clk;
ww_reset_gen <= reset_gen;
IS1 <= ww_IS1;
IS2 <= ww_IS2;
SR <= ww_SR;
CS <= ww_CS;
gnd1 <= ww_gnd1;
gnd2 <= ww_gnd2;
CAL <= ww_CAL;
SBI <= ww_SBI;
SPHI1 <= ww_SPHI1;
SPHI2 <= ww_SPHI2;
RESET <= ww_RESET;
R12 <= ww_R12;
LE <= ww_LE;
RPHI2 <= ww_RPHI2;
RPHI1 <= ww_RPHI1;
RBI <= ww_RBI;
reset_gen_out <= ww_reset_gen_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(6));

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
\ALT_INV_reset_gen~input_o\ <= NOT \reset_gen~input_o\;

-- Location: IOOBUF_X0_Y45_N16
\SEB~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|SEB~q\,
	devoe => ww_devoe,
	o => \SEB~output_o\);

-- Location: IOOBUF_X0_Y33_N23
\IS1~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ISSR~q\,
	devoe => ww_devoe,
	o => \IS1~output_o\);

-- Location: IOOBUF_X0_Y34_N9
\IS2~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ISSR~q\,
	devoe => ww_devoe,
	o => \IS2~output_o\);

-- Location: IOOBUF_X0_Y32_N16
\SR~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ISSR~q\,
	devoe => ww_devoe,
	o => \SR~output_o\);

-- Location: IOOBUF_X0_Y34_N23
\CS~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \CS~output_o\);

-- Location: IOOBUF_X0_Y24_N9
\gnd1~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \gnd1~output_o\);

-- Location: IOOBUF_X0_Y30_N9
\gnd2~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \gnd2~output_o\);

-- Location: IOOBUF_X0_Y43_N16
\CAL~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|CAL~q\,
	devoe => ww_devoe,
	o => \CAL~output_o\);

-- Location: IOOBUF_X0_Y28_N16
\SBI~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|SBI~q\,
	devoe => ww_devoe,
	o => \SBI~output_o\);

-- Location: IOOBUF_X0_Y45_N23
\SPHI1~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|SPHI1~q\,
	devoe => ww_devoe,
	o => \SPHI1~output_o\);

-- Location: IOOBUF_X0_Y28_N23
\SPHI2~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|SPHI2~q\,
	devoe => ww_devoe,
	o => \SPHI2~output_o\);

-- Location: IOOBUF_X0_Y24_N16
\RESET~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|RESET~q\,
	devoe => ww_devoe,
	o => \RESET~output_o\);

-- Location: IOOBUF_X0_Y34_N16
\R12~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ISSR~q\,
	devoe => ww_devoe,
	o => \R12~output_o\);

-- Location: IOOBUF_X0_Y29_N23
\LE~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|LE~q\,
	devoe => ww_devoe,
	o => \LE~output_o\);

-- Location: IOOBUF_X0_Y25_N16
\RPHI2~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|RPHI2~q\,
	devoe => ww_devoe,
	o => \RPHI2~output_o\);

-- Location: IOOBUF_X0_Y33_N16
\RPHI1~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|RPHI1~q\,
	devoe => ww_devoe,
	o => \RPHI1~output_o\);

-- Location: IOOBUF_X0_Y26_N16
\RBI~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|RBI~q\,
	devoe => ww_devoe,
	o => \RBI~output_o\);

-- Location: IOOBUF_X0_Y35_N9
\reset_gen_out~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_reset_gen~input_o\,
	devoe => ww_devoe,
	o => \reset_gen_out~output_o\);

-- Location: IOIBUF_X58_Y0_N1
\clk~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G19
\clk~inputclkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: LCCOMB_X59_Y1_N0
\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~combout\ = \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(0) $ (VCC)
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~COUT\ = CARRY(\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(0),
	datad => VCC,
	combout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~combout\,
	cout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~COUT\);

-- Location: FF_X59_Y1_N1
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(0));

-- Location: LCCOMB_X59_Y1_N2
\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~combout\ = (\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(1) & (!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~COUT\)) # 
-- (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(1) & ((\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~COUT\) # (GND)))
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~COUT\ = CARRY((!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~COUT\) # (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(1),
	datad => VCC,
	cin => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita0~COUT\,
	combout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~combout\,
	cout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~COUT\);

-- Location: FF_X59_Y1_N3
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(1));

-- Location: LCCOMB_X59_Y1_N4
\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~combout\ = (\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(2) & (\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~COUT\ $ (GND))) # 
-- (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(2) & (!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~COUT\ & VCC))
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~COUT\ = CARRY((\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(2) & !\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~COUT\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(2),
	datad => VCC,
	cin => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita1~COUT\,
	combout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~combout\,
	cout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~COUT\);

-- Location: FF_X59_Y1_N5
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(2));

-- Location: LCCOMB_X59_Y1_N6
\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~combout\ = (\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(3) & (!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~COUT\)) # 
-- (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(3) & ((\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~COUT\) # (GND)))
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~COUT\ = CARRY((!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~COUT\) # (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(3),
	datad => VCC,
	cin => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita2~COUT\,
	combout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~combout\,
	cout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~COUT\);

-- Location: FF_X59_Y1_N7
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(3));

-- Location: LCCOMB_X59_Y1_N8
\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~combout\ = (\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(4) & (\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~COUT\ $ (GND))) # 
-- (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(4) & (!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~COUT\ & VCC))
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~COUT\ = CARRY((\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(4) & !\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~COUT\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(4),
	datad => VCC,
	cin => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita3~COUT\,
	combout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~combout\,
	cout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~COUT\);

-- Location: FF_X59_Y1_N9
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(4));

-- Location: LCCOMB_X59_Y1_N10
\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~combout\ = (\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(5) & (!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~COUT\)) # 
-- (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(5) & ((\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~COUT\) # (GND)))
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~COUT\ = CARRY((!\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~COUT\) # (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(5),
	datad => VCC,
	cin => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita4~COUT\,
	combout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~combout\,
	cout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~COUT\);

-- Location: FF_X59_Y1_N11
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(5));

-- Location: LCCOMB_X59_Y1_N12
\inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita6~combout\ = \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~COUT\ $ (!\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(6),
	cin => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita5~COUT\,
	combout => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita6~combout\);

-- Location: FF_X59_Y1_N13
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \inst2|LPM_COUNTER_component|auto_generated|counter_comb_bita6~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit\(6));

-- Location: CLKCTRL_G17
\inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\);

-- Location: IOIBUF_X3_Y0_N1
\reset_gen~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset_gen,
	o => \reset_gen~input_o\);

-- Location: LCCOMB_X23_Y27_N0
\inst|stage_iter[0]~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[0]~16_combout\ = \inst|stage_iter\(0) $ (VCC)
-- \inst|stage_iter[0]~17\ = CARRY(\inst|stage_iter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(0),
	datad => VCC,
	combout => \inst|stage_iter[0]~16_combout\,
	cout => \inst|stage_iter[0]~17\);

-- Location: LCCOMB_X26_Y29_N0
\inst|counter[0]~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[0]~32_combout\ = \inst|counter\(0) $ (VCC)
-- \inst|counter[0]~33\ = CARRY(\inst|counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datad => VCC,
	combout => \inst|counter[0]~32_combout\,
	cout => \inst|counter[0]~33\);

-- Location: LCCOMB_X25_Y29_N8
\inst|Equal435~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal435~0_combout\ = (\inst|counter\(2) & (\inst|counter\(8) & (!\inst|counter\(4) & !\inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(8),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal435~0_combout\);

-- Location: LCCOMB_X26_Y29_N18
\inst|counter[9]~51\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[9]~51_combout\ = (\inst|counter\(9) & (!\inst|counter[8]~50\)) # (!\inst|counter\(9) & ((\inst|counter[8]~50\) # (GND)))
-- \inst|counter[9]~52\ = CARRY((!\inst|counter[8]~50\) # (!\inst|counter\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(9),
	datad => VCC,
	cin => \inst|counter[8]~50\,
	combout => \inst|counter[9]~51_combout\,
	cout => \inst|counter[9]~52\);

-- Location: LCCOMB_X26_Y29_N20
\inst|counter[10]~53\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[10]~53_combout\ = (\inst|counter\(10) & (\inst|counter[9]~52\ $ (GND))) # (!\inst|counter\(10) & (!\inst|counter[9]~52\ & VCC))
-- \inst|counter[10]~54\ = CARRY((\inst|counter\(10) & !\inst|counter[9]~52\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(10),
	datad => VCC,
	cin => \inst|counter[9]~52\,
	combout => \inst|counter[10]~53_combout\,
	cout => \inst|counter[10]~54\);

-- Location: FF_X26_Y29_N21
\inst|counter[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[10]~53_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(10));

-- Location: LCCOMB_X26_Y29_N22
\inst|counter[11]~55\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[11]~55_combout\ = (\inst|counter\(11) & (!\inst|counter[10]~54\)) # (!\inst|counter\(11) & ((\inst|counter[10]~54\) # (GND)))
-- \inst|counter[11]~56\ = CARRY((!\inst|counter[10]~54\) # (!\inst|counter\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(11),
	datad => VCC,
	cin => \inst|counter[10]~54\,
	combout => \inst|counter[11]~55_combout\,
	cout => \inst|counter[11]~56\);

-- Location: FF_X26_Y29_N23
\inst|counter[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[11]~55_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(11));

-- Location: LCCOMB_X26_Y29_N24
\inst|counter[12]~57\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[12]~57_combout\ = (\inst|counter\(12) & (\inst|counter[11]~56\ $ (GND))) # (!\inst|counter\(12) & (!\inst|counter[11]~56\ & VCC))
-- \inst|counter[12]~58\ = CARRY((\inst|counter\(12) & !\inst|counter[11]~56\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(12),
	datad => VCC,
	cin => \inst|counter[11]~56\,
	combout => \inst|counter[12]~57_combout\,
	cout => \inst|counter[12]~58\);

-- Location: FF_X26_Y29_N25
\inst|counter[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[12]~57_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(12));

-- Location: LCCOMB_X26_Y29_N26
\inst|counter[13]~59\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[13]~59_combout\ = (\inst|counter\(13) & (!\inst|counter[12]~58\)) # (!\inst|counter\(13) & ((\inst|counter[12]~58\) # (GND)))
-- \inst|counter[13]~60\ = CARRY((!\inst|counter[12]~58\) # (!\inst|counter\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(13),
	datad => VCC,
	cin => \inst|counter[12]~58\,
	combout => \inst|counter[13]~59_combout\,
	cout => \inst|counter[13]~60\);

-- Location: FF_X26_Y29_N27
\inst|counter[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[13]~59_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(13));

-- Location: LCCOMB_X26_Y29_N28
\inst|counter[14]~61\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[14]~61_combout\ = (\inst|counter\(14) & (\inst|counter[13]~60\ $ (GND))) # (!\inst|counter\(14) & (!\inst|counter[13]~60\ & VCC))
-- \inst|counter[14]~62\ = CARRY((\inst|counter\(14) & !\inst|counter[13]~60\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(14),
	datad => VCC,
	cin => \inst|counter[13]~60\,
	combout => \inst|counter[14]~61_combout\,
	cout => \inst|counter[14]~62\);

-- Location: FF_X26_Y29_N29
\inst|counter[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[14]~61_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(14));

-- Location: LCCOMB_X26_Y29_N30
\inst|counter[15]~63\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[15]~63_combout\ = (\inst|counter\(15) & (!\inst|counter[14]~62\)) # (!\inst|counter\(15) & ((\inst|counter[14]~62\) # (GND)))
-- \inst|counter[15]~64\ = CARRY((!\inst|counter[14]~62\) # (!\inst|counter\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(15),
	datad => VCC,
	cin => \inst|counter[14]~62\,
	combout => \inst|counter[15]~63_combout\,
	cout => \inst|counter[15]~64\);

-- Location: FF_X26_Y29_N31
\inst|counter[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[15]~63_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(15));

-- Location: LCCOMB_X26_Y28_N0
\inst|counter[16]~65\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[16]~65_combout\ = (\inst|counter\(16) & (\inst|counter[15]~64\ $ (GND))) # (!\inst|counter\(16) & (!\inst|counter[15]~64\ & VCC))
-- \inst|counter[16]~66\ = CARRY((\inst|counter\(16) & !\inst|counter[15]~64\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(16),
	datad => VCC,
	cin => \inst|counter[15]~64\,
	combout => \inst|counter[16]~65_combout\,
	cout => \inst|counter[16]~66\);

-- Location: FF_X26_Y28_N1
\inst|counter[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[16]~65_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(16));

-- Location: LCCOMB_X26_Y28_N2
\inst|counter[17]~67\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[17]~67_combout\ = (\inst|counter\(17) & (!\inst|counter[16]~66\)) # (!\inst|counter\(17) & ((\inst|counter[16]~66\) # (GND)))
-- \inst|counter[17]~68\ = CARRY((!\inst|counter[16]~66\) # (!\inst|counter\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(17),
	datad => VCC,
	cin => \inst|counter[16]~66\,
	combout => \inst|counter[17]~67_combout\,
	cout => \inst|counter[17]~68\);

-- Location: FF_X26_Y28_N3
\inst|counter[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[17]~67_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(17));

-- Location: LCCOMB_X26_Y28_N4
\inst|counter[18]~69\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[18]~69_combout\ = (\inst|counter\(18) & (\inst|counter[17]~68\ $ (GND))) # (!\inst|counter\(18) & (!\inst|counter[17]~68\ & VCC))
-- \inst|counter[18]~70\ = CARRY((\inst|counter\(18) & !\inst|counter[17]~68\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(18),
	datad => VCC,
	cin => \inst|counter[17]~68\,
	combout => \inst|counter[18]~69_combout\,
	cout => \inst|counter[18]~70\);

-- Location: FF_X26_Y28_N5
\inst|counter[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[18]~69_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(18));

-- Location: LCCOMB_X26_Y28_N6
\inst|counter[19]~71\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[19]~71_combout\ = (\inst|counter\(19) & (!\inst|counter[18]~70\)) # (!\inst|counter\(19) & ((\inst|counter[18]~70\) # (GND)))
-- \inst|counter[19]~72\ = CARRY((!\inst|counter[18]~70\) # (!\inst|counter\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(19),
	datad => VCC,
	cin => \inst|counter[18]~70\,
	combout => \inst|counter[19]~71_combout\,
	cout => \inst|counter[19]~72\);

-- Location: FF_X26_Y28_N7
\inst|counter[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[19]~71_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(19));

-- Location: LCCOMB_X26_Y28_N8
\inst|counter[20]~73\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[20]~73_combout\ = (\inst|counter\(20) & (\inst|counter[19]~72\ $ (GND))) # (!\inst|counter\(20) & (!\inst|counter[19]~72\ & VCC))
-- \inst|counter[20]~74\ = CARRY((\inst|counter\(20) & !\inst|counter[19]~72\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(20),
	datad => VCC,
	cin => \inst|counter[19]~72\,
	combout => \inst|counter[20]~73_combout\,
	cout => \inst|counter[20]~74\);

-- Location: FF_X26_Y28_N9
\inst|counter[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[20]~73_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(20));

-- Location: LCCOMB_X26_Y28_N10
\inst|counter[21]~75\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[21]~75_combout\ = (\inst|counter\(21) & (!\inst|counter[20]~74\)) # (!\inst|counter\(21) & ((\inst|counter[20]~74\) # (GND)))
-- \inst|counter[21]~76\ = CARRY((!\inst|counter[20]~74\) # (!\inst|counter\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(21),
	datad => VCC,
	cin => \inst|counter[20]~74\,
	combout => \inst|counter[21]~75_combout\,
	cout => \inst|counter[21]~76\);

-- Location: FF_X26_Y28_N11
\inst|counter[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[21]~75_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(21));

-- Location: LCCOMB_X26_Y28_N12
\inst|counter[22]~77\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[22]~77_combout\ = (\inst|counter\(22) & (\inst|counter[21]~76\ $ (GND))) # (!\inst|counter\(22) & (!\inst|counter[21]~76\ & VCC))
-- \inst|counter[22]~78\ = CARRY((\inst|counter\(22) & !\inst|counter[21]~76\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(22),
	datad => VCC,
	cin => \inst|counter[21]~76\,
	combout => \inst|counter[22]~77_combout\,
	cout => \inst|counter[22]~78\);

-- Location: FF_X26_Y28_N13
\inst|counter[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[22]~77_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(22));

-- Location: LCCOMB_X26_Y28_N14
\inst|counter[23]~79\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[23]~79_combout\ = (\inst|counter\(23) & (!\inst|counter[22]~78\)) # (!\inst|counter\(23) & ((\inst|counter[22]~78\) # (GND)))
-- \inst|counter[23]~80\ = CARRY((!\inst|counter[22]~78\) # (!\inst|counter\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(23),
	datad => VCC,
	cin => \inst|counter[22]~78\,
	combout => \inst|counter[23]~79_combout\,
	cout => \inst|counter[23]~80\);

-- Location: FF_X26_Y28_N15
\inst|counter[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[23]~79_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(23));

-- Location: LCCOMB_X26_Y28_N16
\inst|counter[24]~81\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[24]~81_combout\ = (\inst|counter\(24) & (\inst|counter[23]~80\ $ (GND))) # (!\inst|counter\(24) & (!\inst|counter[23]~80\ & VCC))
-- \inst|counter[24]~82\ = CARRY((\inst|counter\(24) & !\inst|counter[23]~80\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(24),
	datad => VCC,
	cin => \inst|counter[23]~80\,
	combout => \inst|counter[24]~81_combout\,
	cout => \inst|counter[24]~82\);

-- Location: FF_X26_Y28_N17
\inst|counter[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[24]~81_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(24));

-- Location: LCCOMB_X26_Y28_N18
\inst|counter[25]~83\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[25]~83_combout\ = (\inst|counter\(25) & (!\inst|counter[24]~82\)) # (!\inst|counter\(25) & ((\inst|counter[24]~82\) # (GND)))
-- \inst|counter[25]~84\ = CARRY((!\inst|counter[24]~82\) # (!\inst|counter\(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(25),
	datad => VCC,
	cin => \inst|counter[24]~82\,
	combout => \inst|counter[25]~83_combout\,
	cout => \inst|counter[25]~84\);

-- Location: FF_X26_Y28_N19
\inst|counter[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[25]~83_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(25));

-- Location: LCCOMB_X27_Y28_N30
\inst|SPHI1~77\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~77_combout\ = (!\inst|counter\(23) & (!\inst|counter\(25) & (!\inst|counter\(24) & !\inst|counter\(22))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(23),
	datab => \inst|counter\(25),
	datac => \inst|counter\(24),
	datad => \inst|counter\(22),
	combout => \inst|SPHI1~77_combout\);

-- Location: LCCOMB_X27_Y28_N2
\inst|SPHI1~75\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~75_combout\ = (!\inst|counter\(17) & (!\inst|counter\(14) & (!\inst|counter\(16) & !\inst|counter\(15))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(17),
	datab => \inst|counter\(14),
	datac => \inst|counter\(16),
	datad => \inst|counter\(15),
	combout => \inst|SPHI1~75_combout\);

-- Location: LCCOMB_X27_Y28_N8
\inst|SPHI1~76\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~76_combout\ = (!\inst|counter\(21) & (!\inst|counter\(19) & (!\inst|counter\(20) & !\inst|counter\(18))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(21),
	datab => \inst|counter\(19),
	datac => \inst|counter\(20),
	datad => \inst|counter\(18),
	combout => \inst|SPHI1~76_combout\);

-- Location: LCCOMB_X27_Y28_N20
\inst|SPHI1~74\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~74_combout\ = (!\inst|counter\(11) & (!\inst|counter\(13) & (!\inst|counter\(12) & !\inst|counter\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(11),
	datab => \inst|counter\(13),
	datac => \inst|counter\(12),
	datad => \inst|counter\(10),
	combout => \inst|SPHI1~74_combout\);

-- Location: LCCOMB_X27_Y28_N16
\inst|SPHI1~78\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~78_combout\ = (\inst|SPHI1~77_combout\ & (\inst|SPHI1~75_combout\ & (\inst|SPHI1~76_combout\ & \inst|SPHI1~74_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~77_combout\,
	datab => \inst|SPHI1~75_combout\,
	datac => \inst|SPHI1~76_combout\,
	datad => \inst|SPHI1~74_combout\,
	combout => \inst|SPHI1~78_combout\);

-- Location: LCCOMB_X26_Y28_N20
\inst|counter[26]~85\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[26]~85_combout\ = (\inst|counter\(26) & (\inst|counter[25]~84\ $ (GND))) # (!\inst|counter\(26) & (!\inst|counter[25]~84\ & VCC))
-- \inst|counter[26]~86\ = CARRY((\inst|counter\(26) & !\inst|counter[25]~84\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(26),
	datad => VCC,
	cin => \inst|counter[25]~84\,
	combout => \inst|counter[26]~85_combout\,
	cout => \inst|counter[26]~86\);

-- Location: FF_X26_Y28_N21
\inst|counter[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[26]~85_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(26));

-- Location: LCCOMB_X26_Y28_N22
\inst|counter[27]~87\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[27]~87_combout\ = (\inst|counter\(27) & (!\inst|counter[26]~86\)) # (!\inst|counter\(27) & ((\inst|counter[26]~86\) # (GND)))
-- \inst|counter[27]~88\ = CARRY((!\inst|counter[26]~86\) # (!\inst|counter\(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(27),
	datad => VCC,
	cin => \inst|counter[26]~86\,
	combout => \inst|counter[27]~87_combout\,
	cout => \inst|counter[27]~88\);

-- Location: FF_X26_Y28_N23
\inst|counter[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[27]~87_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(27));

-- Location: LCCOMB_X26_Y28_N24
\inst|counter[28]~89\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[28]~89_combout\ = (\inst|counter\(28) & (\inst|counter[27]~88\ $ (GND))) # (!\inst|counter\(28) & (!\inst|counter[27]~88\ & VCC))
-- \inst|counter[28]~90\ = CARRY((\inst|counter\(28) & !\inst|counter[27]~88\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(28),
	datad => VCC,
	cin => \inst|counter[27]~88\,
	combout => \inst|counter[28]~89_combout\,
	cout => \inst|counter[28]~90\);

-- Location: FF_X26_Y28_N25
\inst|counter[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[28]~89_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(28));

-- Location: LCCOMB_X26_Y28_N26
\inst|counter[29]~91\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[29]~91_combout\ = (\inst|counter\(29) & (!\inst|counter[28]~90\)) # (!\inst|counter\(29) & ((\inst|counter[28]~90\) # (GND)))
-- \inst|counter[29]~92\ = CARRY((!\inst|counter[28]~90\) # (!\inst|counter\(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(29),
	datad => VCC,
	cin => \inst|counter[28]~90\,
	combout => \inst|counter[29]~91_combout\,
	cout => \inst|counter[29]~92\);

-- Location: FF_X26_Y28_N27
\inst|counter[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[29]~91_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(29));

-- Location: LCCOMB_X26_Y28_N28
\inst|counter[30]~93\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[30]~93_combout\ = (\inst|counter\(30) & (\inst|counter[29]~92\ $ (GND))) # (!\inst|counter\(30) & (!\inst|counter[29]~92\ & VCC))
-- \inst|counter[30]~94\ = CARRY((\inst|counter\(30) & !\inst|counter[29]~92\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(30),
	datad => VCC,
	cin => \inst|counter[29]~92\,
	combout => \inst|counter[30]~93_combout\,
	cout => \inst|counter[30]~94\);

-- Location: FF_X26_Y28_N29
\inst|counter[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[30]~93_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(30));

-- Location: LCCOMB_X26_Y28_N30
\inst|counter[31]~95\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[31]~95_combout\ = \inst|counter\(31) $ (\inst|counter[30]~94\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(31),
	cin => \inst|counter[30]~94\,
	combout => \inst|counter[31]~95_combout\);

-- Location: FF_X26_Y28_N31
\inst|counter[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[31]~95_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(31));

-- Location: LCCOMB_X27_Y28_N6
\inst|SPHI1~79\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~79_combout\ = (!\inst|counter\(29) & (!\inst|counter\(26) & (!\inst|counter\(28) & !\inst|counter\(27))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(29),
	datab => \inst|counter\(26),
	datac => \inst|counter\(28),
	datad => \inst|counter\(27),
	combout => \inst|SPHI1~79_combout\);

-- Location: LCCOMB_X27_Y28_N4
\inst|SPHI1~80\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~80_combout\ = (!\inst|counter\(31) & (!\inst|counter\(30) & \inst|SPHI1~79_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(31),
	datac => \inst|counter\(30),
	datad => \inst|SPHI1~79_combout\,
	combout => \inst|SPHI1~80_combout\);

-- Location: LCCOMB_X25_Y29_N6
\inst|Equal430~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal430~0_combout\ = (\inst|SPHI1~78_combout\ & (\inst|counter\(9) & \inst|SPHI1~80_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~78_combout\,
	datab => \inst|counter\(9),
	datad => \inst|SPHI1~80_combout\,
	combout => \inst|Equal430~0_combout\);

-- Location: LCCOMB_X25_Y29_N18
\inst|Equal435~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal435~1_combout\ = (!\inst|counter\(1) & (\inst|Equal435~0_combout\ & (\inst|counter\(7) & \inst|Equal430~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|Equal435~0_combout\,
	datac => \inst|counter\(7),
	datad => \inst|Equal430~0_combout\,
	combout => \inst|Equal435~1_combout\);

-- Location: LCCOMB_X25_Y29_N22
\inst|Equal436~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal436~2_combout\ = (\inst|counter\(5)) # (((!\inst|Equal435~1_combout\) # (!\inst|counter\(6))) # (!\inst|counter\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(0),
	datac => \inst|counter\(6),
	datad => \inst|Equal435~1_combout\,
	combout => \inst|Equal436~2_combout\);

-- Location: LCCOMB_X24_Y27_N6
\inst|counter[3]~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[3]~36_combout\ = ((\inst|stage\(0) & (!\inst|Equal440~0_combout\)) # (!\inst|stage\(0) & ((!\inst|Equal436~2_combout\)))) # (!\reset_gen~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal440~0_combout\,
	datab => \inst|Equal436~2_combout\,
	datac => \reset_gen~input_o\,
	datad => \inst|stage\(0),
	combout => \inst|counter[3]~36_combout\);

-- Location: FF_X27_Y29_N5
\inst|counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	asdata => \inst|counter[0]~32_combout\,
	sclr => \inst|counter[3]~36_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(0));

-- Location: LCCOMB_X26_Y29_N2
\inst|counter[1]~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[1]~34_combout\ = (\inst|counter\(1) & (!\inst|counter[0]~33\)) # (!\inst|counter\(1) & ((\inst|counter[0]~33\) # (GND)))
-- \inst|counter[1]~35\ = CARRY((!\inst|counter[0]~33\) # (!\inst|counter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(1),
	datad => VCC,
	cin => \inst|counter[0]~33\,
	combout => \inst|counter[1]~34_combout\,
	cout => \inst|counter[1]~35\);

-- Location: FF_X26_Y29_N3
\inst|counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[1]~34_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(1));

-- Location: LCCOMB_X26_Y29_N4
\inst|counter[2]~37\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[2]~37_combout\ = (\inst|counter\(2) & (\inst|counter[1]~35\ $ (GND))) # (!\inst|counter\(2) & (!\inst|counter[1]~35\ & VCC))
-- \inst|counter[2]~38\ = CARRY((\inst|counter\(2) & !\inst|counter[1]~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(2),
	datad => VCC,
	cin => \inst|counter[1]~35\,
	combout => \inst|counter[2]~37_combout\,
	cout => \inst|counter[2]~38\);

-- Location: FF_X26_Y29_N5
\inst|counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[2]~37_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(2));

-- Location: LCCOMB_X26_Y29_N6
\inst|counter[3]~39\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[3]~39_combout\ = (\inst|counter\(3) & (!\inst|counter[2]~38\)) # (!\inst|counter\(3) & ((\inst|counter[2]~38\) # (GND)))
-- \inst|counter[3]~40\ = CARRY((!\inst|counter[2]~38\) # (!\inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datad => VCC,
	cin => \inst|counter[2]~38\,
	combout => \inst|counter[3]~39_combout\,
	cout => \inst|counter[3]~40\);

-- Location: FF_X26_Y29_N7
\inst|counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[3]~39_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(3));

-- Location: LCCOMB_X26_Y29_N8
\inst|counter[4]~41\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[4]~41_combout\ = (\inst|counter\(4) & (\inst|counter[3]~40\ $ (GND))) # (!\inst|counter\(4) & (!\inst|counter[3]~40\ & VCC))
-- \inst|counter[4]~42\ = CARRY((\inst|counter\(4) & !\inst|counter[3]~40\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(4),
	datad => VCC,
	cin => \inst|counter[3]~40\,
	combout => \inst|counter[4]~41_combout\,
	cout => \inst|counter[4]~42\);

-- Location: FF_X26_Y29_N9
\inst|counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[4]~41_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(4));

-- Location: LCCOMB_X26_Y29_N10
\inst|counter[5]~43\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[5]~43_combout\ = (\inst|counter\(5) & (!\inst|counter[4]~42\)) # (!\inst|counter\(5) & ((\inst|counter[4]~42\) # (GND)))
-- \inst|counter[5]~44\ = CARRY((!\inst|counter[4]~42\) # (!\inst|counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datad => VCC,
	cin => \inst|counter[4]~42\,
	combout => \inst|counter[5]~43_combout\,
	cout => \inst|counter[5]~44\);

-- Location: FF_X26_Y29_N11
\inst|counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[5]~43_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(5));

-- Location: LCCOMB_X26_Y29_N12
\inst|counter[6]~45\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[6]~45_combout\ = (\inst|counter\(6) & (\inst|counter[5]~44\ $ (GND))) # (!\inst|counter\(6) & (!\inst|counter[5]~44\ & VCC))
-- \inst|counter[6]~46\ = CARRY((\inst|counter\(6) & !\inst|counter[5]~44\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datad => VCC,
	cin => \inst|counter[5]~44\,
	combout => \inst|counter[6]~45_combout\,
	cout => \inst|counter[6]~46\);

-- Location: FF_X26_Y29_N13
\inst|counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[6]~45_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(6));

-- Location: LCCOMB_X26_Y29_N14
\inst|counter[7]~47\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[7]~47_combout\ = (\inst|counter\(7) & (!\inst|counter[6]~46\)) # (!\inst|counter\(7) & ((\inst|counter[6]~46\) # (GND)))
-- \inst|counter[7]~48\ = CARRY((!\inst|counter[6]~46\) # (!\inst|counter\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(7),
	datad => VCC,
	cin => \inst|counter[6]~46\,
	combout => \inst|counter[7]~47_combout\,
	cout => \inst|counter[7]~48\);

-- Location: FF_X26_Y29_N15
\inst|counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[7]~47_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(7));

-- Location: LCCOMB_X26_Y29_N16
\inst|counter[8]~49\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|counter[8]~49_combout\ = (\inst|counter\(8) & (\inst|counter[7]~48\ $ (GND))) # (!\inst|counter\(8) & (!\inst|counter[7]~48\ & VCC))
-- \inst|counter[8]~50\ = CARRY((\inst|counter\(8) & !\inst|counter[7]~48\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(8),
	datad => VCC,
	cin => \inst|counter[7]~48\,
	combout => \inst|counter[8]~49_combout\,
	cout => \inst|counter[8]~50\);

-- Location: FF_X26_Y29_N17
\inst|counter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[8]~49_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(8));

-- Location: FF_X26_Y29_N19
\inst|counter[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|counter[9]~51_combout\,
	sclr => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|counter\(9));

-- Location: LCCOMB_X27_Y29_N6
\inst|Equal4~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal4~3_combout\ = (!\inst|counter\(0) & \inst|counter\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(0),
	datad => \inst|counter\(1),
	combout => \inst|Equal4~3_combout\);

-- Location: LCCOMB_X27_Y28_N12
\inst|Equal4~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal4~4_combout\ = (!\inst|counter\(9) & (\inst|SPHI1~80_combout\ & (\inst|Equal4~3_combout\ & \inst|SPHI1~78_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(9),
	datab => \inst|SPHI1~80_combout\,
	datac => \inst|Equal4~3_combout\,
	datad => \inst|SPHI1~78_combout\,
	combout => \inst|Equal4~4_combout\);

-- Location: LCCOMB_X26_Y25_N28
\inst|Equal29~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal29~0_combout\ = (!\inst|counter\(6) & (\inst|counter\(4) & \inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal29~0_combout\);

-- Location: LCCOMB_X25_Y28_N16
\inst|Equal3~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal3~2_combout\ = (!\inst|counter\(8) & (!\inst|counter\(7) & !\inst|counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(7),
	datad => \inst|counter\(5),
	combout => \inst|Equal3~2_combout\);

-- Location: LCCOMB_X24_Y29_N26
\inst|Equal440~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal440~0_combout\ = (((!\inst|Equal3~2_combout\) # (!\inst|counter\(2))) # (!\inst|Equal29~0_combout\)) # (!\inst|Equal4~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~4_combout\,
	datab => \inst|Equal29~0_combout\,
	datac => \inst|counter\(2),
	datad => \inst|Equal3~2_combout\,
	combout => \inst|Equal440~0_combout\);

-- Location: LCCOMB_X23_Y27_N2
\inst|stage_iter[1]~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[1]~18_combout\ = (\inst|stage_iter\(1) & (!\inst|stage_iter[0]~17\)) # (!\inst|stage_iter\(1) & ((\inst|stage_iter[0]~17\) # (GND)))
-- \inst|stage_iter[1]~19\ = CARRY((!\inst|stage_iter[0]~17\) # (!\inst|stage_iter\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(1),
	datad => VCC,
	cin => \inst|stage_iter[0]~17\,
	combout => \inst|stage_iter[1]~18_combout\,
	cout => \inst|stage_iter[1]~19\);

-- Location: FF_X23_Y27_N3
\inst|stage_iter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[1]~18_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(1));

-- Location: LCCOMB_X23_Y27_N4
\inst|stage_iter[2]~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[2]~20_combout\ = (\inst|stage_iter\(2) & (\inst|stage_iter[1]~19\ $ (GND))) # (!\inst|stage_iter\(2) & (!\inst|stage_iter[1]~19\ & VCC))
-- \inst|stage_iter[2]~21\ = CARRY((\inst|stage_iter\(2) & !\inst|stage_iter[1]~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(2),
	datad => VCC,
	cin => \inst|stage_iter[1]~19\,
	combout => \inst|stage_iter[2]~20_combout\,
	cout => \inst|stage_iter[2]~21\);

-- Location: FF_X23_Y27_N5
\inst|stage_iter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[2]~20_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(2));

-- Location: LCCOMB_X23_Y27_N6
\inst|stage_iter[3]~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[3]~22_combout\ = (\inst|stage_iter\(3) & (!\inst|stage_iter[2]~21\)) # (!\inst|stage_iter\(3) & ((\inst|stage_iter[2]~21\) # (GND)))
-- \inst|stage_iter[3]~23\ = CARRY((!\inst|stage_iter[2]~21\) # (!\inst|stage_iter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(3),
	datad => VCC,
	cin => \inst|stage_iter[2]~21\,
	combout => \inst|stage_iter[3]~22_combout\,
	cout => \inst|stage_iter[3]~23\);

-- Location: FF_X23_Y27_N7
\inst|stage_iter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[3]~22_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(3));

-- Location: LCCOMB_X23_Y27_N8
\inst|stage_iter[4]~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[4]~24_combout\ = (\inst|stage_iter\(4) & (\inst|stage_iter[3]~23\ $ (GND))) # (!\inst|stage_iter\(4) & (!\inst|stage_iter[3]~23\ & VCC))
-- \inst|stage_iter[4]~25\ = CARRY((\inst|stage_iter\(4) & !\inst|stage_iter[3]~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(4),
	datad => VCC,
	cin => \inst|stage_iter[3]~23\,
	combout => \inst|stage_iter[4]~24_combout\,
	cout => \inst|stage_iter[4]~25\);

-- Location: FF_X23_Y27_N9
\inst|stage_iter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[4]~24_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(4));

-- Location: LCCOMB_X23_Y27_N10
\inst|stage_iter[5]~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[5]~26_combout\ = (\inst|stage_iter\(5) & (!\inst|stage_iter[4]~25\)) # (!\inst|stage_iter\(5) & ((\inst|stage_iter[4]~25\) # (GND)))
-- \inst|stage_iter[5]~27\ = CARRY((!\inst|stage_iter[4]~25\) # (!\inst|stage_iter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(5),
	datad => VCC,
	cin => \inst|stage_iter[4]~25\,
	combout => \inst|stage_iter[5]~26_combout\,
	cout => \inst|stage_iter[5]~27\);

-- Location: FF_X23_Y27_N11
\inst|stage_iter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[5]~26_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(5));

-- Location: LCCOMB_X23_Y27_N12
\inst|stage_iter[6]~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[6]~28_combout\ = (\inst|stage_iter\(6) & (\inst|stage_iter[5]~27\ $ (GND))) # (!\inst|stage_iter\(6) & (!\inst|stage_iter[5]~27\ & VCC))
-- \inst|stage_iter[6]~29\ = CARRY((\inst|stage_iter\(6) & !\inst|stage_iter[5]~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(6),
	datad => VCC,
	cin => \inst|stage_iter[5]~27\,
	combout => \inst|stage_iter[6]~28_combout\,
	cout => \inst|stage_iter[6]~29\);

-- Location: FF_X23_Y27_N13
\inst|stage_iter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[6]~28_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(6));

-- Location: LCCOMB_X23_Y27_N14
\inst|stage_iter[7]~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[7]~30_combout\ = (\inst|stage_iter\(7) & (!\inst|stage_iter[6]~29\)) # (!\inst|stage_iter\(7) & ((\inst|stage_iter[6]~29\) # (GND)))
-- \inst|stage_iter[7]~31\ = CARRY((!\inst|stage_iter[6]~29\) # (!\inst|stage_iter\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(7),
	datad => VCC,
	cin => \inst|stage_iter[6]~29\,
	combout => \inst|stage_iter[7]~30_combout\,
	cout => \inst|stage_iter[7]~31\);

-- Location: FF_X23_Y27_N15
\inst|stage_iter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[7]~30_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(7));

-- Location: LCCOMB_X24_Y27_N16
\inst|stage_iter[15]~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[15]~32_combout\ = (\inst|Equal437~4_combout\ & (\inst|stage_iter\(7) $ (((\inst|Equal440~0_combout\) # (!\inst|stage\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage\(0),
	datab => \inst|Equal437~4_combout\,
	datac => \inst|Equal440~0_combout\,
	datad => \inst|stage_iter\(7),
	combout => \inst|stage_iter[15]~32_combout\);

-- Location: LCCOMB_X24_Y27_N14
\inst|stage_iter[15]~33\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[15]~33_combout\ = (\inst|stage_iter[15]~32_combout\) # (!\reset_gen~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset_gen~input_o\,
	datad => \inst|stage_iter[15]~32_combout\,
	combout => \inst|stage_iter[15]~33_combout\);

-- Location: FF_X23_Y27_N1
\inst|stage_iter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[0]~16_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(0));

-- Location: LCCOMB_X24_Y27_N12
\inst|Equal437~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal437~0_combout\ = (!\inst|stage_iter\(0) & (!\inst|stage_iter\(3) & (!\inst|stage_iter\(2) & !\inst|stage_iter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(0),
	datab => \inst|stage_iter\(3),
	datac => \inst|stage_iter\(2),
	datad => \inst|stage_iter\(1),
	combout => \inst|Equal437~0_combout\);

-- Location: LCCOMB_X23_Y27_N16
\inst|stage_iter[8]~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[8]~34_combout\ = (\inst|stage_iter\(8) & (\inst|stage_iter[7]~31\ $ (GND))) # (!\inst|stage_iter\(8) & (!\inst|stage_iter[7]~31\ & VCC))
-- \inst|stage_iter[8]~35\ = CARRY((\inst|stage_iter\(8) & !\inst|stage_iter[7]~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(8),
	datad => VCC,
	cin => \inst|stage_iter[7]~31\,
	combout => \inst|stage_iter[8]~34_combout\,
	cout => \inst|stage_iter[8]~35\);

-- Location: FF_X23_Y27_N17
\inst|stage_iter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[8]~34_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(8));

-- Location: LCCOMB_X24_Y27_N2
\inst|Equal437~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal437~1_combout\ = (!\inst|stage_iter\(6) & (!\inst|stage_iter\(5) & (!\inst|stage_iter\(8) & !\inst|stage_iter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(6),
	datab => \inst|stage_iter\(5),
	datac => \inst|stage_iter\(8),
	datad => \inst|stage_iter\(4),
	combout => \inst|Equal437~1_combout\);

-- Location: LCCOMB_X23_Y27_N18
\inst|stage_iter[9]~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[9]~36_combout\ = (\inst|stage_iter\(9) & (!\inst|stage_iter[8]~35\)) # (!\inst|stage_iter\(9) & ((\inst|stage_iter[8]~35\) # (GND)))
-- \inst|stage_iter[9]~37\ = CARRY((!\inst|stage_iter[8]~35\) # (!\inst|stage_iter\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(9),
	datad => VCC,
	cin => \inst|stage_iter[8]~35\,
	combout => \inst|stage_iter[9]~36_combout\,
	cout => \inst|stage_iter[9]~37\);

-- Location: FF_X23_Y27_N19
\inst|stage_iter[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[9]~36_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(9));

-- Location: LCCOMB_X23_Y27_N20
\inst|stage_iter[10]~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[10]~38_combout\ = (\inst|stage_iter\(10) & (\inst|stage_iter[9]~37\ $ (GND))) # (!\inst|stage_iter\(10) & (!\inst|stage_iter[9]~37\ & VCC))
-- \inst|stage_iter[10]~39\ = CARRY((\inst|stage_iter\(10) & !\inst|stage_iter[9]~37\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(10),
	datad => VCC,
	cin => \inst|stage_iter[9]~37\,
	combout => \inst|stage_iter[10]~38_combout\,
	cout => \inst|stage_iter[10]~39\);

-- Location: FF_X23_Y27_N21
\inst|stage_iter[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[10]~38_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(10));

-- Location: LCCOMB_X23_Y27_N22
\inst|stage_iter[11]~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[11]~40_combout\ = (\inst|stage_iter\(11) & (!\inst|stage_iter[10]~39\)) # (!\inst|stage_iter\(11) & ((\inst|stage_iter[10]~39\) # (GND)))
-- \inst|stage_iter[11]~41\ = CARRY((!\inst|stage_iter[10]~39\) # (!\inst|stage_iter\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(11),
	datad => VCC,
	cin => \inst|stage_iter[10]~39\,
	combout => \inst|stage_iter[11]~40_combout\,
	cout => \inst|stage_iter[11]~41\);

-- Location: FF_X23_Y27_N23
\inst|stage_iter[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[11]~40_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(11));

-- Location: LCCOMB_X23_Y27_N24
\inst|stage_iter[12]~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[12]~42_combout\ = (\inst|stage_iter\(12) & (\inst|stage_iter[11]~41\ $ (GND))) # (!\inst|stage_iter\(12) & (!\inst|stage_iter[11]~41\ & VCC))
-- \inst|stage_iter[12]~43\ = CARRY((\inst|stage_iter\(12) & !\inst|stage_iter[11]~41\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(12),
	datad => VCC,
	cin => \inst|stage_iter[11]~41\,
	combout => \inst|stage_iter[12]~42_combout\,
	cout => \inst|stage_iter[12]~43\);

-- Location: FF_X23_Y27_N25
\inst|stage_iter[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[12]~42_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(12));

-- Location: LCCOMB_X23_Y27_N26
\inst|stage_iter[13]~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[13]~44_combout\ = (\inst|stage_iter\(13) & (!\inst|stage_iter[12]~43\)) # (!\inst|stage_iter\(13) & ((\inst|stage_iter[12]~43\) # (GND)))
-- \inst|stage_iter[13]~45\ = CARRY((!\inst|stage_iter[12]~43\) # (!\inst|stage_iter\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(13),
	datad => VCC,
	cin => \inst|stage_iter[12]~43\,
	combout => \inst|stage_iter[13]~44_combout\,
	cout => \inst|stage_iter[13]~45\);

-- Location: FF_X23_Y27_N27
\inst|stage_iter[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[13]~44_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(13));

-- Location: LCCOMB_X23_Y27_N28
\inst|stage_iter[14]~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[14]~46_combout\ = (\inst|stage_iter\(14) & (\inst|stage_iter[13]~45\ $ (GND))) # (!\inst|stage_iter\(14) & (!\inst|stage_iter[13]~45\ & VCC))
-- \inst|stage_iter[14]~47\ = CARRY((\inst|stage_iter\(14) & !\inst|stage_iter[13]~45\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(14),
	datad => VCC,
	cin => \inst|stage_iter[13]~45\,
	combout => \inst|stage_iter[14]~46_combout\,
	cout => \inst|stage_iter[14]~47\);

-- Location: FF_X23_Y27_N29
\inst|stage_iter[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[14]~46_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(14));

-- Location: LCCOMB_X23_Y27_N30
\inst|stage_iter[15]~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage_iter[15]~48_combout\ = \inst|stage_iter\(15) $ (\inst|stage_iter[14]~47\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(15),
	cin => \inst|stage_iter[14]~47\,
	combout => \inst|stage_iter[15]~48_combout\);

-- Location: FF_X23_Y27_N31
\inst|stage_iter[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage_iter[15]~48_combout\,
	sclr => \inst|stage_iter[15]~33_combout\,
	ena => \inst|counter[3]~36_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage_iter\(15));

-- Location: LCCOMB_X24_Y27_N26
\inst|Equal437~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal437~3_combout\ = (!\inst|stage_iter\(15) & (!\inst|stage_iter\(13) & !\inst|stage_iter\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|stage_iter\(15),
	datac => \inst|stage_iter\(13),
	datad => \inst|stage_iter\(14),
	combout => \inst|Equal437~3_combout\);

-- Location: LCCOMB_X24_Y27_N24
\inst|Equal437~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal437~2_combout\ = (!\inst|stage_iter\(12) & (!\inst|stage_iter\(11) & (!\inst|stage_iter\(10) & !\inst|stage_iter\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage_iter\(12),
	datab => \inst|stage_iter\(11),
	datac => \inst|stage_iter\(10),
	datad => \inst|stage_iter\(9),
	combout => \inst|Equal437~2_combout\);

-- Location: LCCOMB_X24_Y27_N0
\inst|Equal437~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal437~4_combout\ = (\inst|Equal437~0_combout\ & (\inst|Equal437~1_combout\ & (\inst|Equal437~3_combout\ & \inst|Equal437~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal437~0_combout\,
	datab => \inst|Equal437~1_combout\,
	datac => \inst|Equal437~3_combout\,
	datad => \inst|Equal437~2_combout\,
	combout => \inst|Equal437~4_combout\);

-- Location: LCCOMB_X24_Y27_N18
\inst|stage~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage~0_combout\ = (\inst|Equal437~4_combout\ & ((\inst|stage\(0) & (!\inst|Equal440~0_combout\ & \inst|stage_iter\(7))) # (!\inst|stage\(0) & ((!\inst|stage_iter\(7))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage\(0),
	datab => \inst|Equal437~4_combout\,
	datac => \inst|Equal440~0_combout\,
	datad => \inst|stage_iter\(7),
	combout => \inst|stage~0_combout\);

-- Location: LCCOMB_X24_Y27_N10
\inst|stage~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|stage~1_combout\ = (\reset_gen~input_o\ & ((\inst|stage~0_combout\ & (!\inst|stage\(0) & !\inst|Equal436~2_combout\)) # (!\inst|stage~0_combout\ & (\inst|stage\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reset_gen~input_o\,
	datab => \inst|stage~0_combout\,
	datac => \inst|stage\(0),
	datad => \inst|Equal436~2_combout\,
	combout => \inst|stage~1_combout\);

-- Location: FF_X24_Y27_N11
\inst|stage[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|stage~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|stage\(0));

-- Location: LCCOMB_X25_Y28_N22
\inst|Equal1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal1~0_combout\ = (\inst|counter\(3)) # ((\inst|counter\(4)) # ((\inst|counter\(6)) # (!\inst|Equal3~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(4),
	datac => \inst|counter\(6),
	datad => \inst|Equal3~2_combout\,
	combout => \inst|Equal1~0_combout\);

-- Location: LCCOMB_X27_Y29_N30
\inst|Equal3~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal3~0_combout\ = (!\inst|counter\(0) & !\inst|counter\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(0),
	datad => \inst|counter\(9),
	combout => \inst|Equal3~0_combout\);

-- Location: LCCOMB_X27_Y28_N22
\inst|Equal3~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal3~1_combout\ = (!\inst|counter\(1) & (\inst|Equal3~0_combout\ & (\inst|SPHI1~80_combout\ & \inst|SPHI1~78_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|Equal3~0_combout\,
	datac => \inst|SPHI1~80_combout\,
	datad => \inst|SPHI1~78_combout\,
	combout => \inst|Equal3~1_combout\);

-- Location: LCCOMB_X30_Y29_N14
\inst|SEB~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SEB~4_combout\ = (\inst|SEB~q\) # ((!\inst|counter\(2) & (!\inst|Equal1~0_combout\ & \inst|Equal3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SEB~q\,
	datab => \inst|counter\(2),
	datac => \inst|Equal1~0_combout\,
	datad => \inst|Equal3~1_combout\,
	combout => \inst|SEB~4_combout\);

-- Location: LCCOMB_X27_Y29_N8
\inst|Equal4~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal4~0_combout\ = (!\inst|counter\(2) & (!\inst|counter\(3) & !\inst|counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(2),
	datac => \inst|counter\(3),
	datad => \inst|counter\(5),
	combout => \inst|Equal4~0_combout\);

-- Location: LCCOMB_X29_Y29_N12
\inst|Equal428~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal428~0_combout\ = (\inst|counter\(6) & (\inst|counter\(7) & (\inst|counter\(4) & \inst|counter\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(7),
	datac => \inst|counter\(4),
	datad => \inst|counter\(8),
	combout => \inst|Equal428~0_combout\);

-- Location: LCCOMB_X25_Y26_N8
\inst|Equal6~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal6~0_combout\ = (\inst|counter\(5) & !\inst|counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(5),
	datad => \inst|counter\(3),
	combout => \inst|Equal6~0_combout\);

-- Location: LCCOMB_X29_Y29_N6
\inst|Equal428~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal428~1_combout\ = (\inst|Equal428~0_combout\ & (\inst|Equal6~0_combout\ & (\inst|Equal3~1_combout\ & \inst|counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal428~0_combout\,
	datab => \inst|Equal6~0_combout\,
	datac => \inst|Equal3~1_combout\,
	datad => \inst|counter\(2),
	combout => \inst|Equal428~1_combout\);

-- Location: LCCOMB_X25_Y28_N6
\inst|Equal4~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal4~1_combout\ = (!\inst|counter\(8) & (!\inst|counter\(6) & \inst|counter\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(6),
	datad => \inst|counter\(4),
	combout => \inst|Equal4~1_combout\);

-- Location: LCCOMB_X27_Y28_N0
\inst|Equal135~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal135~0_combout\ = (\inst|counter\(1) & (!\inst|counter\(9) & (\inst|SPHI1~80_combout\ & \inst|SPHI1~78_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|counter\(9),
	datac => \inst|SPHI1~80_combout\,
	datad => \inst|SPHI1~78_combout\,
	combout => \inst|Equal135~0_combout\);

-- Location: LCCOMB_X24_Y28_N16
\inst|Equal4~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal4~2_combout\ = (\inst|Equal4~1_combout\ & (!\inst|counter\(0) & (\inst|Equal135~0_combout\ & !\inst|counter\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~1_combout\,
	datab => \inst|counter\(0),
	datac => \inst|Equal135~0_combout\,
	datad => \inst|counter\(7),
	combout => \inst|Equal4~2_combout\);

-- Location: LCCOMB_X28_Y28_N4
\inst|Equal2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal2~0_combout\ = (!\inst|counter\(4) & !\inst|counter\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|Equal2~0_combout\);

-- Location: LCCOMB_X28_Y27_N4
\inst|Equal2~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal2~1_combout\ = (!\inst|counter\(2) & (\inst|Equal135~0_combout\ & \inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datac => \inst|Equal135~0_combout\,
	datad => \inst|counter\(3),
	combout => \inst|Equal2~1_combout\);

-- Location: LCCOMB_X29_Y29_N0
\inst|Equal2~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal2~2_combout\ = (!\inst|counter\(0) & (\inst|Equal2~0_combout\ & (\inst|Equal3~2_combout\ & \inst|Equal2~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datab => \inst|Equal2~0_combout\,
	datac => \inst|Equal3~2_combout\,
	datad => \inst|Equal2~1_combout\,
	combout => \inst|Equal2~2_combout\);

-- Location: LCCOMB_X25_Y28_N28
\inst|Equal1~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal1~1_combout\ = (\inst|counter\(2)) # ((\inst|Equal1~0_combout\) # (!\inst|Equal3~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datac => \inst|Equal1~0_combout\,
	datad => \inst|Equal3~1_combout\,
	combout => \inst|Equal1~1_combout\);

-- Location: LCCOMB_X30_Y29_N2
\inst|SEB~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SEB~2_combout\ = (\inst|SEB~q\ & ((\inst|Equal1~1_combout\) # ((!\inst|stage\(0) & \inst|Equal2~2_combout\)))) # (!\inst|SEB~q\ & (!\inst|stage\(0) & (\inst|Equal2~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SEB~q\,
	datab => \inst|stage\(0),
	datac => \inst|Equal2~2_combout\,
	datad => \inst|Equal1~1_combout\,
	combout => \inst|SEB~2_combout\);

-- Location: LCCOMB_X30_Y29_N4
\inst|SEB~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SEB~3_combout\ = (!\inst|Equal428~1_combout\ & (\inst|SEB~2_combout\ & ((!\inst|Equal4~2_combout\) # (!\inst|Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~0_combout\,
	datab => \inst|Equal428~1_combout\,
	datac => \inst|Equal4~2_combout\,
	datad => \inst|SEB~2_combout\,
	combout => \inst|SEB~3_combout\);

-- Location: LCCOMB_X23_Y26_N28
\inst|Equal392~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal392~0_combout\ = (\inst|counter\(7) & (\inst|counter\(5) & \inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datac => \inst|counter\(5),
	datad => \inst|counter\(3),
	combout => \inst|Equal392~0_combout\);

-- Location: LCCOMB_X29_Y27_N24
\inst|Equal309~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal309~0_combout\ = (\inst|counter\(8) & (\inst|counter\(4) & \inst|counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|Equal309~0_combout\);

-- Location: LCCOMB_X30_Y29_N6
\inst|SEB~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SEB~0_combout\ = (\inst|Equal3~1_combout\ & (!\inst|counter\(2) & (\inst|Equal392~0_combout\ & \inst|Equal309~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~1_combout\,
	datab => \inst|counter\(2),
	datac => \inst|Equal392~0_combout\,
	datad => \inst|Equal309~0_combout\,
	combout => \inst|SEB~0_combout\);

-- Location: LCCOMB_X27_Y28_N28
\inst|Equal41~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal41~2_combout\ = (!\inst|counter\(9) & (\inst|counter\(2) & (\inst|SPHI1~80_combout\ & \inst|SPHI1~78_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(9),
	datab => \inst|counter\(2),
	datac => \inst|SPHI1~80_combout\,
	datad => \inst|SPHI1~78_combout\,
	combout => \inst|Equal41~2_combout\);

-- Location: LCCOMB_X27_Y28_N26
\inst|Equal9~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal9~0_combout\ = (!\inst|counter\(1) & (\inst|counter\(0) & \inst|Equal41~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(1),
	datac => \inst|counter\(0),
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal9~0_combout\);

-- Location: LCCOMB_X26_Y25_N16
\inst|Equal153~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal153~0_combout\ = (!\inst|counter\(3) & (\inst|counter\(7) & (\inst|counter\(5) & \inst|Equal9~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(7),
	datac => \inst|counter\(5),
	datad => \inst|Equal9~0_combout\,
	combout => \inst|Equal153~0_combout\);

-- Location: LCCOMB_X26_Y25_N18
\inst|Equal391~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal391~2_combout\ = (!\inst|counter\(6) & (\inst|counter\(8) & (!\inst|counter\(4) & \inst|Equal153~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(8),
	datac => \inst|counter\(4),
	datad => \inst|Equal153~0_combout\,
	combout => \inst|Equal391~2_combout\);

-- Location: LCCOMB_X30_Y29_N0
\inst|SEB~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SEB~1_combout\ = (!\inst|stage\(0) & ((\inst|SEB~0_combout\) # ((!\inst|Equal428~1_combout\ & \inst|Equal391~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SEB~0_combout\,
	datab => \inst|stage\(0),
	datac => \inst|Equal428~1_combout\,
	datad => \inst|Equal391~2_combout\,
	combout => \inst|SEB~1_combout\);

-- Location: LCCOMB_X30_Y29_N12
\inst|SEB~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SEB~5_combout\ = (\inst|SEB~3_combout\) # ((\inst|SEB~1_combout\) # ((\inst|stage\(0) & \inst|SEB~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage\(0),
	datab => \inst|SEB~4_combout\,
	datac => \inst|SEB~3_combout\,
	datad => \inst|SEB~1_combout\,
	combout => \inst|SEB~5_combout\);

-- Location: FF_X30_Y29_N13
\inst|SEB\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|SEB~5_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|SEB~q\);

-- Location: LCCOMB_X30_Y29_N20
\inst|ISSR~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|ISSR~0_combout\ = (\inst|ISSR~q\ & ((\inst|counter\(2)) # ((\inst|Equal1~0_combout\) # (!\inst|Equal3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ISSR~q\,
	datab => \inst|counter\(2),
	datac => \inst|Equal1~0_combout\,
	datad => \inst|Equal3~1_combout\,
	combout => \inst|ISSR~0_combout\);

-- Location: LCCOMB_X30_Y29_N26
\inst|ISSR~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|ISSR~1_combout\ = (\inst|stage\(0) & (\inst|ISSR~0_combout\)) # (!\inst|stage\(0) & (!\inst|Equal391~2_combout\ & ((\inst|ISSR~0_combout\) # (\inst|Equal2~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage\(0),
	datab => \inst|ISSR~0_combout\,
	datac => \inst|Equal2~2_combout\,
	datad => \inst|Equal391~2_combout\,
	combout => \inst|ISSR~1_combout\);

-- Location: FF_X30_Y29_N27
\inst|ISSR\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|ISSR~1_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|ISSR~q\);

-- Location: LCCOMB_X27_Y28_N10
\inst|SPHI1~81\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~81_combout\ = (!\inst|counter\(9) & (\inst|SPHI1~80_combout\ & \inst|SPHI1~78_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(9),
	datac => \inst|SPHI1~80_combout\,
	datad => \inst|SPHI1~78_combout\,
	combout => \inst|SPHI1~81_combout\);

-- Location: LCCOMB_X26_Y26_N20
\inst|Equal37~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal37~3_combout\ = (!\inst|counter\(1) & (\inst|Equal4~0_combout\ & (\inst|counter\(0) & \inst|SPHI1~81_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|Equal4~0_combout\,
	datac => \inst|counter\(0),
	datad => \inst|SPHI1~81_combout\,
	combout => \inst|Equal37~3_combout\);

-- Location: LCCOMB_X27_Y27_N12
\inst|Equal37~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal37~2_combout\ = (\inst|counter\(6) & !\inst|counter\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(6),
	datad => \inst|counter\(4),
	combout => \inst|Equal37~2_combout\);

-- Location: LCCOMB_X24_Y27_N28
\inst|Equal293~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal293~4_combout\ = (\inst|Equal37~3_combout\ & (\inst|Equal37~2_combout\ & (!\inst|counter\(7) & \inst|counter\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal37~3_combout\,
	datab => \inst|Equal37~2_combout\,
	datac => \inst|counter\(7),
	datad => \inst|counter\(8),
	combout => \inst|Equal293~4_combout\);

-- Location: LCCOMB_X24_Y27_N4
\inst|CAL~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|CAL~0_combout\ = (\inst|Equal1~1_combout\ & (\inst|CAL~q\ & ((\inst|stage\(0)) # (!\inst|Equal293~4_combout\)))) # (!\inst|Equal1~1_combout\ & (!\inst|stage\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000111010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage\(0),
	datab => \inst|Equal1~1_combout\,
	datac => \inst|CAL~q\,
	datad => \inst|Equal293~4_combout\,
	combout => \inst|CAL~0_combout\);

-- Location: FF_X24_Y27_N5
\inst|CAL\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|CAL~0_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|CAL~q\);

-- Location: LCCOMB_X30_Y29_N10
\inst|RBI~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RBI~0_combout\ = (\inst|stage\(0) & ((\inst|Equal1~0_combout\) # ((\inst|counter\(2)) # (!\inst|Equal3~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal1~0_combout\,
	datab => \inst|counter\(2),
	datac => \inst|stage\(0),
	datad => \inst|Equal3~1_combout\,
	combout => \inst|RBI~0_combout\);

-- Location: LCCOMB_X27_Y30_N14
\inst|Equal175~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal175~0_combout\ = (\inst|counter\(6) & !\inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(6),
	datad => \inst|counter\(5),
	combout => \inst|Equal175~0_combout\);

-- Location: LCCOMB_X24_Y29_N28
\inst|Equal397~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal397~1_combout\ = (!\inst|counter\(3) & (\inst|counter\(8) & (\inst|counter\(7) & \inst|Equal175~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(8),
	datac => \inst|counter\(7),
	datad => \inst|Equal175~0_combout\,
	combout => \inst|Equal397~1_combout\);

-- Location: LCCOMB_X28_Y29_N24
\inst|Equal397~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal397~2_combout\ = (\inst|Equal397~1_combout\ & (!\inst|counter\(1) & (!\inst|counter\(0) & \inst|SPHI1~81_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal397~1_combout\,
	datab => \inst|counter\(1),
	datac => \inst|counter\(0),
	datad => \inst|SPHI1~81_combout\,
	combout => \inst|Equal397~2_combout\);

-- Location: LCCOMB_X29_Y29_N4
\inst|SBI~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SBI~6_combout\ = (!\inst|stage\(0) & (((\inst|counter\(4)) # (\inst|counter\(2))) # (!\inst|Equal397~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|stage\(0),
	datab => \inst|Equal397~2_combout\,
	datac => \inst|counter\(4),
	datad => \inst|counter\(2),
	combout => \inst|SBI~6_combout\);

-- Location: LCCOMB_X26_Y27_N2
\inst|Equal6~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal6~1_combout\ = (\inst|counter\(5) & (!\inst|counter\(3) & !\inst|counter\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datac => \inst|counter\(3),
	datad => \inst|counter\(2),
	combout => \inst|Equal6~1_combout\);

-- Location: LCCOMB_X25_Y26_N22
\inst|Equal229~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal229~1_combout\ = (\inst|counter\(8) & (!\inst|counter\(7) & (!\inst|counter\(4) & !\inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(7),
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|Equal229~1_combout\);

-- Location: LCCOMB_X25_Y26_N4
\inst|Equal262~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal262~0_combout\ = (\inst|Equal6~1_combout\ & (!\inst|counter\(0) & (\inst|Equal135~0_combout\ & \inst|Equal229~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal6~1_combout\,
	datab => \inst|counter\(0),
	datac => \inst|Equal135~0_combout\,
	datad => \inst|Equal229~1_combout\,
	combout => \inst|Equal262~0_combout\);

-- Location: LCCOMB_X26_Y27_N16
\inst|SPHI2~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~20_combout\ = (\inst|counter\(7) & \inst|counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(7),
	datad => \inst|counter\(0),
	combout => \inst|SPHI2~20_combout\);

-- Location: LCCOMB_X29_Y27_N26
\inst|Equal245~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal245~0_combout\ = (\inst|counter\(4) & \inst|counter\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(4),
	datad => \inst|counter\(8),
	combout => \inst|Equal245~0_combout\);

-- Location: LCCOMB_X27_Y30_N4
\inst|Equal143~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal143~0_combout\ = (!\inst|counter\(6) & \inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(6),
	datad => \inst|counter\(5),
	combout => \inst|Equal143~0_combout\);

-- Location: LCCOMB_X27_Y25_N16
\inst|Equal17~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal17~0_combout\ = (!\inst|counter\(1) & (\inst|counter\(3) & \inst|Equal41~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datac => \inst|counter\(3),
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal17~0_combout\);

-- Location: LCCOMB_X27_Y27_N30
\inst|Equal394~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal394~0_combout\ = (\inst|SPHI2~20_combout\ & (\inst|Equal245~0_combout\ & (\inst|Equal143~0_combout\ & \inst|Equal17~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~20_combout\,
	datab => \inst|Equal245~0_combout\,
	datac => \inst|Equal143~0_combout\,
	datad => \inst|Equal17~0_combout\,
	combout => \inst|Equal394~0_combout\);

-- Location: LCCOMB_X29_Y26_N0
\inst|Equal264~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal264~0_combout\ = (\inst|Equal6~0_combout\ & (\inst|counter\(2) & (\inst|Equal3~1_combout\ & \inst|Equal229~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal6~0_combout\,
	datab => \inst|counter\(2),
	datac => \inst|Equal3~1_combout\,
	datad => \inst|Equal229~1_combout\,
	combout => \inst|Equal264~0_combout\);

-- Location: LCCOMB_X27_Y30_N28
\inst|Equal8~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal8~2_combout\ = (\inst|counter\(5) & (!\inst|counter\(3) & (\inst|Equal2~0_combout\ & \inst|counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(3),
	datac => \inst|Equal2~0_combout\,
	datad => \inst|counter\(2),
	combout => \inst|Equal8~2_combout\);

-- Location: LCCOMB_X29_Y29_N26
\inst|Equal136~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal136~3_combout\ = (!\inst|counter\(8) & (\inst|Equal3~1_combout\ & (\inst|counter\(7) & \inst|Equal8~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|Equal3~1_combout\,
	datac => \inst|counter\(7),
	datad => \inst|Equal8~2_combout\,
	combout => \inst|Equal136~3_combout\);

-- Location: LCCOMB_X27_Y30_N10
\inst|Equal3~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal3~3_combout\ = (!\inst|counter\(8) & !\inst|counter\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(8),
	datad => \inst|counter\(7),
	combout => \inst|Equal3~3_combout\);

-- Location: LCCOMB_X28_Y26_N0
\inst|Equal8~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal8~0_combout\ = (!\inst|counter\(1) & (!\inst|counter\(0) & (\inst|SPHI1~81_combout\ & \inst|Equal3~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|counter\(0),
	datac => \inst|SPHI1~81_combout\,
	datad => \inst|Equal3~3_combout\,
	combout => \inst|Equal8~0_combout\);

-- Location: LCCOMB_X28_Y26_N18
\inst|Equal8~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal8~1_combout\ = (\inst|Equal2~0_combout\ & (\inst|counter\(2) & (\inst|Equal6~0_combout\ & \inst|Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal2~0_combout\,
	datab => \inst|counter\(2),
	datac => \inst|Equal6~0_combout\,
	datad => \inst|Equal8~0_combout\,
	combout => \inst|Equal8~1_combout\);

-- Location: LCCOMB_X27_Y29_N0
\inst|Equal101~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal101~0_combout\ = (!\inst|counter\(8) & \inst|counter\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(8),
	datad => \inst|counter\(7),
	combout => \inst|Equal101~0_combout\);

-- Location: LCCOMB_X26_Y27_N28
\inst|Equal134~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal134~0_combout\ = (\inst|Equal101~0_combout\ & (\inst|Equal2~0_combout\ & (\inst|Equal6~1_combout\ & \inst|Equal4~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|Equal2~0_combout\,
	datac => \inst|Equal6~1_combout\,
	datad => \inst|Equal4~4_combout\,
	combout => \inst|Equal134~0_combout\);

-- Location: LCCOMB_X25_Y28_N4
\inst|Equal6~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal6~2_combout\ = (\inst|Equal6~1_combout\ & (\inst|Equal4~4_combout\ & (\inst|Equal2~0_combout\ & \inst|Equal3~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal6~1_combout\,
	datab => \inst|Equal4~4_combout\,
	datac => \inst|Equal2~0_combout\,
	datad => \inst|Equal3~3_combout\,
	combout => \inst|Equal6~2_combout\);

-- Location: LCCOMB_X29_Y29_N18
\inst|SBI~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SBI~2_combout\ = (\inst|Equal6~2_combout\) # ((!\inst|Equal2~2_combout\ & ((\inst|SBI~q\) # (!\inst|Equal1~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal6~2_combout\,
	datab => \inst|SBI~q\,
	datac => \inst|Equal1~1_combout\,
	datad => \inst|Equal2~2_combout\,
	combout => \inst|SBI~2_combout\);

-- Location: LCCOMB_X29_Y29_N20
\inst|SBI~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SBI~3_combout\ = (!\inst|Equal136~3_combout\ & ((\inst|Equal134~0_combout\) # ((!\inst|Equal8~1_combout\ & \inst|SBI~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal136~3_combout\,
	datab => \inst|Equal8~1_combout\,
	datac => \inst|Equal134~0_combout\,
	datad => \inst|SBI~2_combout\,
	combout => \inst|SBI~3_combout\);

-- Location: LCCOMB_X29_Y29_N14
\inst|SBI~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SBI~4_combout\ = (\inst|Equal394~0_combout\) # ((!\inst|Equal264~0_combout\ & ((\inst|Equal262~0_combout\) # (\inst|SBI~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal262~0_combout\,
	datab => \inst|Equal394~0_combout\,
	datac => \inst|Equal264~0_combout\,
	datad => \inst|SBI~3_combout\,
	combout => \inst|SBI~4_combout\);

-- Location: LCCOMB_X30_Y29_N28
\inst|SBI~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SBI~5_combout\ = (\inst|RBI~0_combout\ & ((\inst|SBI~q\) # ((\inst|SBI~6_combout\ & \inst|SBI~4_combout\)))) # (!\inst|RBI~0_combout\ & (\inst|SBI~6_combout\ & ((\inst|SBI~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|RBI~0_combout\,
	datab => \inst|SBI~6_combout\,
	datac => \inst|SBI~q\,
	datad => \inst|SBI~4_combout\,
	combout => \inst|SBI~5_combout\);

-- Location: FF_X30_Y29_N29
\inst|SBI\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|SBI~5_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|SBI~q\);

-- Location: LCCOMB_X29_Y28_N24
\inst|Equal363~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal363~2_combout\ = (\inst|counter\(7) & (\inst|counter\(8) & !\inst|counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datac => \inst|counter\(8),
	datad => \inst|counter\(5),
	combout => \inst|Equal363~2_combout\);

-- Location: LCCOMB_X23_Y28_N10
\inst|SPHI1~195\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~195_combout\ = (\inst|counter\(4) & (\inst|Equal363~2_combout\ & (\inst|Equal2~1_combout\ & \inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|Equal363~2_combout\,
	datac => \inst|Equal2~1_combout\,
	datad => \inst|counter\(6),
	combout => \inst|SPHI1~195_combout\);

-- Location: LCCOMB_X23_Y28_N28
\inst|SPHI1~84\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~84_combout\ = (\inst|Equal397~1_combout\ & (\inst|counter\(4) & (\inst|counter\(2) & \inst|Equal135~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal397~1_combout\,
	datab => \inst|counter\(4),
	datac => \inst|counter\(2),
	datad => \inst|Equal135~0_combout\,
	combout => \inst|SPHI1~84_combout\);

-- Location: LCCOMB_X23_Y28_N30
\inst|SPHI1~85\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~85_combout\ = (!\inst|stage\(0) & ((\inst|counter\(0)) # ((!\inst|SPHI1~195_combout\ & !\inst|SPHI1~84_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~195_combout\,
	datab => \inst|SPHI1~84_combout\,
	datac => \inst|stage\(0),
	datad => \inst|counter\(0),
	combout => \inst|SPHI1~85_combout\);

-- Location: LCCOMB_X23_Y28_N26
\inst|Equal397~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal397~0_combout\ = (!\inst|counter\(2) & !\inst|counter\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(2),
	datad => \inst|counter\(4),
	combout => \inst|Equal397~0_combout\);

-- Location: LCCOMB_X23_Y28_N0
\inst|Equal407~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal407~0_combout\ = (\inst|Equal37~2_combout\ & (!\inst|counter\(0) & (\inst|Equal2~1_combout\ & \inst|Equal363~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal37~2_combout\,
	datab => \inst|counter\(0),
	datac => \inst|Equal2~1_combout\,
	datad => \inst|Equal363~2_combout\,
	combout => \inst|Equal407~0_combout\);

-- Location: LCCOMB_X28_Y29_N18
\inst|Equal399~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal399~0_combout\ = (!\inst|counter\(0) & (\inst|Equal397~1_combout\ & \inst|Equal135~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datac => \inst|Equal397~1_combout\,
	datad => \inst|Equal135~0_combout\,
	combout => \inst|Equal399~0_combout\);

-- Location: LCCOMB_X29_Y29_N22
\inst|Equal413~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal413~0_combout\ = (\inst|counter\(4) & !\inst|counter\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(4),
	datad => \inst|counter\(2),
	combout => \inst|Equal413~0_combout\);

-- Location: LCCOMB_X25_Y26_N18
\inst|Equal395~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal395~0_combout\ = (!\inst|counter\(6) & (\inst|counter\(5) & (\inst|counter\(4) & \inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(5),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal395~0_combout\);

-- Location: LCCOMB_X26_Y25_N10
\inst|Equal377~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal377~0_combout\ = (\inst|counter\(7) & \inst|counter\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(7),
	datad => \inst|counter\(8),
	combout => \inst|Equal377~0_combout\);

-- Location: LCCOMB_X28_Y29_N8
\inst|Equal395~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal395~1_combout\ = (\inst|Equal4~4_combout\ & (\inst|counter\(2) & (\inst|Equal395~0_combout\ & \inst|Equal377~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~4_combout\,
	datab => \inst|counter\(2),
	datac => \inst|Equal395~0_combout\,
	datad => \inst|Equal377~0_combout\,
	combout => \inst|Equal395~1_combout\);

-- Location: LCCOMB_X25_Y29_N26
\inst|Equal409~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal409~0_combout\ = (\inst|counter\(2) & (\inst|counter\(6) & (!\inst|counter\(4) & \inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal409~0_combout\);

-- Location: LCCOMB_X28_Y29_N4
\inst|Equal401~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal401~0_combout\ = (\inst|counter\(2) & !\inst|counter\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(2),
	datad => \inst|counter\(4),
	combout => \inst|Equal401~0_combout\);

-- Location: LCCOMB_X25_Y29_N28
\inst|Equal231~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal231~0_combout\ = (!\inst|counter\(5) & \inst|counter\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(5),
	datad => \inst|counter\(8),
	combout => \inst|Equal231~0_combout\);

-- Location: LCCOMB_X28_Y29_N14
\inst|Equal411~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal411~0_combout\ = (!\inst|counter\(0) & (\inst|Equal231~0_combout\ & (\inst|counter\(7) & \inst|Equal135~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datab => \inst|Equal231~0_combout\,
	datac => \inst|counter\(7),
	datad => \inst|Equal135~0_combout\,
	combout => \inst|Equal411~0_combout\);

-- Location: LCCOMB_X28_Y29_N2
\inst|SPHI1~189\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~189_combout\ = (\inst|Equal409~0_combout\ & (!\inst|Equal411~0_combout\ & ((!\inst|Equal401~0_combout\) # (!\inst|Equal399~0_combout\)))) # (!\inst|Equal409~0_combout\ & (((!\inst|Equal401~0_combout\)) # (!\inst|Equal399~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal409~0_combout\,
	datab => \inst|Equal399~0_combout\,
	datac => \inst|Equal401~0_combout\,
	datad => \inst|Equal411~0_combout\,
	combout => \inst|SPHI1~189_combout\);

-- Location: LCCOMB_X28_Y29_N12
\inst|SPHI1~190\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~190_combout\ = (!\inst|Equal395~1_combout\ & (\inst|SPHI1~189_combout\ & ((!\inst|Equal413~0_combout\) # (!\inst|Equal399~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal399~0_combout\,
	datab => \inst|Equal413~0_combout\,
	datac => \inst|Equal395~1_combout\,
	datad => \inst|SPHI1~189_combout\,
	combout => \inst|SPHI1~190_combout\);

-- Location: LCCOMB_X23_Y28_N22
\inst|SPHI1~191\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~191_combout\ = (!\inst|Equal407~0_combout\ & (\inst|SPHI1~190_combout\ & ((!\inst|Equal399~0_combout\) # (!\inst|Equal397~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal397~0_combout\,
	datab => \inst|Equal407~0_combout\,
	datac => \inst|Equal399~0_combout\,
	datad => \inst|SPHI1~190_combout\,
	combout => \inst|SPHI1~191_combout\);

-- Location: LCCOMB_X24_Y28_N28
\inst|SPHI1~187\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~187_combout\ = (\inst|SPHI1~81_combout\ & (!\inst|counter\(1) & \inst|counter\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~81_combout\,
	datac => \inst|counter\(1),
	datad => \inst|counter\(0),
	combout => \inst|SPHI1~187_combout\);

-- Location: LCCOMB_X27_Y30_N24
\inst|SPHI1~151\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~151_combout\ = (\inst|counter\(4) & ((\inst|counter\(3)))) # (!\inst|counter\(4) & (!\inst|counter\(2) & !\inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(2),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~151_combout\);

-- Location: LCCOMB_X23_Y28_N4
\inst|SPHI1~188\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~188_combout\ = (\inst|counter\(6) & (\inst|Equal363~2_combout\ & ((!\inst|SPHI1~151_combout\) # (!\inst|counter\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(4),
	datac => \inst|SPHI1~151_combout\,
	datad => \inst|Equal363~2_combout\,
	combout => \inst|SPHI1~188_combout\);

-- Location: LCCOMB_X23_Y28_N24
\inst|SPHI1~192\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~192_combout\ = (\inst|SPHI1~191_combout\ & ((\inst|Equal394~0_combout\) # ((\inst|SPHI1~187_combout\ & \inst|SPHI1~188_combout\)))) # (!\inst|SPHI1~191_combout\ & (\inst|SPHI1~187_combout\ & (\inst|SPHI1~188_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~191_combout\,
	datab => \inst|SPHI1~187_combout\,
	datac => \inst|SPHI1~188_combout\,
	datad => \inst|Equal394~0_combout\,
	combout => \inst|SPHI1~192_combout\);

-- Location: LCCOMB_X29_Y29_N28
\inst|SPHI2~21\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~21_combout\ = (\inst|counter\(0) & (\inst|counter\(8) & (\inst|counter\(7) & !\inst|stage\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datab => \inst|counter\(8),
	datac => \inst|counter\(7),
	datad => \inst|stage\(0),
	combout => \inst|SPHI2~21_combout\);

-- Location: LCCOMB_X29_Y29_N2
\inst|SPHI1~194\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~194_combout\ = (!\inst|counter\(5) & (\inst|SPHI2~21_combout\ & (\inst|counter\(4) & \inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|SPHI2~21_combout\,
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|SPHI1~194_combout\);

-- Location: LCCOMB_X24_Y29_N22
\inst|SPHI1~82\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~82_combout\ = (\inst|counter\(3) & (\inst|SPHI1~81_combout\ & (!\inst|counter\(1) & \inst|SPHI1~194_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|SPHI1~81_combout\,
	datac => \inst|counter\(1),
	datad => \inst|SPHI1~194_combout\,
	combout => \inst|SPHI1~82_combout\);

-- Location: LCCOMB_X23_Y29_N30
\inst|SPHI1~83\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~83_combout\ = (\inst|RBI~0_combout\ & ((\inst|SPHI1~q\) # ((!\inst|counter\(2) & \inst|SPHI1~82_combout\)))) # (!\inst|RBI~0_combout\ & (((!\inst|counter\(2) & \inst|SPHI1~82_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|RBI~0_combout\,
	datab => \inst|SPHI1~q\,
	datac => \inst|counter\(2),
	datad => \inst|SPHI1~82_combout\,
	combout => \inst|SPHI1~83_combout\);

-- Location: LCCOMB_X23_Y26_N6
\inst|Equal229~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal229~0_combout\ = (\inst|counter\(8) & (!\inst|counter\(6) & !\inst|counter\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(6),
	datad => \inst|counter\(4),
	combout => \inst|Equal229~0_combout\);

-- Location: LCCOMB_X23_Y26_N10
\inst|Equal392~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal392~1_combout\ = (\inst|Equal229~0_combout\ & (\inst|Equal3~1_combout\ & (\inst|counter\(2) & \inst|Equal392~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal229~0_combout\,
	datab => \inst|Equal3~1_combout\,
	datac => \inst|counter\(2),
	datad => \inst|Equal392~0_combout\,
	combout => \inst|Equal392~1_combout\);

-- Location: LCCOMB_X24_Y29_N0
\inst|SPHI1~88\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~88_combout\ = (!\inst|counter\(4) & !\inst|counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~88_combout\);

-- Location: LCCOMB_X23_Y29_N4
\inst|SPHI1~89\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~89_combout\ = (\inst|Equal392~1_combout\) # ((\inst|Equal411~0_combout\ & (!\inst|counter\(6) & !\inst|SPHI1~88_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal392~1_combout\,
	datab => \inst|Equal411~0_combout\,
	datac => \inst|counter\(6),
	datad => \inst|SPHI1~88_combout\,
	combout => \inst|SPHI1~89_combout\);

-- Location: LCCOMB_X27_Y29_N10
\inst|Equal103~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal103~2_combout\ = (\inst|counter\(1) & (\inst|counter\(0) & \inst|counter\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datac => \inst|counter\(0),
	datad => \inst|counter\(7),
	combout => \inst|Equal103~2_combout\);

-- Location: LCCOMB_X28_Y28_N12
\inst|Equal103~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal103~3_combout\ = (\inst|Equal4~0_combout\ & (\inst|Equal103~2_combout\ & \inst|SPHI1~81_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Equal4~0_combout\,
	datac => \inst|Equal103~2_combout\,
	datad => \inst|SPHI1~81_combout\,
	combout => \inst|Equal103~3_combout\);

-- Location: LCCOMB_X25_Y26_N12
\inst|Equal245~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal245~1_combout\ = (\inst|counter\(8) & (\inst|counter\(4) & !\inst|counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|Equal245~1_combout\);

-- Location: LCCOMB_X28_Y29_N28
\inst|Equal123~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal123~0_combout\ = (!\inst|counter\(6) & \inst|counter\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(6),
	datad => \inst|counter\(4),
	combout => \inst|Equal123~0_combout\);

-- Location: LCCOMB_X28_Y27_N18
\inst|Equal367~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal367~0_combout\ = (\inst|Equal135~0_combout\ & (\inst|Equal363~2_combout\ & (!\inst|counter\(2) & \inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal135~0_combout\,
	datab => \inst|Equal363~2_combout\,
	datac => \inst|counter\(2),
	datad => \inst|counter\(3),
	combout => \inst|Equal367~0_combout\);

-- Location: LCCOMB_X29_Y27_N14
\inst|SPHI1~184\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~184_combout\ = (((!\inst|Equal2~0_combout\ & !\inst|Equal123~0_combout\)) # (!\inst|Equal367~0_combout\)) # (!\inst|counter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal2~0_combout\,
	datab => \inst|Equal123~0_combout\,
	datac => \inst|counter\(0),
	datad => \inst|Equal367~0_combout\,
	combout => \inst|SPHI1~184_combout\);

-- Location: LCCOMB_X28_Y27_N10
\inst|Equal363~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal363~3_combout\ = (\inst|counter\(1) & (\inst|counter\(0) & (\inst|Equal41~2_combout\ & \inst|Equal363~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|counter\(0),
	datac => \inst|Equal41~2_combout\,
	datad => \inst|Equal363~2_combout\,
	combout => \inst|Equal363~3_combout\);

-- Location: LCCOMB_X29_Y27_N10
\inst|SPHI1~207\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~207_combout\ = (\inst|counter\(6)) # (!\inst|Equal363~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(6),
	datad => \inst|Equal363~3_combout\,
	combout => \inst|SPHI1~207_combout\);

-- Location: LCCOMB_X29_Y27_N0
\inst|SPHI1~185\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~185_combout\ = (\inst|SPHI1~184_combout\ & (\inst|SPHI1~207_combout\ & ((!\inst|Equal245~1_combout\) # (!\inst|Equal103~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal103~3_combout\,
	datab => \inst|Equal245~1_combout\,
	datac => \inst|SPHI1~184_combout\,
	datad => \inst|SPHI1~207_combout\,
	combout => \inst|SPHI1~185_combout\);

-- Location: LCCOMB_X25_Y26_N2
\inst|Equal393~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal393~0_combout\ = (\inst|Equal3~1_combout\ & (\inst|counter\(7) & (\inst|Equal6~1_combout\ & \inst|Equal245~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~1_combout\,
	datab => \inst|counter\(7),
	datac => \inst|Equal6~1_combout\,
	datad => \inst|Equal245~1_combout\,
	combout => \inst|Equal393~0_combout\);

-- Location: LCCOMB_X28_Y29_N30
\inst|SPHI1~86\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~86_combout\ = (\inst|Equal395~1_combout\) # ((\inst|Equal393~0_combout\) # ((\inst|Equal409~0_combout\ & \inst|Equal411~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal409~0_combout\,
	datab => \inst|Equal395~1_combout\,
	datac => \inst|Equal393~0_combout\,
	datad => \inst|Equal411~0_combout\,
	combout => \inst|SPHI1~86_combout\);

-- Location: LCCOMB_X23_Y28_N8
\inst|SPHI1~208\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~208_combout\ = (!\inst|counter\(4)) # (!\inst|counter\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(2),
	datad => \inst|counter\(4),
	combout => \inst|SPHI1~208_combout\);

-- Location: LCCOMB_X23_Y28_N14
\inst|SPHI1~87\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~87_combout\ = (!\inst|SPHI1~86_combout\ & (!\inst|Equal407~0_combout\ & ((!\inst|Equal399~0_combout\) # (!\inst|SPHI1~208_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~86_combout\,
	datab => \inst|SPHI1~208_combout\,
	datac => \inst|Equal399~0_combout\,
	datad => \inst|Equal407~0_combout\,
	combout => \inst|SPHI1~87_combout\);

-- Location: LCCOMB_X27_Y29_N16
\inst|Equal7~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal7~1_combout\ = (\inst|counter\(1) & (!\inst|counter\(9) & (!\inst|counter\(2) & \inst|counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|counter\(9),
	datac => \inst|counter\(2),
	datad => \inst|counter\(5),
	combout => \inst|Equal7~1_combout\);

-- Location: LCCOMB_X28_Y28_N6
\inst|Equal7~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal7~0_combout\ = (\inst|counter\(0) & !\inst|counter\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(0),
	datad => \inst|counter\(7),
	combout => \inst|Equal7~0_combout\);

-- Location: LCCOMB_X28_Y28_N20
\inst|Equal7~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal7~2_combout\ = (\inst|SPHI1~78_combout\ & (\inst|Equal7~1_combout\ & (\inst|SPHI1~80_combout\ & \inst|Equal7~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~78_combout\,
	datab => \inst|Equal7~1_combout\,
	datac => \inst|SPHI1~80_combout\,
	datad => \inst|Equal7~0_combout\,
	combout => \inst|Equal7~2_combout\);

-- Location: LCCOMB_X29_Y28_N30
\inst|Equal15~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal15~0_combout\ = (\inst|counter\(3) & \inst|Equal7~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(3),
	datad => \inst|Equal7~2_combout\,
	combout => \inst|Equal15~0_combout\);

-- Location: LCCOMB_X29_Y27_N8
\inst|Equal325~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal325~0_combout\ = (\inst|counter\(8) & (!\inst|counter\(4) & \inst|counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|Equal325~0_combout\);

-- Location: LCCOMB_X29_Y27_N30
\inst|SPHI1~94\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~94_combout\ = (\inst|Equal15~0_combout\ & (!\inst|Equal325~0_combout\ & ((!\inst|Equal103~3_combout\) # (!\inst|Equal229~0_combout\)))) # (!\inst|Equal15~0_combout\ & (((!\inst|Equal103~3_combout\) # (!\inst|Equal229~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal15~0_combout\,
	datab => \inst|Equal325~0_combout\,
	datac => \inst|Equal229~0_combout\,
	datad => \inst|Equal103~3_combout\,
	combout => \inst|SPHI1~94_combout\);

-- Location: LCCOMB_X29_Y27_N12
\inst|SPHI1~196\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~196_combout\ = (\inst|counter\(0) & (\inst|counter\(6) & (!\inst|counter\(7) & \inst|Equal7~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datab => \inst|counter\(6),
	datac => \inst|counter\(7),
	datad => \inst|Equal7~1_combout\,
	combout => \inst|SPHI1~196_combout\);

-- Location: LCCOMB_X29_Y27_N16
\inst|SPHI1~95\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~95_combout\ = (((!\inst|SPHI1~196_combout\) # (!\inst|SPHI1~78_combout\)) # (!\inst|SPHI1~80_combout\)) # (!\inst|Equal245~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal245~0_combout\,
	datab => \inst|SPHI1~80_combout\,
	datac => \inst|SPHI1~78_combout\,
	datad => \inst|SPHI1~196_combout\,
	combout => \inst|SPHI1~95_combout\);

-- Location: LCCOMB_X27_Y27_N0
\inst|Equal434~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal434~4_combout\ = (\inst|counter\(0) & \inst|counter\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(0),
	datad => \inst|counter\(1),
	combout => \inst|Equal434~4_combout\);

-- Location: LCCOMB_X27_Y29_N14
\inst|Equal11~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal11~2_combout\ = (!\inst|counter\(7) & (!\inst|counter\(9) & (\inst|counter\(2) & \inst|counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(9),
	datac => \inst|counter\(2),
	datad => \inst|counter\(5),
	combout => \inst|Equal11~2_combout\);

-- Location: LCCOMB_X27_Y28_N14
\inst|Equal11~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal11~3_combout\ = (\inst|Equal434~4_combout\ & (\inst|SPHI1~78_combout\ & (\inst|SPHI1~80_combout\ & \inst|Equal11~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal434~4_combout\,
	datab => \inst|SPHI1~78_combout\,
	datac => \inst|SPHI1~80_combout\,
	datad => \inst|Equal11~2_combout\,
	combout => \inst|Equal11~3_combout\);

-- Location: LCCOMB_X25_Y27_N12
\inst|Equal333~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal333~0_combout\ = (\inst|counter\(8) & (\inst|counter\(6) & (\inst|counter\(3) & !\inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(6),
	datac => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|Equal333~0_combout\);

-- Location: LCCOMB_X29_Y27_N2
\inst|SPHI1~96\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~96_combout\ = ((!\inst|Equal333~0_combout\ & ((\inst|counter\(3)) # (!\inst|Equal309~0_combout\)))) # (!\inst|Equal11~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101110101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal11~3_combout\,
	datab => \inst|counter\(3),
	datac => \inst|Equal333~0_combout\,
	datad => \inst|Equal309~0_combout\,
	combout => \inst|SPHI1~96_combout\);

-- Location: LCCOMB_X29_Y27_N20
\inst|Equal355~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal355~0_combout\ = (\inst|Equal11~3_combout\ & (\inst|counter\(6) & (\inst|Equal245~0_combout\ & \inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal11~3_combout\,
	datab => \inst|counter\(6),
	datac => \inst|Equal245~0_combout\,
	datad => \inst|counter\(3),
	combout => \inst|Equal355~0_combout\);

-- Location: LCCOMB_X29_Y27_N22
\inst|SPHI1~97\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~97_combout\ = (\inst|SPHI1~94_combout\ & (\inst|SPHI1~95_combout\ & (\inst|SPHI1~96_combout\ & !\inst|Equal355~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~94_combout\,
	datab => \inst|SPHI1~95_combout\,
	datac => \inst|SPHI1~96_combout\,
	datad => \inst|Equal355~0_combout\,
	combout => \inst|SPHI1~97_combout\);

-- Location: LCCOMB_X23_Y26_N20
\inst|Equal249~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal249~0_combout\ = (!\inst|counter\(7) & \inst|counter\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datad => \inst|counter\(8),
	combout => \inst|Equal249~0_combout\);

-- Location: LCCOMB_X26_Y27_N8
\inst|SPHI1~181\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~181_combout\ = (\inst|counter\(5) & (!\inst|counter\(4) & ((!\inst|counter\(3)) # (!\inst|counter\(2))))) # (!\inst|counter\(5) & (((\inst|counter\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(2),
	datac => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|SPHI1~181_combout\);

-- Location: LCCOMB_X26_Y27_N26
\inst|SPHI1~182\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~182_combout\ = (\inst|Equal249~0_combout\ & (\inst|counter\(6) & (\inst|SPHI1~181_combout\ & \inst|Equal4~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal249~0_combout\,
	datab => \inst|counter\(6),
	datac => \inst|SPHI1~181_combout\,
	datad => \inst|Equal4~4_combout\,
	combout => \inst|SPHI1~182_combout\);

-- Location: LCCOMB_X27_Y30_N16
\inst|Equal9~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal9~1_combout\ = (!\inst|counter\(6) & (!\inst|counter\(4) & !\inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal9~1_combout\);

-- Location: LCCOMB_X29_Y28_N20
\inst|SPHI1~92\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~92_combout\ = (\inst|counter\(7) & (!\inst|counter\(5) & \inst|Equal9~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datac => \inst|counter\(5),
	datad => \inst|Equal9~1_combout\,
	combout => \inst|SPHI1~92_combout\);

-- Location: LCCOMB_X27_Y29_N4
\inst|SPHI1~90\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~90_combout\ = (!\inst|counter\(4) & ((!\inst|counter\(3)) # (!\inst|counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|SPHI1~90_combout\);

-- Location: LCCOMB_X29_Y28_N14
\inst|SPHI1~91\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~91_combout\ = (!\inst|counter\(7) & (\inst|counter\(6) & (!\inst|SPHI1~90_combout\ & \inst|counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(6),
	datac => \inst|SPHI1~90_combout\,
	datad => \inst|counter\(5),
	combout => \inst|SPHI1~91_combout\);

-- Location: LCCOMB_X28_Y28_N10
\inst|SPHI1~93\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~93_combout\ = (\inst|Equal4~4_combout\ & (\inst|counter\(8) & ((\inst|SPHI1~92_combout\) # (\inst|SPHI1~91_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~92_combout\,
	datab => \inst|Equal4~4_combout\,
	datac => \inst|SPHI1~91_combout\,
	datad => \inst|counter\(8),
	combout => \inst|SPHI1~93_combout\);

-- Location: LCCOMB_X24_Y26_N16
\inst|SPHI1~104\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~104_combout\ = (\inst|counter\(4) & ((\inst|counter\(2)) # (\inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datac => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|SPHI1~104_combout\);

-- Location: LCCOMB_X23_Y26_N4
\inst|SPHI1~204\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~204_combout\ = (\inst|counter\(6) & (!\inst|counter\(4) & (!\inst|counter\(5)))) # (!\inst|counter\(6) & (((\inst|counter\(5) & \inst|SPHI1~104_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011010000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(6),
	datac => \inst|counter\(5),
	datad => \inst|SPHI1~104_combout\,
	combout => \inst|SPHI1~204_combout\);

-- Location: LCCOMB_X23_Y28_N12
\inst|SPHI1~105\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~105_combout\ = (\inst|SPHI1~204_combout\ & (!\inst|counter\(0) & (\inst|Equal249~0_combout\ & \inst|Equal135~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~204_combout\,
	datab => \inst|counter\(0),
	datac => \inst|Equal249~0_combout\,
	datad => \inst|Equal135~0_combout\,
	combout => \inst|SPHI1~105_combout\);

-- Location: LCCOMB_X27_Y29_N12
\inst|Equal7~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal7~3_combout\ = (\inst|counter\(1) & (!\inst|counter\(2) & !\inst|counter\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datac => \inst|counter\(2),
	datad => \inst|counter\(9),
	combout => \inst|Equal7~3_combout\);

-- Location: LCCOMB_X28_Y28_N14
\inst|Equal7~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal7~4_combout\ = (\inst|Equal7~0_combout\ & (\inst|SPHI1~80_combout\ & (\inst|SPHI1~78_combout\ & \inst|Equal7~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal7~0_combout\,
	datab => \inst|SPHI1~80_combout\,
	datac => \inst|SPHI1~78_combout\,
	datad => \inst|Equal7~3_combout\,
	combout => \inst|Equal7~4_combout\);

-- Location: LCCOMB_X27_Y27_N14
\inst|SPHI1~98\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~98_combout\ = (\inst|Equal434~4_combout\ & (!\inst|counter\(3) & (!\inst|counter\(7) & \inst|Equal41~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal434~4_combout\,
	datab => \inst|counter\(3),
	datac => \inst|counter\(7),
	datad => \inst|Equal41~2_combout\,
	combout => \inst|SPHI1~98_combout\);

-- Location: LCCOMB_X28_Y27_N2
\inst|SPHI1~99\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~99_combout\ = (((!\inst|Equal7~4_combout\ & !\inst|SPHI1~98_combout\)) # (!\inst|Equal245~0_combout\)) # (!\inst|Equal175~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal175~0_combout\,
	datab => \inst|Equal7~4_combout\,
	datac => \inst|Equal245~0_combout\,
	datad => \inst|SPHI1~98_combout\,
	combout => \inst|SPHI1~99_combout\);

-- Location: LCCOMB_X26_Y27_N14
\inst|Equal45~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal45~0_combout\ = (\inst|counter\(6) & (\inst|counter\(3) & !\inst|counter\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(6),
	datac => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|Equal45~0_combout\);

-- Location: LCCOMB_X29_Y27_N28
\inst|Equal227~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal227~0_combout\ = (\inst|counter\(6) & (\inst|counter\(4) & \inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal227~0_combout\);

-- Location: LCCOMB_X28_Y27_N20
\inst|Equal235~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal235~0_combout\ = (\inst|Equal231~0_combout\ & (\inst|Equal41~2_combout\ & (\inst|Equal434~4_combout\ & !\inst|counter\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal231~0_combout\,
	datab => \inst|Equal41~2_combout\,
	datac => \inst|Equal434~4_combout\,
	datad => \inst|counter\(7),
	combout => \inst|Equal235~0_combout\);

-- Location: LCCOMB_X28_Y27_N14
\inst|SPHI1~100\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~100_combout\ = ((!\inst|Equal45~0_combout\ & !\inst|Equal227~0_combout\)) # (!\inst|Equal235~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal45~0_combout\,
	datab => \inst|Equal227~0_combout\,
	datad => \inst|Equal235~0_combout\,
	combout => \inst|SPHI1~100_combout\);

-- Location: LCCOMB_X29_Y27_N18
\inst|SPHI1~101\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~101_combout\ = (\inst|counter\(8) & (!\inst|counter\(4) & \inst|counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|SPHI1~101_combout\);

-- Location: LCCOMB_X29_Y27_N4
\inst|SPHI1~102\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~102_combout\ = (\inst|Equal11~3_combout\ & ((\inst|Equal325~0_combout\) # ((\inst|SPHI1~101_combout\ & \inst|Equal7~2_combout\)))) # (!\inst|Equal11~3_combout\ & (\inst|SPHI1~101_combout\ & ((\inst|Equal7~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal11~3_combout\,
	datab => \inst|SPHI1~101_combout\,
	datac => \inst|Equal325~0_combout\,
	datad => \inst|Equal7~2_combout\,
	combout => \inst|SPHI1~102_combout\);

-- Location: LCCOMB_X28_Y27_N12
\inst|SPHI1~103\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~103_combout\ = (\inst|SPHI1~99_combout\ & (\inst|SPHI1~100_combout\ & ((\inst|counter\(3)) # (!\inst|SPHI1~102_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|SPHI1~99_combout\,
	datac => \inst|SPHI1~100_combout\,
	datad => \inst|SPHI1~102_combout\,
	combout => \inst|SPHI1~103_combout\);

-- Location: LCCOMB_X25_Y27_N6
\inst|Equal285~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal285~0_combout\ = (\inst|counter\(8) & (!\inst|counter\(6) & (\inst|counter\(3) & \inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(6),
	datac => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|Equal285~0_combout\);

-- Location: LCCOMB_X25_Y27_N26
\inst|Equal279~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal279~0_combout\ = (!\inst|counter\(3) & (\inst|counter\(4) & \inst|Equal7~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(4),
	datac => \inst|Equal7~2_combout\,
	combout => \inst|Equal279~0_combout\);

-- Location: LCCOMB_X25_Y27_N16
\inst|SPHI1~175\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~175_combout\ = ((!\inst|Equal285~0_combout\ & ((\inst|counter\(3)) # (!\inst|Equal245~1_combout\)))) # (!\inst|Equal11~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111110111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|Equal245~1_combout\,
	datac => \inst|Equal11~3_combout\,
	datad => \inst|Equal285~0_combout\,
	combout => \inst|SPHI1~175_combout\);

-- Location: LCCOMB_X25_Y27_N0
\inst|SPHI1~176\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~176_combout\ = (\inst|SPHI1~175_combout\ & (((\inst|counter\(6)) # (!\inst|Equal279~0_combout\)) # (!\inst|counter\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(6),
	datac => \inst|Equal279~0_combout\,
	datad => \inst|SPHI1~175_combout\,
	combout => \inst|SPHI1~176_combout\);

-- Location: LCCOMB_X24_Y27_N20
\inst|Equal295~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal295~0_combout\ = (\inst|counter\(8) & !\inst|counter\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datad => \inst|counter\(4),
	combout => \inst|Equal295~0_combout\);

-- Location: LCCOMB_X27_Y27_N16
\inst|Equal11~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal11~5_combout\ = (\inst|counter\(1) & (\inst|counter\(0) & \inst|Equal41~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datac => \inst|counter\(0),
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal11~5_combout\);

-- Location: LCCOMB_X26_Y27_N18
\inst|SPHI1~177\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~177_combout\ = (!\inst|counter\(7) & (!\inst|counter\(3) & \inst|Equal11~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datac => \inst|counter\(3),
	datad => \inst|Equal11~5_combout\,
	combout => \inst|SPHI1~177_combout\);

-- Location: LCCOMB_X25_Y27_N18
\inst|SPHI1~178\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~178_combout\ = (((!\inst|Equal7~4_combout\ & !\inst|SPHI1~177_combout\)) # (!\inst|Equal295~0_combout\)) # (!\inst|Equal175~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal175~0_combout\,
	datab => \inst|Equal295~0_combout\,
	datac => \inst|Equal7~4_combout\,
	datad => \inst|SPHI1~177_combout\,
	combout => \inst|SPHI1~178_combout\);

-- Location: LCCOMB_X24_Y27_N30
\inst|SPHI1~179\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~179_combout\ = (\inst|SPHI1~176_combout\ & (\inst|SPHI1~178_combout\ & ((!\inst|Equal7~2_combout\) # (!\inst|Equal285~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal285~0_combout\,
	datab => \inst|SPHI1~176_combout\,
	datac => \inst|Equal7~2_combout\,
	datad => \inst|SPHI1~178_combout\,
	combout => \inst|SPHI1~179_combout\);

-- Location: LCCOMB_X23_Y26_N12
\inst|SPHI1~106\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~106_combout\ = (\inst|counter\(5) & (\inst|counter\(4) $ (((\inst|counter\(2)) # (\inst|counter\(3)))))) # (!\inst|counter\(5) & (\inst|counter\(4) & ((\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(2),
	datac => \inst|counter\(5),
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~106_combout\);

-- Location: LCCOMB_X23_Y26_N14
\inst|SPHI1~107\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~107_combout\ = (\inst|SPHI1~106_combout\ & (\inst|Equal4~4_combout\ & (!\inst|counter\(6) & \inst|Equal249~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~106_combout\,
	datab => \inst|Equal4~4_combout\,
	datac => \inst|counter\(6),
	datad => \inst|Equal249~0_combout\,
	combout => \inst|SPHI1~107_combout\);

-- Location: LCCOMB_X24_Y26_N2
\inst|SPHI1~108\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~108_combout\ = ((!\inst|Equal11~3_combout\ & !\inst|Equal7~2_combout\)) # (!\inst|Equal229~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal11~3_combout\,
	datac => \inst|Equal229~0_combout\,
	datad => \inst|Equal7~2_combout\,
	combout => \inst|SPHI1~108_combout\);

-- Location: LCCOMB_X24_Y26_N4
\inst|SPHI1~109\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~109_combout\ = (\inst|SPHI1~107_combout\) # ((\inst|SPHI1~108_combout\ & \inst|Equal262~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~107_combout\,
	datab => \inst|SPHI1~108_combout\,
	datad => \inst|Equal262~0_combout\,
	combout => \inst|SPHI1~109_combout\);

-- Location: LCCOMB_X24_Y29_N6
\inst|SPHI1~112\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~112_combout\ = (!\inst|counter\(8) & (\inst|counter\(4) & (\inst|counter\(2) & \inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(4),
	datac => \inst|counter\(2),
	datad => \inst|counter\(6),
	combout => \inst|SPHI1~112_combout\);

-- Location: LCCOMB_X25_Y29_N16
\inst|SPHI2~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~22_combout\ = (!\inst|counter\(7) & (!\inst|counter\(5) & (!\inst|counter\(6) & \inst|counter\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(5),
	datac => \inst|counter\(6),
	datad => \inst|counter\(8),
	combout => \inst|SPHI2~22_combout\);

-- Location: LCCOMB_X25_Y29_N14
\inst|SPHI1~111\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~111_combout\ = (\inst|SPHI2~22_combout\ & ((!\inst|counter\(4)) # (!\inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datac => \inst|counter\(4),
	datad => \inst|SPHI2~22_combout\,
	combout => \inst|SPHI1~111_combout\);

-- Location: LCCOMB_X24_Y29_N24
\inst|SPHI1~113\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~113_combout\ = (\inst|Equal4~4_combout\ & ((\inst|SPHI1~111_combout\) # ((\inst|SPHI1~112_combout\ & \inst|Equal392~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~112_combout\,
	datab => \inst|SPHI1~111_combout\,
	datac => \inst|Equal392~0_combout\,
	datad => \inst|Equal4~4_combout\,
	combout => \inst|SPHI1~113_combout\);

-- Location: LCCOMB_X28_Y27_N6
\inst|Equal231~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal231~1_combout\ = (\inst|Equal231~0_combout\ & (!\inst|counter\(2) & (\inst|Equal135~0_combout\ & \inst|Equal7~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal231~0_combout\,
	datab => \inst|counter\(2),
	datac => \inst|Equal135~0_combout\,
	datad => \inst|Equal7~0_combout\,
	combout => \inst|Equal231~1_combout\);

-- Location: LCCOMB_X28_Y27_N0
\inst|SPHI1~110\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~110_combout\ = ((!\inst|Equal235~0_combout\ & ((!\inst|Equal231~1_combout\) # (!\inst|counter\(3))))) # (!\inst|Equal123~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|Equal235~0_combout\,
	datac => \inst|Equal123~0_combout\,
	datad => \inst|Equal231~1_combout\,
	combout => \inst|SPHI1~110_combout\);

-- Location: LCCOMB_X28_Y27_N8
\inst|SPHI1~197\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~197_combout\ = (\inst|SPHI1~110_combout\ & (((!\inst|Equal7~2_combout\ & !\inst|Equal11~3_combout\)) # (!\inst|Equal229~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal229~0_combout\,
	datab => \inst|Equal7~2_combout\,
	datac => \inst|Equal11~3_combout\,
	datad => \inst|SPHI1~110_combout\,
	combout => \inst|SPHI1~197_combout\);

-- Location: LCCOMB_X24_Y29_N30
\inst|SPHI1~119\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~119_combout\ = ((!\inst|counter\(3)) # (!\inst|counter\(2))) # (!\inst|counter\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(4),
	datac => \inst|counter\(2),
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~119_combout\);

-- Location: LCCOMB_X25_Y28_N30
\inst|Equal207~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal207~0_combout\ = (\inst|counter\(6) & \inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(6),
	datad => \inst|counter\(5),
	combout => \inst|Equal207~0_combout\);

-- Location: LCCOMB_X25_Y28_N20
\inst|SPHI1~120\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~120_combout\ = (\inst|SPHI1~119_combout\ & (\inst|Equal4~4_combout\ & (\inst|Equal207~0_combout\ & \inst|Equal101~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~119_combout\,
	datab => \inst|Equal4~4_combout\,
	datac => \inst|Equal207~0_combout\,
	datad => \inst|Equal101~0_combout\,
	combout => \inst|SPHI1~120_combout\);

-- Location: LCCOMB_X28_Y27_N22
\inst|SPHI1~116\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~116_combout\ = (\inst|Equal101~0_combout\ & (\inst|counter\(5) & (\inst|Equal434~4_combout\ & \inst|Equal227~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|counter\(5),
	datac => \inst|Equal434~4_combout\,
	datad => \inst|Equal227~0_combout\,
	combout => \inst|SPHI1~116_combout\);

-- Location: LCCOMB_X25_Y29_N4
\inst|Equal3~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal3~4_combout\ = (!\inst|counter\(6) & (!\inst|counter\(4) & \inst|counter\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal3~4_combout\);

-- Location: LCCOMB_X28_Y27_N28
\inst|SPHI1~117\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~117_combout\ = (\inst|Equal231~1_combout\ & ((\inst|Equal3~4_combout\) # ((\inst|Equal9~1_combout\)))) # (!\inst|Equal231~1_combout\ & (\inst|Equal235~0_combout\ & ((\inst|Equal3~4_combout\) # (\inst|Equal9~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal231~1_combout\,
	datab => \inst|Equal3~4_combout\,
	datac => \inst|Equal9~1_combout\,
	datad => \inst|Equal235~0_combout\,
	combout => \inst|SPHI1~117_combout\);

-- Location: LCCOMB_X27_Y27_N20
\inst|SPHI1~198\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~198_combout\ = (\inst|counter\(5) & (!\inst|counter\(8) & (\inst|counter\(7) & \inst|counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(8),
	datac => \inst|counter\(7),
	datad => \inst|counter\(0),
	combout => \inst|SPHI1~198_combout\);

-- Location: LCCOMB_X28_Y27_N26
\inst|SPHI1~114\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~114_combout\ = (\inst|counter\(4) & ((\inst|counter\(6) & ((\inst|SPHI1~198_combout\))) # (!\inst|counter\(6) & (!\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(3),
	datac => \inst|counter\(6),
	datad => \inst|SPHI1~198_combout\,
	combout => \inst|SPHI1~114_combout\);

-- Location: LCCOMB_X28_Y27_N24
\inst|SPHI1~115\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~115_combout\ = ((\inst|counter\(6) & (!\inst|Equal2~1_combout\)) # (!\inst|counter\(6) & ((!\inst|Equal231~1_combout\)))) # (!\inst|SPHI1~114_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~114_combout\,
	datab => \inst|Equal2~1_combout\,
	datac => \inst|counter\(6),
	datad => \inst|Equal231~1_combout\,
	combout => \inst|SPHI1~115_combout\);

-- Location: LCCOMB_X28_Y27_N30
\inst|SPHI1~118\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~118_combout\ = (!\inst|SPHI1~117_combout\ & (\inst|SPHI1~115_combout\ & ((!\inst|Equal41~2_combout\) # (!\inst|SPHI1~116_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~116_combout\,
	datab => \inst|SPHI1~117_combout\,
	datac => \inst|Equal41~2_combout\,
	datad => \inst|SPHI1~115_combout\,
	combout => \inst|SPHI1~118_combout\);

-- Location: LCCOMB_X28_Y25_N20
\inst|Equal4~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal4~5_combout\ = (\inst|counter\(4) & !\inst|counter\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(4),
	datad => \inst|counter\(8),
	combout => \inst|Equal4~5_combout\);

-- Location: LCCOMB_X27_Y27_N8
\inst|Equal151~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal151~0_combout\ = (\inst|SPHI1~81_combout\ & (\inst|Equal4~5_combout\ & (\inst|Equal103~2_combout\ & \inst|Equal6~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~81_combout\,
	datab => \inst|Equal4~5_combout\,
	datac => \inst|Equal103~2_combout\,
	datad => \inst|Equal6~1_combout\,
	combout => \inst|Equal151~0_combout\);

-- Location: LCCOMB_X26_Y27_N24
\inst|Equal199~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal199~0_combout\ = (\inst|Equal6~1_combout\ & (!\inst|counter\(4) & (\inst|Equal135~0_combout\ & \inst|SPHI2~20_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal6~1_combout\,
	datab => \inst|counter\(4),
	datac => \inst|Equal135~0_combout\,
	datad => \inst|SPHI2~20_combout\,
	combout => \inst|Equal199~0_combout\);

-- Location: LCCOMB_X26_Y27_N6
\inst|SPHI1~171\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~171_combout\ = (\inst|counter\(6) & ((\inst|Equal151~0_combout\) # ((!\inst|counter\(8) & \inst|Equal199~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(6),
	datac => \inst|Equal151~0_combout\,
	datad => \inst|Equal199~0_combout\,
	combout => \inst|SPHI1~171_combout\);

-- Location: LCCOMB_X26_Y27_N4
\inst|Equal139~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal139~1_combout\ = (\inst|counter\(5) & (\inst|Equal434~4_combout\ & (\inst|Equal101~0_combout\ & \inst|Equal41~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal434~4_combout\,
	datac => \inst|Equal101~0_combout\,
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal139~1_combout\);

-- Location: LCCOMB_X25_Y25_N12
\inst|Equal193~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal193~0_combout\ = (\inst|counter\(4) & \inst|counter\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|Equal193~0_combout\);

-- Location: LCCOMB_X26_Y27_N30
\inst|SPHI1~170\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~170_combout\ = (\inst|Equal45~0_combout\) # ((!\inst|counter\(3) & ((\inst|Equal193~0_combout\) # (\inst|Equal37~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110111011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|Equal45~0_combout\,
	datac => \inst|Equal193~0_combout\,
	datad => \inst|Equal37~2_combout\,
	combout => \inst|SPHI1~170_combout\);

-- Location: LCCOMB_X27_Y27_N10
\inst|Equal107~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal107~5_combout\ = (\inst|counter\(7) & (\inst|Equal434~4_combout\ & (!\inst|counter\(8) & \inst|Equal41~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|Equal434~4_combout\,
	datac => \inst|counter\(8),
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal107~5_combout\);

-- Location: LCCOMB_X27_Y27_N28
\inst|SPHI1~168\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~168_combout\ = (\inst|counter\(6) & ((\inst|counter\(5) & ((!\inst|counter\(4)))) # (!\inst|counter\(5) & (\inst|counter\(3) & \inst|counter\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(3),
	datac => \inst|counter\(4),
	datad => \inst|counter\(6),
	combout => \inst|SPHI1~168_combout\);

-- Location: LCCOMB_X27_Y27_N6
\inst|SPHI1~203\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~203_combout\ = (\inst|counter\(7) & (\inst|counter\(0) & (!\inst|counter\(8) & \inst|Equal2~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(0),
	datac => \inst|counter\(8),
	datad => \inst|Equal2~1_combout\,
	combout => \inst|SPHI1~203_combout\);

-- Location: LCCOMB_X27_Y27_N18
\inst|SPHI1~169\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~169_combout\ = ((\inst|counter\(4) & (!\inst|Equal107~5_combout\)) # (!\inst|counter\(4) & ((!\inst|SPHI1~203_combout\)))) # (!\inst|SPHI1~168_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal107~5_combout\,
	datab => \inst|SPHI1~168_combout\,
	datac => \inst|counter\(4),
	datad => \inst|SPHI1~203_combout\,
	combout => \inst|SPHI1~169_combout\);

-- Location: LCCOMB_X26_Y27_N20
\inst|SPHI1~172\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~172_combout\ = (!\inst|SPHI1~171_combout\ & (\inst|SPHI1~169_combout\ & ((!\inst|SPHI1~170_combout\) # (!\inst|Equal139~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~171_combout\,
	datab => \inst|Equal139~1_combout\,
	datac => \inst|SPHI1~170_combout\,
	datad => \inst|SPHI1~169_combout\,
	combout => \inst|SPHI1~172_combout\);

-- Location: LCCOMB_X24_Y29_N8
\inst|SPHI1~121\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~121_combout\ = (\inst|counter\(6) & (\inst|Equal101~0_combout\ & ((\inst|counter\(2)) # (!\inst|SPHI1~88_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(2),
	datac => \inst|Equal101~0_combout\,
	datad => \inst|SPHI1~88_combout\,
	combout => \inst|SPHI1~121_combout\);

-- Location: LCCOMB_X24_Y28_N22
\inst|SPHI1~122\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~122_combout\ = (!\inst|counter\(5) & (!\inst|counter\(0) & (\inst|Equal135~0_combout\ & \inst|SPHI1~121_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(0),
	datac => \inst|Equal135~0_combout\,
	datad => \inst|SPHI1~121_combout\,
	combout => \inst|SPHI1~122_combout\);

-- Location: LCCOMB_X25_Y29_N12
\inst|SPHI1~199\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~199_combout\ = (\inst|counter\(5) & (!\inst|counter\(6) & ((\inst|counter\(4)) # (\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~199_combout\);

-- Location: LCCOMB_X24_Y29_N2
\inst|SPHI1~127\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~127_combout\ = (!\inst|counter\(3) & (!\inst|counter\(4) & (!\inst|counter\(2) & \inst|Equal175~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(4),
	datac => \inst|counter\(2),
	datad => \inst|Equal175~0_combout\,
	combout => \inst|SPHI1~127_combout\);

-- Location: LCCOMB_X24_Y29_N12
\inst|SPHI1~128\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~128_combout\ = (\inst|Equal4~4_combout\ & (\inst|Equal101~0_combout\ & ((\inst|SPHI1~199_combout\) # (\inst|SPHI1~127_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~4_combout\,
	datab => \inst|SPHI1~199_combout\,
	datac => \inst|Equal101~0_combout\,
	datad => \inst|SPHI1~127_combout\,
	combout => \inst|SPHI1~128_combout\);

-- Location: LCCOMB_X27_Y25_N2
\inst|Equal53~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal53~0_combout\ = (\inst|counter\(6) & (!\inst|counter\(8) & \inst|counter\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datac => \inst|counter\(8),
	datad => \inst|counter\(4),
	combout => \inst|Equal53~0_combout\);

-- Location: LCCOMB_X29_Y28_N8
\inst|SPHI1~205\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~205_combout\ = (\inst|counter\(6) & (!\inst|counter\(5) & ((!\inst|counter\(3)) # (!\inst|counter\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(5),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~205_combout\);

-- Location: LCCOMB_X29_Y28_N22
\inst|SPHI1~125\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~125_combout\ = (((!\inst|Equal41~2_combout\) # (!\inst|SPHI1~205_combout\)) # (!\inst|Equal434~4_combout\)) # (!\inst|Equal101~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|Equal434~4_combout\,
	datac => \inst|SPHI1~205_combout\,
	datad => \inst|Equal41~2_combout\,
	combout => \inst|SPHI1~125_combout\);

-- Location: LCCOMB_X28_Y27_N16
\inst|SPHI1~123\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~123_combout\ = (\inst|Equal175~0_combout\ & (\inst|counter\(0) & (\inst|Equal2~1_combout\ & \inst|Equal101~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal175~0_combout\,
	datab => \inst|counter\(0),
	datac => \inst|Equal2~1_combout\,
	datad => \inst|Equal101~0_combout\,
	combout => \inst|SPHI1~123_combout\);

-- Location: LCCOMB_X29_Y28_N16
\inst|SPHI1~124\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~124_combout\ = (!\inst|SPHI1~123_combout\ & (((\inst|counter\(8)) # (!\inst|Equal37~2_combout\)) # (!\inst|Equal103~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal103~3_combout\,
	datab => \inst|counter\(8),
	datac => \inst|Equal37~2_combout\,
	datad => \inst|SPHI1~123_combout\,
	combout => \inst|SPHI1~124_combout\);

-- Location: LCCOMB_X29_Y28_N0
\inst|SPHI1~126\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~126_combout\ = (\inst|SPHI1~125_combout\ & (\inst|SPHI1~124_combout\ & ((!\inst|Equal53~0_combout\) # (!\inst|Equal103~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal103~3_combout\,
	datab => \inst|Equal53~0_combout\,
	datac => \inst|SPHI1~125_combout\,
	datad => \inst|SPHI1~124_combout\,
	combout => \inst|SPHI1~126_combout\);

-- Location: LCCOMB_X29_Y28_N28
\inst|Equal107~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal107~4_combout\ = (\inst|Equal101~0_combout\ & (\inst|Equal434~4_combout\ & (!\inst|counter\(5) & \inst|Equal41~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|Equal434~4_combout\,
	datac => \inst|counter\(5),
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal107~4_combout\);

-- Location: LCCOMB_X29_Y28_N10
\inst|SPHI1~206\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~206_combout\ = (\inst|counter\(6)) # (((!\inst|counter\(3) & !\inst|counter\(4))) # (!\inst|Equal107~4_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(3),
	datac => \inst|counter\(4),
	datad => \inst|Equal107~4_combout\,
	combout => \inst|SPHI1~206_combout\);

-- Location: LCCOMB_X27_Y29_N2
\inst|Equal111~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal111~0_combout\ = (!\inst|counter\(5) & !\inst|counter\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datad => \inst|counter\(6),
	combout => \inst|Equal111~0_combout\);

-- Location: LCCOMB_X27_Y29_N26
\inst|SPHI1~202\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~202_combout\ = (\inst|counter\(7) & (\inst|counter\(0) & (!\inst|counter\(8) & \inst|Equal111~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(0),
	datac => \inst|counter\(8),
	datad => \inst|Equal111~0_combout\,
	combout => \inst|SPHI1~202_combout\);

-- Location: LCCOMB_X27_Y29_N18
\inst|Equal7~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal7~5_combout\ = (!\inst|counter\(6) & (!\inst|counter\(8) & !\inst|counter\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datac => \inst|counter\(8),
	datad => \inst|counter\(4),
	combout => \inst|Equal7~5_combout\);

-- Location: LCCOMB_X26_Y27_N0
\inst|Equal135~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal135~1_combout\ = (\inst|Equal6~1_combout\ & (\inst|SPHI2~20_combout\ & (\inst|Equal7~5_combout\ & \inst|Equal135~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal6~1_combout\,
	datab => \inst|SPHI2~20_combout\,
	datac => \inst|Equal7~5_combout\,
	datad => \inst|Equal135~0_combout\,
	combout => \inst|Equal135~1_combout\);

-- Location: LCCOMB_X28_Y28_N28
\inst|SPHI1~164\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~164_combout\ = (!\inst|Equal135~1_combout\ & ((!\inst|Equal2~1_combout\) # (!\inst|SPHI1~202_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|SPHI1~202_combout\,
	datac => \inst|Equal135~1_combout\,
	datad => \inst|Equal2~1_combout\,
	combout => \inst|SPHI1~164_combout\);

-- Location: LCCOMB_X28_Y28_N22
\inst|SPHI1~165\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~165_combout\ = (\inst|SPHI1~206_combout\ & (\inst|SPHI1~164_combout\ & ((!\inst|Equal4~1_combout\) # (!\inst|Equal103~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal103~3_combout\,
	datab => \inst|Equal4~1_combout\,
	datac => \inst|SPHI1~206_combout\,
	datad => \inst|SPHI1~164_combout\,
	combout => \inst|SPHI1~165_combout\);

-- Location: LCCOMB_X26_Y27_N12
\inst|SPHI1~133\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~133_combout\ = (\inst|counter\(4) & (!\inst|counter\(5))) # (!\inst|counter\(4) & (\inst|counter\(2) & (\inst|counter\(5) $ (\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(2),
	datac => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|SPHI1~133_combout\);

-- Location: LCCOMB_X26_Y27_N22
\inst|SPHI1~134\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~134_combout\ = (\inst|Equal101~0_combout\ & (!\inst|counter\(6) & (\inst|SPHI1~133_combout\ & \inst|Equal4~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|counter\(6),
	datac => \inst|SPHI1~133_combout\,
	datad => \inst|Equal4~4_combout\,
	combout => \inst|SPHI1~134_combout\);

-- Location: LCCOMB_X26_Y27_N10
\inst|SPHI1~135\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~135_combout\ = (\inst|SPHI1~134_combout\) # ((!\inst|Equal135~1_combout\ & \inst|Equal134~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Equal135~1_combout\,
	datac => \inst|SPHI1~134_combout\,
	datad => \inst|Equal134~0_combout\,
	combout => \inst|SPHI1~135_combout\);

-- Location: LCCOMB_X27_Y27_N4
\inst|Equal139~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal139~0_combout\ = (\inst|counter\(5) & (!\inst|counter\(3) & (\inst|Equal101~0_combout\ & \inst|Equal11~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(3),
	datac => \inst|Equal101~0_combout\,
	datad => \inst|Equal11~5_combout\,
	combout => \inst|Equal139~0_combout\);

-- Location: LCCOMB_X27_Y27_N26
\inst|SPHI1~129\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~129_combout\ = (((!\inst|Equal3~4_combout\ & !\inst|Equal29~0_combout\)) # (!\inst|Equal107~5_combout\)) # (!\inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal3~4_combout\,
	datac => \inst|Equal29~0_combout\,
	datad => \inst|Equal107~5_combout\,
	combout => \inst|SPHI1~129_combout\);

-- Location: LCCOMB_X27_Y27_N24
\inst|SPHI1~130\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~130_combout\ = (\inst|counter\(0) & (\inst|Equal143~0_combout\ & (\inst|Equal101~0_combout\ & \inst|Equal2~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datab => \inst|Equal143~0_combout\,
	datac => \inst|Equal101~0_combout\,
	datad => \inst|Equal2~1_combout\,
	combout => \inst|SPHI1~130_combout\);

-- Location: LCCOMB_X27_Y27_N2
\inst|SPHI1~131\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~131_combout\ = (\inst|SPHI1~129_combout\ & (!\inst|SPHI1~130_combout\ & ((\inst|counter\(6)) # (!\inst|Equal151~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal151~0_combout\,
	datab => \inst|counter\(6),
	datac => \inst|SPHI1~129_combout\,
	datad => \inst|SPHI1~130_combout\,
	combout => \inst|SPHI1~131_combout\);

-- Location: LCCOMB_X27_Y27_N22
\inst|SPHI1~132\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~132_combout\ = (\inst|SPHI1~131_combout\ & (((!\inst|Equal2~0_combout\ & !\inst|Equal123~0_combout\)) # (!\inst|Equal139~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal2~0_combout\,
	datab => \inst|Equal123~0_combout\,
	datac => \inst|Equal139~0_combout\,
	datad => \inst|SPHI1~131_combout\,
	combout => \inst|SPHI1~132_combout\);

-- Location: LCCOMB_X29_Y28_N6
\inst|SPHI1~139\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~139_combout\ = (\inst|counter\(3)) # (((!\inst|Equal11~3_combout\ & !\inst|Equal7~2_combout\)) # (!\inst|Equal53~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|Equal11~3_combout\,
	datac => \inst|Equal53~0_combout\,
	datad => \inst|Equal7~2_combout\,
	combout => \inst|SPHI1~139_combout\);

-- Location: LCCOMB_X29_Y28_N2
\inst|Equal103~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal103~4_combout\ = (!\inst|counter\(6) & (!\inst|counter\(4) & (!\inst|counter\(8) & \inst|Equal103~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(4),
	datac => \inst|counter\(8),
	datad => \inst|Equal103~3_combout\,
	combout => \inst|Equal103~4_combout\);

-- Location: LCCOMB_X25_Y28_N14
\inst|Equal83~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal83~0_combout\ = (!\inst|counter\(8) & (!\inst|counter\(4) & (\inst|counter\(6) & \inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(4),
	datac => \inst|counter\(6),
	datad => \inst|counter\(3),
	combout => \inst|Equal83~0_combout\);

-- Location: LCCOMB_X29_Y28_N26
\inst|SPHI1~140\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~140_combout\ = (\inst|Equal9~1_combout\ & (!\inst|Equal107~4_combout\ & ((!\inst|Equal11~3_combout\) # (!\inst|Equal83~0_combout\)))) # (!\inst|Equal9~1_combout\ & (((!\inst|Equal11~3_combout\)) # (!\inst|Equal83~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal9~1_combout\,
	datab => \inst|Equal83~0_combout\,
	datac => \inst|Equal11~3_combout\,
	datad => \inst|Equal107~4_combout\,
	combout => \inst|SPHI1~140_combout\);

-- Location: LCCOMB_X29_Y28_N18
\inst|Equal99~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal99~0_combout\ = (\inst|counter\(6) & (\inst|counter\(3) & (\inst|Equal11~3_combout\ & \inst|Equal4~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(3),
	datac => \inst|Equal11~3_combout\,
	datad => \inst|Equal4~5_combout\,
	combout => \inst|Equal99~0_combout\);

-- Location: LCCOMB_X29_Y28_N12
\inst|SPHI1~138\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~138_combout\ = (!\inst|Equal99~0_combout\ & (((!\inst|Equal15~0_combout\) # (!\inst|Equal4~5_combout\)) # (!\inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|Equal4~5_combout\,
	datac => \inst|Equal15~0_combout\,
	datad => \inst|Equal99~0_combout\,
	combout => \inst|SPHI1~138_combout\);

-- Location: LCCOMB_X29_Y28_N4
\inst|SPHI1~141\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~141_combout\ = (\inst|SPHI1~139_combout\ & (!\inst|Equal103~4_combout\ & (\inst|SPHI1~140_combout\ & \inst|SPHI1~138_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~139_combout\,
	datab => \inst|Equal103~4_combout\,
	datac => \inst|SPHI1~140_combout\,
	datad => \inst|SPHI1~138_combout\,
	combout => \inst|SPHI1~141_combout\);

-- Location: LCCOMB_X25_Y29_N10
\inst|SPHI2~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~24_combout\ = (\inst|counter\(5) & (((!\inst|counter\(4))))) # (!\inst|counter\(5) & (\inst|counter\(4) & ((\inst|counter\(2)) # (\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(5),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|SPHI2~24_combout\);

-- Location: LCCOMB_X25_Y29_N20
\inst|SPHI1~142\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~142_combout\ = (!\inst|counter\(7) & (\inst|counter\(6) & \inst|SPHI2~24_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(7),
	datac => \inst|counter\(6),
	datad => \inst|SPHI2~24_combout\,
	combout => \inst|SPHI1~142_combout\);

-- Location: LCCOMB_X24_Y28_N2
\inst|SPHI1~143\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~143_combout\ = (!\inst|counter\(8) & (\inst|SPHI1~142_combout\ & (\inst|Equal135~0_combout\ & !\inst|counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|SPHI1~142_combout\,
	datac => \inst|Equal135~0_combout\,
	datad => \inst|counter\(0),
	combout => \inst|SPHI1~143_combout\);

-- Location: LCCOMB_X27_Y29_N20
\inst|SPHI2~23\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~23_combout\ = (\inst|counter\(5) & (!\inst|counter\(7) & (\inst|counter\(6) & \inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(7),
	datac => \inst|counter\(6),
	datad => \inst|counter\(4),
	combout => \inst|SPHI2~23_combout\);

-- Location: LCCOMB_X27_Y29_N28
\inst|SPHI1~136\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~136_combout\ = (\inst|SPHI2~23_combout\) # ((\inst|SPHI1~90_combout\ & (\inst|counter\(7) & \inst|Equal111~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~90_combout\,
	datab => \inst|counter\(7),
	datac => \inst|SPHI2~23_combout\,
	datad => \inst|Equal111~0_combout\,
	combout => \inst|SPHI1~136_combout\);

-- Location: LCCOMB_X24_Y28_N4
\inst|SPHI1~137\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~137_combout\ = (\inst|SPHI1~136_combout\ & (!\inst|counter\(0) & (\inst|Equal135~0_combout\ & !\inst|counter\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~136_combout\,
	datab => \inst|counter\(0),
	datac => \inst|Equal135~0_combout\,
	datad => \inst|counter\(8),
	combout => \inst|SPHI1~137_combout\);

-- Location: LCCOMB_X27_Y30_N0
\inst|SPHI1~149\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~149_combout\ = (\inst|counter\(5) & (!\inst|counter\(6) & (\inst|counter\(4) & \inst|counter\(3)))) # (!\inst|counter\(5) & (\inst|counter\(6) & (!\inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010010000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~149_combout\);

-- Location: LCCOMB_X27_Y30_N30
\inst|SPHI1~148\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~148_combout\ = (!\inst|counter\(2) & (\inst|counter\(4) & (\inst|Equal175~0_combout\ & !\inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(4),
	datac => \inst|Equal175~0_combout\,
	datad => \inst|counter\(3),
	combout => \inst|SPHI1~148_combout\);

-- Location: LCCOMB_X27_Y30_N18
\inst|SPHI1~150\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~150_combout\ = (\inst|Equal3~3_combout\ & (\inst|Equal4~4_combout\ & ((\inst|SPHI1~149_combout\) # (\inst|SPHI1~148_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~3_combout\,
	datab => \inst|SPHI1~149_combout\,
	datac => \inst|SPHI1~148_combout\,
	datad => \inst|Equal4~4_combout\,
	combout => \inst|SPHI1~150_combout\);

-- Location: LCCOMB_X25_Y29_N30
\inst|Equal29~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal29~1_combout\ = (\inst|counter\(3) & (!\inst|counter\(6) & (\inst|counter\(4) & !\inst|counter\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(8),
	combout => \inst|Equal29~1_combout\);

-- Location: LCCOMB_X25_Y28_N8
\inst|SPHI1~158\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~158_combout\ = ((!\inst|Equal29~1_combout\ & ((\inst|counter\(3)) # (!\inst|Equal4~1_combout\)))) # (!\inst|Equal11~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~1_combout\,
	datab => \inst|counter\(3),
	datac => \inst|Equal29~1_combout\,
	datad => \inst|Equal11~3_combout\,
	combout => \inst|SPHI1~158_combout\);

-- Location: LCCOMB_X25_Y28_N26
\inst|SPHI1~201\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~201_combout\ = (!\inst|counter\(8) & (!\inst|counter\(5) & (\inst|counter\(6) & !\inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(5),
	datac => \inst|counter\(6),
	datad => \inst|counter\(4),
	combout => \inst|SPHI1~201_combout\);

-- Location: LCCOMB_X25_Y29_N0
\inst|Equal43~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal43~0_combout\ = (!\inst|counter\(5) & (\inst|counter\(6) & (!\inst|counter\(4) & !\inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(3),
	combout => \inst|Equal43~0_combout\);

-- Location: LCCOMB_X25_Y28_N18
\inst|Equal45~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal45~1_combout\ = (!\inst|counter\(4) & (\inst|counter\(3) & (\inst|counter\(6) & \inst|Equal3~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(3),
	datac => \inst|counter\(6),
	datad => \inst|Equal3~2_combout\,
	combout => \inst|Equal45~1_combout\);

-- Location: LCCOMB_X25_Y28_N12
\inst|SPHI1~159\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~159_combout\ = (\inst|Equal434~4_combout\ & ((\inst|Equal45~1_combout\) # ((\inst|Equal43~0_combout\ & \inst|Equal3~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal43~0_combout\,
	datab => \inst|Equal3~3_combout\,
	datac => \inst|Equal434~4_combout\,
	datad => \inst|Equal45~1_combout\,
	combout => \inst|SPHI1~159_combout\);

-- Location: LCCOMB_X25_Y28_N2
\inst|SPHI1~160\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~160_combout\ = (\inst|SPHI1~201_combout\ & (!\inst|Equal7~4_combout\ & ((!\inst|SPHI1~159_combout\) # (!\inst|Equal41~2_combout\)))) # (!\inst|SPHI1~201_combout\ & (((!\inst|SPHI1~159_combout\)) # (!\inst|Equal41~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~201_combout\,
	datab => \inst|Equal41~2_combout\,
	datac => \inst|Equal7~4_combout\,
	datad => \inst|SPHI1~159_combout\,
	combout => \inst|SPHI1~160_combout\);

-- Location: LCCOMB_X25_Y28_N24
\inst|SPHI1~161\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~161_combout\ = (\inst|SPHI1~158_combout\ & (\inst|SPHI1~160_combout\ & ((!\inst|Equal7~2_combout\) # (!\inst|Equal29~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal29~1_combout\,
	datab => \inst|Equal7~2_combout\,
	datac => \inst|SPHI1~158_combout\,
	datad => \inst|SPHI1~160_combout\,
	combout => \inst|SPHI1~161_combout\);

-- Location: LCCOMB_X28_Y28_N30
\inst|SPHI1~155\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~155_combout\ = (!\inst|Equal7~5_combout\ & ((\inst|counter\(3)) # (!\inst|Equal4~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(3),
	datac => \inst|Equal4~1_combout\,
	datad => \inst|Equal7~5_combout\,
	combout => \inst|SPHI1~155_combout\);

-- Location: LCCOMB_X28_Y28_N24
\inst|SPHI1~156\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~156_combout\ = (\inst|SPHI1~155_combout\) # ((!\inst|Equal7~2_combout\ & ((!\inst|counter\(3)) # (!\inst|Equal11~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal11~3_combout\,
	datab => \inst|counter\(3),
	datac => \inst|SPHI1~155_combout\,
	datad => \inst|Equal7~2_combout\,
	combout => \inst|SPHI1~156_combout\);

-- Location: LCCOMB_X28_Y28_N18
\inst|Equal11~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal11~4_combout\ = (!\inst|counter\(8) & (!\inst|counter\(3) & (\inst|Equal2~0_combout\ & \inst|Equal11~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(3),
	datac => \inst|Equal2~0_combout\,
	datad => \inst|Equal11~3_combout\,
	combout => \inst|Equal11~4_combout\);

-- Location: LCCOMB_X25_Y28_N0
\inst|Equal3~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal3~5_combout\ = (\inst|Equal3~2_combout\ & (\inst|Equal3~4_combout\ & (\inst|counter\(2) & \inst|Equal3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~2_combout\,
	datab => \inst|Equal3~4_combout\,
	datac => \inst|counter\(2),
	datad => \inst|Equal3~1_combout\,
	combout => \inst|Equal3~5_combout\);

-- Location: LCCOMB_X25_Y28_N10
\inst|SPHI1~154\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~154_combout\ = (\inst|Equal6~2_combout\) # ((!\inst|Equal3~5_combout\ & ((\inst|SPHI1~q\) # (!\inst|Equal1~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~q\,
	datab => \inst|Equal3~5_combout\,
	datac => \inst|Equal6~2_combout\,
	datad => \inst|Equal1~1_combout\,
	combout => \inst|SPHI1~154_combout\);

-- Location: LCCOMB_X27_Y30_N2
\inst|SPHI1~152\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~152_combout\ = (\inst|Equal3~3_combout\ & (!\inst|SPHI1~151_combout\ & (\inst|Equal143~0_combout\ & \inst|Equal4~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~3_combout\,
	datab => \inst|SPHI1~151_combout\,
	datac => \inst|Equal143~0_combout\,
	datad => \inst|Equal4~4_combout\,
	combout => \inst|SPHI1~152_combout\);

-- Location: LCCOMB_X24_Y28_N12
\inst|SPHI1~153\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~153_combout\ = (\inst|SPHI1~152_combout\) # ((\inst|counter\(2) & (\inst|Equal4~2_combout\ & \inst|Equal6~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|Equal4~2_combout\,
	datac => \inst|Equal6~0_combout\,
	datad => \inst|SPHI1~152_combout\,
	combout => \inst|SPHI1~153_combout\);

-- Location: LCCOMB_X24_Y28_N14
\inst|SPHI1~157\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~157_combout\ = (\inst|SPHI1~153_combout\) # ((\inst|SPHI1~156_combout\ & (!\inst|Equal11~4_combout\ & \inst|SPHI1~154_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~156_combout\,
	datab => \inst|Equal11~4_combout\,
	datac => \inst|SPHI1~154_combout\,
	datad => \inst|SPHI1~153_combout\,
	combout => \inst|SPHI1~157_combout\);

-- Location: LCCOMB_X28_Y25_N14
\inst|Equal61~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal61~0_combout\ = (!\inst|counter\(5) & (\inst|counter\(6) & (\inst|counter\(3) & \inst|Equal4~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(6),
	datac => \inst|counter\(3),
	datad => \inst|Equal4~5_combout\,
	combout => \inst|Equal61~0_combout\);

-- Location: LCCOMB_X28_Y28_N8
\inst|Equal67~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal67~0_combout\ = (\inst|Equal434~4_combout\ & (!\inst|counter\(7) & (\inst|Equal61~0_combout\ & \inst|Equal41~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal434~4_combout\,
	datab => \inst|counter\(7),
	datac => \inst|Equal61~0_combout\,
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal67~0_combout\);

-- Location: LCCOMB_X27_Y29_N24
\inst|SPHI1~200\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~200_combout\ = (\inst|counter\(6) & (!\inst|counter\(4) & ((!\inst|counter\(8)) # (!\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(3),
	datac => \inst|counter\(8),
	datad => \inst|counter\(4),
	combout => \inst|SPHI1~200_combout\);

-- Location: LCCOMB_X28_Y28_N0
\inst|SPHI1~145\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~145_combout\ = (\inst|counter\(8) & (\inst|counter\(3))) # (!\inst|counter\(8) & (!\inst|counter\(3) & (\inst|Equal37~2_combout\ & \inst|Equal11~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(3),
	datac => \inst|Equal37~2_combout\,
	datad => \inst|Equal11~3_combout\,
	combout => \inst|SPHI1~145_combout\);

-- Location: LCCOMB_X28_Y28_N26
\inst|SPHI1~146\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~146_combout\ = (\inst|counter\(8) & (\inst|Equal7~2_combout\ & (\inst|SPHI1~200_combout\ & \inst|SPHI1~145_combout\))) # (!\inst|counter\(8) & ((\inst|SPHI1~145_combout\) # ((\inst|Equal7~2_combout\ & \inst|SPHI1~200_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|Equal7~2_combout\,
	datac => \inst|SPHI1~200_combout\,
	datad => \inst|SPHI1~145_combout\,
	combout => \inst|SPHI1~146_combout\);

-- Location: LCCOMB_X28_Y28_N2
\inst|SPHI1~144\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~144_combout\ = (((!\inst|Equal7~4_combout\ & !\inst|SPHI1~98_combout\)) # (!\inst|Equal175~0_combout\)) # (!\inst|Equal4~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~5_combout\,
	datab => \inst|Equal175~0_combout\,
	datac => \inst|Equal7~4_combout\,
	datad => \inst|SPHI1~98_combout\,
	combout => \inst|SPHI1~144_combout\);

-- Location: LCCOMB_X28_Y28_N16
\inst|SPHI1~147\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~147_combout\ = (!\inst|Equal67~0_combout\ & (!\inst|SPHI1~146_combout\ & \inst|SPHI1~144_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Equal67~0_combout\,
	datac => \inst|SPHI1~146_combout\,
	datad => \inst|SPHI1~144_combout\,
	combout => \inst|SPHI1~147_combout\);

-- Location: LCCOMB_X24_Y28_N20
\inst|SPHI1~162\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~162_combout\ = (\inst|SPHI1~147_combout\ & ((\inst|SPHI1~150_combout\) # ((\inst|SPHI1~161_combout\ & \inst|SPHI1~157_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~150_combout\,
	datab => \inst|SPHI1~161_combout\,
	datac => \inst|SPHI1~157_combout\,
	datad => \inst|SPHI1~147_combout\,
	combout => \inst|SPHI1~162_combout\);

-- Location: LCCOMB_X24_Y28_N6
\inst|SPHI1~163\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~163_combout\ = (\inst|SPHI1~137_combout\) # ((\inst|SPHI1~141_combout\ & ((\inst|SPHI1~143_combout\) # (\inst|SPHI1~162_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~141_combout\,
	datab => \inst|SPHI1~143_combout\,
	datac => \inst|SPHI1~137_combout\,
	datad => \inst|SPHI1~162_combout\,
	combout => \inst|SPHI1~163_combout\);

-- Location: LCCOMB_X24_Y28_N24
\inst|SPHI1~166\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~166_combout\ = (\inst|SPHI1~132_combout\ & ((\inst|SPHI1~135_combout\) # ((\inst|SPHI1~165_combout\ & \inst|SPHI1~163_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~165_combout\,
	datab => \inst|SPHI1~135_combout\,
	datac => \inst|SPHI1~132_combout\,
	datad => \inst|SPHI1~163_combout\,
	combout => \inst|SPHI1~166_combout\);

-- Location: LCCOMB_X24_Y28_N10
\inst|SPHI1~167\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~167_combout\ = (\inst|SPHI1~122_combout\) # ((\inst|SPHI1~126_combout\ & ((\inst|SPHI1~128_combout\) # (\inst|SPHI1~166_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~122_combout\,
	datab => \inst|SPHI1~128_combout\,
	datac => \inst|SPHI1~126_combout\,
	datad => \inst|SPHI1~166_combout\,
	combout => \inst|SPHI1~167_combout\);

-- Location: LCCOMB_X24_Y28_N0
\inst|SPHI1~173\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~173_combout\ = (\inst|SPHI1~118_combout\ & ((\inst|SPHI1~120_combout\) # ((\inst|SPHI1~172_combout\ & \inst|SPHI1~167_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~120_combout\,
	datab => \inst|SPHI1~118_combout\,
	datac => \inst|SPHI1~172_combout\,
	datad => \inst|SPHI1~167_combout\,
	combout => \inst|SPHI1~173_combout\);

-- Location: LCCOMB_X24_Y28_N26
\inst|SPHI1~174\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~174_combout\ = (\inst|SPHI1~109_combout\) # ((\inst|SPHI1~197_combout\ & ((\inst|SPHI1~113_combout\) # (\inst|SPHI1~173_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~109_combout\,
	datab => \inst|SPHI1~113_combout\,
	datac => \inst|SPHI1~197_combout\,
	datad => \inst|SPHI1~173_combout\,
	combout => \inst|SPHI1~174_combout\);

-- Location: LCCOMB_X23_Y28_N18
\inst|SPHI1~180\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~180_combout\ = (\inst|SPHI1~103_combout\ & ((\inst|SPHI1~105_combout\) # ((\inst|SPHI1~179_combout\ & \inst|SPHI1~174_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~105_combout\,
	datab => \inst|SPHI1~103_combout\,
	datac => \inst|SPHI1~179_combout\,
	datad => \inst|SPHI1~174_combout\,
	combout => \inst|SPHI1~180_combout\);

-- Location: LCCOMB_X23_Y28_N20
\inst|SPHI1~183\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~183_combout\ = (\inst|SPHI1~93_combout\) # ((\inst|SPHI1~97_combout\ & ((\inst|SPHI1~182_combout\) # (\inst|SPHI1~180_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~97_combout\,
	datab => \inst|SPHI1~182_combout\,
	datac => \inst|SPHI1~93_combout\,
	datad => \inst|SPHI1~180_combout\,
	combout => \inst|SPHI1~183_combout\);

-- Location: LCCOMB_X23_Y28_N6
\inst|SPHI1~186\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~186_combout\ = (\inst|SPHI1~87_combout\ & ((\inst|SPHI1~89_combout\) # ((\inst|SPHI1~185_combout\ & \inst|SPHI1~183_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~89_combout\,
	datab => \inst|SPHI1~185_combout\,
	datac => \inst|SPHI1~87_combout\,
	datad => \inst|SPHI1~183_combout\,
	combout => \inst|SPHI1~186_combout\);

-- Location: LCCOMB_X23_Y28_N16
\inst|SPHI1~193\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI1~193_combout\ = (\inst|SPHI1~83_combout\) # ((\inst|SPHI1~85_combout\ & ((\inst|SPHI1~192_combout\) # (\inst|SPHI1~186_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~85_combout\,
	datab => \inst|SPHI1~192_combout\,
	datac => \inst|SPHI1~83_combout\,
	datad => \inst|SPHI1~186_combout\,
	combout => \inst|SPHI1~193_combout\);

-- Location: FF_X23_Y28_N17
\inst|SPHI1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|SPHI1~193_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|SPHI1~q\);

-- Location: LCCOMB_X24_Y26_N26
\inst|SPHI2~85\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~85_combout\ = (\inst|counter\(5)) # (((\inst|counter\(3) & \inst|counter\(4))) # (!\inst|counter\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101110111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(6),
	datac => \inst|counter\(3),
	datad => \inst|counter\(4),
	combout => \inst|SPHI2~85_combout\);

-- Location: LCCOMB_X24_Y26_N28
\inst|SPHI2~86\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~86_combout\ = (\inst|SPHI2~85_combout\ & ((!\inst|Equal395~0_combout\) # (!\inst|counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datac => \inst|SPHI2~85_combout\,
	datad => \inst|Equal395~0_combout\,
	combout => \inst|SPHI2~86_combout\);

-- Location: LCCOMB_X24_Y26_N12
\inst|SPHI2~126\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~126_combout\ = (\inst|counter\(8) & (\inst|Equal135~0_combout\ & (\inst|SPHI2~20_combout\ & !\inst|SPHI2~86_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|Equal135~0_combout\,
	datac => \inst|SPHI2~20_combout\,
	datad => \inst|SPHI2~86_combout\,
	combout => \inst|SPHI2~126_combout\);

-- Location: LCCOMB_X28_Y29_N6
\inst|Equal405~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal405~0_combout\ = (!\inst|counter\(0) & (!\inst|counter\(1) & (\inst|Equal363~2_combout\ & \inst|SPHI1~81_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datab => \inst|counter\(1),
	datac => \inst|Equal363~2_combout\,
	datad => \inst|SPHI1~81_combout\,
	combout => \inst|Equal405~0_combout\);

-- Location: LCCOMB_X29_Y27_N6
\inst|SPHI2~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~26_combout\ = (!\inst|stage\(0) & ((!\inst|Equal405~0_combout\) # (!\inst|Equal227~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Equal227~0_combout\,
	datac => \inst|stage\(0),
	datad => \inst|Equal405~0_combout\,
	combout => \inst|SPHI2~26_combout\);

-- Location: LCCOMB_X29_Y29_N8
\inst|SPHI2~25\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~25_combout\ = (\inst|Equal2~1_combout\ & ((\inst|SPHI1~194_combout\) # ((\inst|RBI~0_combout\ & \inst|SPHI2~q\)))) # (!\inst|Equal2~1_combout\ & (((\inst|RBI~0_combout\ & \inst|SPHI2~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal2~1_combout\,
	datab => \inst|SPHI1~194_combout\,
	datac => \inst|RBI~0_combout\,
	datad => \inst|SPHI2~q\,
	combout => \inst|SPHI2~25_combout\);

-- Location: LCCOMB_X23_Y26_N30
\inst|SPHI2~29\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~29_combout\ = (\inst|counter\(7) & (!\inst|counter\(6) & \inst|counter\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datac => \inst|counter\(6),
	datad => \inst|counter\(8),
	combout => \inst|SPHI2~29_combout\);

-- Location: LCCOMB_X23_Y26_N8
\inst|SPHI2~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~28_combout\ = (\inst|counter\(4) & (((!\inst|counter\(5))))) # (!\inst|counter\(4) & ((\inst|counter\(2) & (!\inst|counter\(5) & \inst|counter\(3))) # (!\inst|counter\(2) & (\inst|counter\(5) & !\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(2),
	datac => \inst|counter\(5),
	datad => \inst|counter\(3),
	combout => \inst|SPHI2~28_combout\);

-- Location: LCCOMB_X23_Y26_N0
\inst|SPHI2~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~30_combout\ = (\inst|Equal392~1_combout\) # ((\inst|SPHI2~29_combout\ & (\inst|SPHI2~28_combout\ & \inst|Equal3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~29_combout\,
	datab => \inst|SPHI2~28_combout\,
	datac => \inst|Equal3~1_combout\,
	datad => \inst|Equal392~1_combout\,
	combout => \inst|SPHI2~30_combout\);

-- Location: LCCOMB_X28_Y29_N20
\inst|SPHI2~27\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~27_combout\ = (\inst|Equal405~0_combout\ & (!\inst|Equal409~0_combout\ & ((!\inst|Equal397~2_combout\) # (!\inst|Equal413~0_combout\)))) # (!\inst|Equal405~0_combout\ & (((!\inst|Equal397~2_combout\)) # (!\inst|Equal413~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal405~0_combout\,
	datab => \inst|Equal413~0_combout\,
	datac => \inst|Equal409~0_combout\,
	datad => \inst|Equal397~2_combout\,
	combout => \inst|SPHI2~27_combout\);

-- Location: LCCOMB_X29_Y29_N10
\inst|Equal405~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal405~1_combout\ = (!\inst|counter\(2) & (\inst|Equal363~2_combout\ & (\inst|Equal3~1_combout\ & \inst|Equal45~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|Equal363~2_combout\,
	datac => \inst|Equal3~1_combout\,
	datad => \inst|Equal45~0_combout\,
	combout => \inst|Equal405~1_combout\);

-- Location: LCCOMB_X28_Y29_N16
\inst|SPHI2~135\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~135_combout\ = (!\inst|Equal393~0_combout\ & (((\inst|counter\(4) & !\inst|counter\(2))) # (!\inst|Equal397~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(2),
	datac => \inst|Equal393~0_combout\,
	datad => \inst|Equal397~2_combout\,
	combout => \inst|SPHI2~135_combout\);

-- Location: LCCOMB_X28_Y29_N22
\inst|SPHI2~136\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~136_combout\ = (!\inst|Equal393~0_combout\ & (\inst|SPHI2~27_combout\ & (!\inst|Equal405~1_combout\ & \inst|SPHI2~135_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal393~0_combout\,
	datab => \inst|SPHI2~27_combout\,
	datac => \inst|Equal405~1_combout\,
	datad => \inst|SPHI2~135_combout\,
	combout => \inst|SPHI2~136_combout\);

-- Location: LCCOMB_X27_Y28_N18
\inst|Equal13~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal13~0_combout\ = (!\inst|counter\(1) & (!\inst|counter\(2) & (\inst|counter\(0) & \inst|SPHI1~81_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|counter\(2),
	datac => \inst|counter\(0),
	datad => \inst|SPHI1~81_combout\,
	combout => \inst|Equal13~0_combout\);

-- Location: LCCOMB_X28_Y25_N24
\inst|Equal149~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal149~3_combout\ = (!\inst|counter\(3) & (\inst|counter\(7) & (\inst|counter\(5) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(7),
	datac => \inst|counter\(5),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal149~3_combout\);

-- Location: LCCOMB_X28_Y25_N30
\inst|Equal369~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal369~4_combout\ = (\inst|Equal231~0_combout\ & (\inst|counter\(7) & (\inst|Equal17~0_combout\ & \inst|counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal231~0_combout\,
	datab => \inst|counter\(7),
	datac => \inst|Equal17~0_combout\,
	datad => \inst|counter\(0),
	combout => \inst|Equal369~4_combout\);

-- Location: LCCOMB_X27_Y25_N14
\inst|Equal149~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal149~2_combout\ = (\inst|counter\(7) & \inst|Equal13~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal149~2_combout\);

-- Location: LCCOMB_X28_Y25_N18
\inst|SPHI2~121\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~121_combout\ = (((!\inst|Equal29~0_combout\ & !\inst|Equal3~4_combout\)) # (!\inst|Equal149~2_combout\)) # (!\inst|Equal231~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal231~0_combout\,
	datab => \inst|Equal29~0_combout\,
	datac => \inst|Equal3~4_combout\,
	datad => \inst|Equal149~2_combout\,
	combout => \inst|SPHI2~121_combout\);

-- Location: LCCOMB_X28_Y25_N12
\inst|SPHI2~122\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~122_combout\ = (\inst|SPHI2~121_combout\ & (((!\inst|Equal123~0_combout\ & !\inst|Equal2~0_combout\)) # (!\inst|Equal369~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal123~0_combout\,
	datab => \inst|Equal2~0_combout\,
	datac => \inst|Equal369~4_combout\,
	datad => \inst|SPHI2~121_combout\,
	combout => \inst|SPHI2~122_combout\);

-- Location: LCCOMB_X26_Y25_N14
\inst|Equal249~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal249~1_combout\ = (!\inst|counter\(3) & (\inst|Equal9~0_combout\ & (\inst|Equal123~0_combout\ & !\inst|counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|Equal9~0_combout\,
	datac => \inst|Equal123~0_combout\,
	datad => \inst|counter\(5),
	combout => \inst|Equal249~1_combout\);

-- Location: LCCOMB_X26_Y26_N30
\inst|Equal117~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal117~0_combout\ = (\inst|counter\(7) & \inst|Equal37~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datad => \inst|Equal37~3_combout\,
	combout => \inst|Equal117~0_combout\);

-- Location: LCCOMB_X26_Y25_N24
\inst|SPHI2~123\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~123_combout\ = (\inst|Equal245~1_combout\ & (!\inst|Equal117~0_combout\ & ((!\inst|Equal377~0_combout\) # (!\inst|Equal249~1_combout\)))) # (!\inst|Equal245~1_combout\ & (((!\inst|Equal377~0_combout\)) # (!\inst|Equal249~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal245~1_combout\,
	datab => \inst|Equal249~1_combout\,
	datac => \inst|Equal117~0_combout\,
	datad => \inst|Equal377~0_combout\,
	combout => \inst|SPHI2~123_combout\);

-- Location: LCCOMB_X27_Y25_N22
\inst|SPHI2~124\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~124_combout\ = (\inst|SPHI2~122_combout\ & (\inst|SPHI2~123_combout\ & ((!\inst|Equal149~3_combout\) # (!\inst|Equal229~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal229~0_combout\,
	datab => \inst|Equal149~3_combout\,
	datac => \inst|SPHI2~122_combout\,
	datad => \inst|SPHI2~123_combout\,
	combout => \inst|SPHI2~124_combout\);

-- Location: LCCOMB_X27_Y28_N24
\inst|Equal17~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal17~1_combout\ = (\inst|counter\(3) & (!\inst|counter\(1) & (\inst|Equal7~0_combout\ & \inst|Equal41~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(1),
	datac => \inst|Equal7~0_combout\,
	datad => \inst|Equal41~2_combout\,
	combout => \inst|Equal17~1_combout\);

-- Location: LCCOMB_X29_Y26_N6
\inst|SPHI2~31\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~31_combout\ = (\inst|Equal309~0_combout\ & (((\inst|Equal9~0_combout\) # (\inst|Equal17~1_combout\)))) # (!\inst|Equal309~0_combout\ & (\inst|Equal325~0_combout\ & ((\inst|Equal17~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal309~0_combout\,
	datab => \inst|Equal325~0_combout\,
	datac => \inst|Equal9~0_combout\,
	datad => \inst|Equal17~1_combout\,
	combout => \inst|SPHI2~31_combout\);

-- Location: LCCOMB_X29_Y26_N2
\inst|SPHI2~128\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~128_combout\ = (\inst|counter\(6) & (\inst|counter\(8) & (\inst|counter\(4) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(8),
	datac => \inst|counter\(4),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|SPHI2~128_combout\);

-- Location: LCCOMB_X29_Y26_N8
\inst|SPHI2~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~32_combout\ = (\inst|SPHI2~31_combout\ & ((\inst|counter\(7)) # ((\inst|counter\(3) & !\inst|SPHI2~128_combout\)))) # (!\inst|SPHI2~31_combout\ & (((!\inst|counter\(7) & \inst|SPHI2~128_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~31_combout\,
	datab => \inst|counter\(3),
	datac => \inst|counter\(7),
	datad => \inst|SPHI2~128_combout\,
	combout => \inst|SPHI2~32_combout\);

-- Location: LCCOMB_X29_Y26_N14
\inst|SPHI2~33\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~33_combout\ = ((\inst|SPHI2~32_combout\ & (!\inst|Equal17~1_combout\ & \inst|SPHI2~31_combout\)) # (!\inst|SPHI2~32_combout\ & ((!\inst|SPHI2~31_combout\)))) # (!\inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal17~1_combout\,
	datab => \inst|counter\(5),
	datac => \inst|SPHI2~32_combout\,
	datad => \inst|SPHI2~31_combout\,
	combout => \inst|SPHI2~33_combout\);

-- Location: LCCOMB_X29_Y26_N24
\inst|SPHI2~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~34_combout\ = (\inst|Equal37~3_combout\) # ((\inst|Equal9~0_combout\ & (!\inst|counter\(3) & !\inst|counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal9~0_combout\,
	datab => \inst|counter\(3),
	datac => \inst|counter\(5),
	datad => \inst|Equal37~3_combout\,
	combout => \inst|SPHI2~34_combout\);

-- Location: LCCOMB_X29_Y26_N22
\inst|SPHI2~35\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~35_combout\ = (\inst|SPHI2~33_combout\ & (((!\inst|SPHI2~34_combout\) # (!\inst|Equal229~0_combout\)) # (!\inst|counter\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|Equal229~0_combout\,
	datac => \inst|SPHI2~33_combout\,
	datad => \inst|SPHI2~34_combout\,
	combout => \inst|SPHI2~35_combout\);

-- Location: LCCOMB_X24_Y26_N14
\inst|SPHI2~133\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~133_combout\ = (\inst|Equal3~1_combout\ & (\inst|counter\(8) & ((\inst|SPHI1~136_combout\) # (\inst|SPHI1~142_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~136_combout\,
	datab => \inst|Equal3~1_combout\,
	datac => \inst|SPHI1~142_combout\,
	datad => \inst|counter\(8),
	combout => \inst|SPHI2~133_combout\);

-- Location: LCCOMB_X26_Y26_N18
\inst|Equal37~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal37~4_combout\ = (!\inst|counter\(4) & (\inst|counter\(6) & \inst|Equal37~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(6),
	datad => \inst|Equal37~3_combout\,
	combout => \inst|Equal37~4_combout\);

-- Location: LCCOMB_X28_Y26_N26
\inst|Equal25~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal25~0_combout\ = (!\inst|counter\(7) & (!\inst|counter\(3) & (\inst|Equal9~0_combout\ & \inst|counter\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(3),
	datac => \inst|Equal9~0_combout\,
	datad => \inst|counter\(5),
	combout => \inst|Equal25~0_combout\);

-- Location: LCCOMB_X26_Y26_N28
\inst|Equal17~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal17~2_combout\ = (\inst|counter\(5) & \inst|Equal17~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|counter\(5),
	datad => \inst|Equal17~1_combout\,
	combout => \inst|Equal17~2_combout\);

-- Location: LCCOMB_X25_Y27_N14
\inst|Equal13~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal13~2_combout\ = (!\inst|counter\(7) & (\inst|Equal13~0_combout\ & \inst|counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datac => \inst|Equal13~0_combout\,
	datad => \inst|counter\(5),
	combout => \inst|Equal13~2_combout\);

-- Location: LCCOMB_X25_Y27_N10
\inst|Equal57~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal57~2_combout\ = (!\inst|counter\(3) & (!\inst|counter\(7) & (\inst|Equal9~0_combout\ & \inst|Equal175~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(7),
	datac => \inst|Equal9~0_combout\,
	datad => \inst|Equal175~0_combout\,
	combout => \inst|Equal57~2_combout\);

-- Location: LCCOMB_X25_Y27_N24
\inst|SPHI2~117\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~117_combout\ = (\inst|Equal285~0_combout\ & ((\inst|Equal13~2_combout\) # ((\inst|Equal295~0_combout\ & \inst|Equal57~2_combout\)))) # (!\inst|Equal285~0_combout\ & (\inst|Equal295~0_combout\ & ((\inst|Equal57~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal285~0_combout\,
	datab => \inst|Equal295~0_combout\,
	datac => \inst|Equal13~2_combout\,
	datad => \inst|Equal57~2_combout\,
	combout => \inst|SPHI2~117_combout\);

-- Location: LCCOMB_X25_Y27_N30
\inst|SPHI2~118\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~118_combout\ = (\inst|SPHI2~117_combout\) # ((\inst|Equal245~1_combout\ & ((\inst|Equal25~0_combout\) # (\inst|Equal17~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal25~0_combout\,
	datab => \inst|Equal245~1_combout\,
	datac => \inst|Equal17~2_combout\,
	datad => \inst|SPHI2~117_combout\,
	combout => \inst|SPHI2~118_combout\);

-- Location: LCCOMB_X25_Y26_N28
\inst|Equal237~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal237~2_combout\ = (\inst|counter\(8) & (!\inst|counter\(5) & (!\inst|counter\(7) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(5),
	datac => \inst|counter\(7),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal237~2_combout\);

-- Location: LCCOMB_X25_Y26_N10
\inst|Equal241~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal241~2_combout\ = (\inst|counter\(8) & (!\inst|counter\(5) & \inst|Equal17~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|counter\(5),
	datad => \inst|Equal17~1_combout\,
	combout => \inst|Equal241~2_combout\);

-- Location: LCCOMB_X25_Y26_N24
\inst|SPHI2~116\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~116_combout\ = (\inst|Equal37~2_combout\ & (!\inst|Equal241~2_combout\ & ((!\inst|Equal45~0_combout\) # (!\inst|Equal237~2_combout\)))) # (!\inst|Equal37~2_combout\ & (((!\inst|Equal45~0_combout\)) # (!\inst|Equal237~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal37~2_combout\,
	datab => \inst|Equal237~2_combout\,
	datac => \inst|Equal45~0_combout\,
	datad => \inst|Equal241~2_combout\,
	combout => \inst|SPHI2~116_combout\);

-- Location: LCCOMB_X26_Y26_N12
\inst|SPHI2~119\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~119_combout\ = (!\inst|SPHI2~118_combout\ & (\inst|SPHI2~116_combout\ & ((!\inst|Equal37~4_combout\) # (!\inst|Equal249~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal249~0_combout\,
	datab => \inst|Equal37~4_combout\,
	datac => \inst|SPHI2~118_combout\,
	datad => \inst|SPHI2~116_combout\,
	combout => \inst|SPHI2~119_combout\);

-- Location: LCCOMB_X24_Y26_N18
\inst|SPHI2~129\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~129_combout\ = (\inst|Equal395~0_combout\) # ((!\inst|counter\(5) & (!\inst|SPHI1~104_combout\ & \inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|SPHI1~104_combout\,
	datac => \inst|counter\(6),
	datad => \inst|Equal395~0_combout\,
	combout => \inst|SPHI2~129_combout\);

-- Location: LCCOMB_X24_Y26_N8
\inst|SPHI2~130\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~130_combout\ = (\inst|counter\(8) & (!\inst|counter\(7) & (\inst|Equal3~1_combout\ & \inst|SPHI2~129_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(7),
	datac => \inst|Equal3~1_combout\,
	datad => \inst|SPHI2~129_combout\,
	combout => \inst|SPHI2~130_combout\);

-- Location: LCCOMB_X25_Y27_N22
\inst|Equal317~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal317~0_combout\ = (!\inst|counter\(7) & (\inst|Equal231~0_combout\ & (\inst|Equal13~0_combout\ & \inst|Equal227~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|Equal231~0_combout\,
	datac => \inst|Equal13~0_combout\,
	datad => \inst|Equal227~0_combout\,
	combout => \inst|Equal317~0_combout\);

-- Location: LCCOMB_X24_Y27_N8
\inst|SPHI2~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~36_combout\ = (\inst|counter\(8) & (\inst|counter\(5) & (!\inst|counter\(7) & !\inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(5),
	datac => \inst|counter\(7),
	datad => \inst|counter\(3),
	combout => \inst|SPHI2~36_combout\);

-- Location: LCCOMB_X25_Y27_N28
\inst|SPHI2~37\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~37_combout\ = (((!\inst|Equal13~0_combout\ & !\inst|Equal9~0_combout\)) # (!\inst|SPHI2~36_combout\)) # (!\inst|Equal37~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal37~2_combout\,
	datab => \inst|Equal13~0_combout\,
	datac => \inst|Equal9~0_combout\,
	datad => \inst|SPHI2~36_combout\,
	combout => \inst|SPHI2~37_combout\);

-- Location: LCCOMB_X26_Y26_N14
\inst|Equal53~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal53~1_combout\ = (!\inst|counter\(7) & \inst|Equal37~3_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datad => \inst|Equal37~3_combout\,
	combout => \inst|Equal53~1_combout\);

-- Location: LCCOMB_X25_Y27_N4
\inst|SPHI2~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~38_combout\ = ((!\inst|Equal57~2_combout\ & ((!\inst|Equal53~1_combout\) # (!\inst|counter\(6))))) # (!\inst|Equal245~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal57~2_combout\,
	datab => \inst|counter\(6),
	datac => \inst|Equal245~0_combout\,
	datad => \inst|Equal53~1_combout\,
	combout => \inst|SPHI2~38_combout\);

-- Location: LCCOMB_X25_Y27_N2
\inst|SPHI2~39\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~39_combout\ = (!\inst|counter\(7) & (\inst|counter\(5) & (\inst|Equal13~0_combout\ & \inst|Equal333~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(5),
	datac => \inst|Equal13~0_combout\,
	datad => \inst|Equal333~0_combout\,
	combout => \inst|SPHI2~39_combout\);

-- Location: LCCOMB_X25_Y27_N20
\inst|SPHI2~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~40_combout\ = (!\inst|SPHI2~39_combout\ & (((!\inst|Equal17~1_combout\) # (!\inst|Equal231~0_combout\)) # (!\inst|Equal193~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal193~0_combout\,
	datab => \inst|Equal231~0_combout\,
	datac => \inst|Equal17~1_combout\,
	datad => \inst|SPHI2~39_combout\,
	combout => \inst|SPHI2~40_combout\);

-- Location: LCCOMB_X25_Y27_N8
\inst|SPHI2~41\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~41_combout\ = (!\inst|Equal317~0_combout\ & (\inst|SPHI2~37_combout\ & (\inst|SPHI2~38_combout\ & \inst|SPHI2~40_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal317~0_combout\,
	datab => \inst|SPHI2~37_combout\,
	datac => \inst|SPHI2~38_combout\,
	datad => \inst|SPHI2~40_combout\,
	combout => \inst|SPHI2~41_combout\);

-- Location: LCCOMB_X24_Y26_N10
\inst|SPHI2~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~42_combout\ = (\inst|counter\(3) & ((\inst|counter\(5) & ((!\inst|counter\(4)))) # (!\inst|counter\(5) & (\inst|counter\(2) & \inst|counter\(4))))) # (!\inst|counter\(3) & (\inst|counter\(5) & ((\inst|counter\(4)) # (!\inst|counter\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011100011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(3),
	datac => \inst|counter\(5),
	datad => \inst|counter\(4),
	combout => \inst|SPHI2~42_combout\);

-- Location: LCCOMB_X24_Y26_N20
\inst|SPHI2~43\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~43_combout\ = (\inst|SPHI2~42_combout\ & (!\inst|counter\(6) & (\inst|Equal3~1_combout\ & \inst|Equal249~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~42_combout\,
	datab => \inst|counter\(6),
	datac => \inst|Equal3~1_combout\,
	datad => \inst|Equal249~0_combout\,
	combout => \inst|SPHI2~43_combout\);

-- Location: LCCOMB_X29_Y26_N20
\inst|SPHI2~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~44_combout\ = (\inst|Equal9~0_combout\ & ((\inst|Equal229~0_combout\) # ((\inst|Equal245~1_combout\ & \inst|Equal13~0_combout\)))) # (!\inst|Equal9~0_combout\ & (((\inst|Equal245~1_combout\ & \inst|Equal13~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal9~0_combout\,
	datab => \inst|Equal229~0_combout\,
	datac => \inst|Equal245~1_combout\,
	datad => \inst|Equal13~0_combout\,
	combout => \inst|SPHI2~44_combout\);

-- Location: LCCOMB_X29_Y26_N26
\inst|SPHI2~45\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~45_combout\ = ((\inst|counter\(7)) # ((\inst|counter\(3)) # (!\inst|SPHI2~44_combout\))) # (!\inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(7),
	datac => \inst|counter\(3),
	datad => \inst|SPHI2~44_combout\,
	combout => \inst|SPHI2~45_combout\);

-- Location: LCCOMB_X29_Y26_N28
\inst|SPHI2~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~46_combout\ = (!\inst|counter\(7) & (\inst|counter\(3) & \inst|Equal13~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(7),
	datac => \inst|counter\(3),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|SPHI2~46_combout\);

-- Location: LCCOMB_X29_Y26_N18
\inst|SPHI2~47\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~47_combout\ = (((!\inst|Equal17~1_combout\ & !\inst|SPHI2~46_combout\)) # (!\inst|counter\(5))) # (!\inst|Equal229~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal17~1_combout\,
	datab => \inst|Equal229~0_combout\,
	datac => \inst|counter\(5),
	datad => \inst|SPHI2~46_combout\,
	combout => \inst|SPHI2~47_combout\);

-- Location: LCCOMB_X29_Y26_N12
\inst|SPHI2~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~48_combout\ = (\inst|SPHI2~43_combout\) # ((\inst|Equal264~0_combout\ & (\inst|SPHI2~45_combout\ & \inst|SPHI2~47_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~43_combout\,
	datab => \inst|Equal264~0_combout\,
	datac => \inst|SPHI2~45_combout\,
	datad => \inst|SPHI2~47_combout\,
	combout => \inst|SPHI2~48_combout\);

-- Location: LCCOMB_X24_Y29_N14
\inst|SPHI2~114\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~114_combout\ = (\inst|SPHI1~119_combout\ & (\inst|Equal3~1_combout\ & \inst|SPHI2~22_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI1~119_combout\,
	datac => \inst|Equal3~1_combout\,
	datad => \inst|SPHI2~22_combout\,
	combout => \inst|SPHI2~114_combout\);

-- Location: LCCOMB_X28_Y29_N26
\inst|SPHI2~49\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~49_combout\ = (\inst|Equal29~0_combout\ & (!\inst|counter\(7) & \inst|Equal13~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal29~0_combout\,
	datab => \inst|counter\(7),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|SPHI2~49_combout\);

-- Location: LCCOMB_X28_Y29_N0
\inst|SPHI2~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~50_combout\ = ((!\inst|SPHI2~49_combout\ & ((!\inst|Equal123~0_combout\) # (!\inst|Equal17~1_combout\)))) # (!\inst|Equal231~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal17~1_combout\,
	datab => \inst|Equal123~0_combout\,
	datac => \inst|SPHI2~49_combout\,
	datad => \inst|Equal231~0_combout\,
	combout => \inst|SPHI2~50_combout\);

-- Location: LCCOMB_X28_Y26_N16
\inst|Equal21~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal21~0_combout\ = (\inst|counter\(5) & (!\inst|counter\(7) & (!\inst|counter\(3) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(7),
	datac => \inst|counter\(3),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal21~0_combout\);

-- Location: LCCOMB_X29_Y26_N30
\inst|Equal261~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal261~0_combout\ = (!\inst|counter\(4) & (\inst|counter\(8) & (\inst|Equal21~0_combout\ & !\inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(8),
	datac => \inst|Equal21~0_combout\,
	datad => \inst|counter\(6),
	combout => \inst|Equal261~0_combout\);

-- Location: LCCOMB_X29_Y26_N4
\inst|SPHI2~51\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~51_combout\ = (\inst|SPHI2~45_combout\ & (\inst|SPHI2~50_combout\ & (!\inst|Equal261~0_combout\ & \inst|SPHI2~47_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~45_combout\,
	datab => \inst|SPHI2~50_combout\,
	datac => \inst|Equal261~0_combout\,
	datad => \inst|SPHI2~47_combout\,
	combout => \inst|SPHI2~51_combout\);

-- Location: LCCOMB_X25_Y26_N0
\inst|SPHI2~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~56_combout\ = (\inst|Equal229~1_combout\ & (!\inst|Equal37~3_combout\ & ((!\inst|Equal241~2_combout\) # (!\inst|Equal2~0_combout\)))) # (!\inst|Equal229~1_combout\ & (((!\inst|Equal241~2_combout\)) # (!\inst|Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal229~1_combout\,
	datab => \inst|Equal2~0_combout\,
	datac => \inst|Equal37~3_combout\,
	datad => \inst|Equal241~2_combout\,
	combout => \inst|SPHI2~56_combout\);

-- Location: LCCOMB_X25_Y26_N14
\inst|SPHI2~55\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~55_combout\ = (\inst|Equal245~1_combout\ & (!\inst|Equal53~1_combout\ & ((!\inst|Equal237~2_combout\) # (!\inst|Equal3~4_combout\)))) # (!\inst|Equal245~1_combout\ & (((!\inst|Equal237~2_combout\)) # (!\inst|Equal3~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal245~1_combout\,
	datab => \inst|Equal3~4_combout\,
	datac => \inst|Equal53~1_combout\,
	datad => \inst|Equal237~2_combout\,
	combout => \inst|SPHI2~55_combout\);

-- Location: LCCOMB_X25_Y26_N26
\inst|SPHI2~131\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~131_combout\ = (\inst|Equal193~0_combout\ & (\inst|counter\(7) & (\inst|counter\(0) & \inst|Equal17~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal193~0_combout\,
	datab => \inst|counter\(7),
	datac => \inst|counter\(0),
	datad => \inst|Equal17~0_combout\,
	combout => \inst|SPHI2~131_combout\);

-- Location: LCCOMB_X25_Y26_N16
\inst|SPHI2~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~52_combout\ = (\inst|counter\(8) & ((\inst|counter\(5)) # ((!\inst|counter\(7) & \inst|Equal123~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(7),
	datac => \inst|counter\(5),
	datad => \inst|Equal123~0_combout\,
	combout => \inst|SPHI2~52_combout\);

-- Location: LCCOMB_X25_Y26_N30
\inst|SPHI2~53\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~53_combout\ = (\inst|counter\(5) & (((\inst|SPHI2~52_combout\)))) # (!\inst|counter\(5) & (!\inst|counter\(3) & ((\inst|Equal229~1_combout\) # (\inst|SPHI2~52_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(5),
	datac => \inst|Equal229~1_combout\,
	datad => \inst|SPHI2~52_combout\,
	combout => \inst|SPHI2~53_combout\);

-- Location: LCCOMB_X25_Y26_N20
\inst|SPHI2~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~54_combout\ = (\inst|counter\(5) & (((\inst|SPHI2~53_combout\) # (!\inst|SPHI2~131_combout\)))) # (!\inst|counter\(5) & (((!\inst|SPHI2~53_combout\)) # (!\inst|Equal9~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal9~0_combout\,
	datab => \inst|counter\(5),
	datac => \inst|SPHI2~131_combout\,
	datad => \inst|SPHI2~53_combout\,
	combout => \inst|SPHI2~54_combout\);

-- Location: LCCOMB_X25_Y26_N6
\inst|SPHI2~57\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~57_combout\ = (\inst|SPHI2~56_combout\ & (\inst|SPHI2~55_combout\ & \inst|SPHI2~54_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|SPHI2~56_combout\,
	datac => \inst|SPHI2~55_combout\,
	datad => \inst|SPHI2~54_combout\,
	combout => \inst|SPHI2~57_combout\);

-- Location: LCCOMB_X24_Y26_N22
\inst|SPHI2~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~58_combout\ = (\inst|counter\(5) & (\inst|Equal3~1_combout\ & \inst|SPHI1~121_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datac => \inst|Equal3~1_combout\,
	datad => \inst|SPHI1~121_combout\,
	combout => \inst|SPHI2~58_combout\);

-- Location: LCCOMB_X28_Y25_N8
\inst|Equal73~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal73~0_combout\ = (\inst|counter\(5) & (\inst|Equal9~0_combout\ & (\inst|Equal37~2_combout\ & !\inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal9~0_combout\,
	datac => \inst|Equal37~2_combout\,
	datad => \inst|counter\(3),
	combout => \inst|Equal73~0_combout\);

-- Location: LCCOMB_X26_Y25_N4
\inst|Equal145~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal145~0_combout\ = (\inst|SPHI2~20_combout\ & (!\inst|counter\(8) & (\inst|counter\(5) & \inst|Equal17~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~20_combout\,
	datab => \inst|counter\(8),
	datac => \inst|counter\(5),
	datad => \inst|Equal17~0_combout\,
	combout => \inst|Equal145~0_combout\);

-- Location: LCCOMB_X26_Y25_N26
\inst|SPHI2~109\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~109_combout\ = (\inst|Equal53~0_combout\ & (!\inst|Equal153~0_combout\ & ((!\inst|Equal145~0_combout\) # (!\inst|Equal37~2_combout\)))) # (!\inst|Equal53~0_combout\ & (((!\inst|Equal145~0_combout\)) # (!\inst|Equal37~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal53~0_combout\,
	datab => \inst|Equal37~2_combout\,
	datac => \inst|Equal145~0_combout\,
	datad => \inst|Equal153~0_combout\,
	combout => \inst|SPHI2~109_combout\);

-- Location: LCCOMB_X27_Y25_N6
\inst|Equal133~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal133~0_combout\ = (\inst|counter\(7) & (\inst|counter\(5) & (!\inst|counter\(8) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(5),
	datac => \inst|counter\(8),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal133~0_combout\);

-- Location: LCCOMB_X27_Y25_N18
\inst|SPHI2~110\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~110_combout\ = (\inst|Equal133~0_combout\ & ((\inst|Equal45~0_combout\) # ((\inst|Equal37~2_combout\ & !\inst|counter\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal37~2_combout\,
	datab => \inst|counter\(3),
	datac => \inst|Equal45~0_combout\,
	datad => \inst|Equal133~0_combout\,
	combout => \inst|SPHI2~110_combout\);

-- Location: LCCOMB_X27_Y25_N28
\inst|SPHI2~111\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~111_combout\ = (\inst|SPHI2~110_combout\) # ((\inst|counter\(5) & (\inst|Equal53~0_combout\ & \inst|Equal149~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal53~0_combout\,
	datac => \inst|Equal149~2_combout\,
	datad => \inst|SPHI2~110_combout\,
	combout => \inst|SPHI2~111_combout\);

-- Location: LCCOMB_X26_Y25_N8
\inst|SPHI2~112\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~112_combout\ = (\inst|SPHI2~109_combout\ & (!\inst|SPHI2~111_combout\ & ((!\inst|Equal73~0_combout\) # (!\inst|Equal101~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|Equal73~0_combout\,
	datac => \inst|SPHI2~109_combout\,
	datad => \inst|SPHI2~111_combout\,
	combout => \inst|SPHI2~112_combout\);

-- Location: LCCOMB_X29_Y29_N24
\inst|SPHI2~59\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~59_combout\ = (\inst|counter\(5) & (!\inst|counter\(3) & (!\inst|counter\(4) & !\inst|counter\(2)))) # (!\inst|counter\(5) & ((\inst|counter\(3)) # ((\inst|counter\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(3),
	datac => \inst|counter\(4),
	datad => \inst|counter\(2),
	combout => \inst|SPHI2~59_combout\);

-- Location: LCCOMB_X28_Y29_N10
\inst|SPHI2~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~60_combout\ = (\inst|Equal101~0_combout\ & (\inst|counter\(6) & (\inst|Equal3~1_combout\ & \inst|SPHI2~59_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|counter\(6),
	datac => \inst|Equal3~1_combout\,
	datad => \inst|SPHI2~59_combout\,
	combout => \inst|SPHI2~60_combout\);

-- Location: LCCOMB_X27_Y30_N20
\inst|Equal136~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal136~2_combout\ = (!\inst|counter\(0) & (!\inst|counter\(1) & (\inst|Equal101~0_combout\ & \inst|SPHI1~81_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(0),
	datab => \inst|counter\(1),
	datac => \inst|Equal101~0_combout\,
	datad => \inst|SPHI1~81_combout\,
	combout => \inst|Equal136~2_combout\);

-- Location: LCCOMB_X27_Y30_N26
\inst|SPHI2~65\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~65_combout\ = (\inst|Equal136~2_combout\ & ((\inst|Equal43~0_combout\) # ((!\inst|SPHI1~90_combout\ & \inst|Equal143~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal43~0_combout\,
	datab => \inst|SPHI1~90_combout\,
	datac => \inst|Equal143~0_combout\,
	datad => \inst|Equal136~2_combout\,
	combout => \inst|SPHI2~65_combout\);

-- Location: LCCOMB_X27_Y25_N4
\inst|Equal181~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal181~0_combout\ = (\inst|counter\(7) & (\inst|Equal37~3_combout\ & \inst|Equal53~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datac => \inst|Equal37~3_combout\,
	datad => \inst|Equal53~0_combout\,
	combout => \inst|Equal181~0_combout\);

-- Location: LCCOMB_X27_Y25_N26
\inst|Equal113~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal113~0_combout\ = (!\inst|counter\(8) & (!\inst|counter\(5) & (\inst|SPHI2~20_combout\ & \inst|Equal17~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(5),
	datac => \inst|SPHI2~20_combout\,
	datad => \inst|Equal17~0_combout\,
	combout => \inst|Equal113~0_combout\);

-- Location: LCCOMB_X28_Y25_N10
\inst|Equal41~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal41~4_combout\ = (!\inst|counter\(3) & (\inst|counter\(6) & (!\inst|counter\(5) & \inst|Equal9~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(6),
	datac => \inst|counter\(5),
	datad => \inst|Equal9~0_combout\,
	combout => \inst|Equal41~4_combout\);

-- Location: LCCOMB_X27_Y25_N30
\inst|SPHI2~62\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~62_combout\ = (\inst|counter\(8)) # ((!\inst|counter\(7)) # (!\inst|Equal41~4_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|Equal41~4_combout\,
	datad => \inst|counter\(7),
	combout => \inst|SPHI2~62_combout\);

-- Location: LCCOMB_X27_Y25_N0
\inst|Equal109~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal109~0_combout\ = (\inst|counter\(7) & (!\inst|counter\(5) & (!\inst|counter\(8) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(5),
	datac => \inst|counter\(8),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal109~0_combout\);

-- Location: LCCOMB_X27_Y25_N24
\inst|SPHI2~61\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~61_combout\ = ((!\inst|Equal113~0_combout\ & ((!\inst|Equal109~0_combout\) # (!\inst|counter\(3))))) # (!\inst|Equal37~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101011101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal37~2_combout\,
	datab => \inst|counter\(3),
	datac => \inst|Equal113~0_combout\,
	datad => \inst|Equal109~0_combout\,
	combout => \inst|SPHI2~61_combout\);

-- Location: LCCOMB_X27_Y25_N20
\inst|SPHI2~63\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~63_combout\ = (\inst|SPHI2~62_combout\ & (\inst|SPHI2~61_combout\ & ((!\inst|Equal193~0_combout\) # (!\inst|Equal113~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal113~0_combout\,
	datab => \inst|Equal193~0_combout\,
	datac => \inst|SPHI2~62_combout\,
	datad => \inst|SPHI2~61_combout\,
	combout => \inst|SPHI2~63_combout\);

-- Location: LCCOMB_X27_Y25_N10
\inst|SPHI2~64\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~64_combout\ = (!\inst|Equal181~0_combout\ & (\inst|SPHI2~63_combout\ & ((!\inst|Equal149~2_combout\) # (!\inst|Equal61~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal61~0_combout\,
	datab => \inst|Equal149~2_combout\,
	datac => \inst|Equal181~0_combout\,
	datad => \inst|SPHI2~63_combout\,
	combout => \inst|SPHI2~64_combout\);

-- Location: LCCOMB_X27_Y30_N12
\inst|SPHI2~72\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~72_combout\ = (!\inst|counter\(6) & ((\inst|counter\(4) & ((!\inst|counter\(5)))) # (!\inst|counter\(4) & (!\inst|counter\(2) & \inst|counter\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(5),
	combout => \inst|SPHI2~72_combout\);

-- Location: LCCOMB_X27_Y30_N22
\inst|Equal137~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal137~0_combout\ = (\inst|counter\(5) & (\inst|Equal9~1_combout\ & (\inst|Equal101~0_combout\ & \inst|Equal9~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal9~1_combout\,
	datac => \inst|Equal101~0_combout\,
	datad => \inst|Equal9~0_combout\,
	combout => \inst|Equal137~0_combout\);

-- Location: LCCOMB_X27_Y30_N8
\inst|SPHI2~73\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~73_combout\ = (\inst|Equal136~2_combout\ & ((\inst|SPHI2~72_combout\) # ((\inst|Equal8~2_combout\ & !\inst|Equal137~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~72_combout\,
	datab => \inst|Equal8~2_combout\,
	datac => \inst|Equal137~0_combout\,
	datad => \inst|Equal136~2_combout\,
	combout => \inst|SPHI2~73_combout\);

-- Location: LCCOMB_X26_Y26_N4
\inst|Equal105~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal105~0_combout\ = (!\inst|counter\(3) & (!\inst|counter\(5) & (\inst|counter\(7) & \inst|Equal9~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(5),
	datac => \inst|counter\(7),
	datad => \inst|Equal9~0_combout\,
	combout => \inst|Equal105~0_combout\);

-- Location: LCCOMB_X26_Y26_N16
\inst|SPHI2~105\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~105_combout\ = (!\inst|Equal137~0_combout\ & (((!\inst|Equal105~0_combout\ & !\inst|Equal117~0_combout\)) # (!\inst|Equal4~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~1_combout\,
	datab => \inst|Equal105~0_combout\,
	datac => \inst|Equal117~0_combout\,
	datad => \inst|Equal137~0_combout\,
	combout => \inst|SPHI2~105_combout\);

-- Location: LCCOMB_X27_Y25_N12
\inst|SPHI2~104\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~104_combout\ = (\inst|Equal9~1_combout\ & (!\inst|Equal133~0_combout\ & ((!\inst|Equal113~0_combout\) # (!\inst|Equal123~0_combout\)))) # (!\inst|Equal9~1_combout\ & (((!\inst|Equal113~0_combout\)) # (!\inst|Equal123~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal9~1_combout\,
	datab => \inst|Equal123~0_combout\,
	datac => \inst|Equal113~0_combout\,
	datad => \inst|Equal133~0_combout\,
	combout => \inst|SPHI2~104_combout\);

-- Location: LCCOMB_X27_Y25_N8
\inst|SPHI2~103\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~103_combout\ = (\inst|Equal29~0_combout\ & (!\inst|Equal109~0_combout\ & ((!\inst|Equal113~0_combout\) # (!\inst|Equal2~0_combout\)))) # (!\inst|Equal29~0_combout\ & (((!\inst|Equal113~0_combout\)) # (!\inst|Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal29~0_combout\,
	datab => \inst|Equal2~0_combout\,
	datac => \inst|Equal113~0_combout\,
	datad => \inst|Equal109~0_combout\,
	combout => \inst|SPHI2~103_combout\);

-- Location: LCCOMB_X26_Y26_N6
\inst|SPHI2~106\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~106_combout\ = (\inst|SPHI2~105_combout\ & (\inst|SPHI2~104_combout\ & \inst|SPHI2~103_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|SPHI2~105_combout\,
	datac => \inst|SPHI2~104_combout\,
	datad => \inst|SPHI2~103_combout\,
	combout => \inst|SPHI2~106_combout\);

-- Location: LCCOMB_X26_Y25_N6
\inst|SPHI2~69\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~69_combout\ = (\inst|Equal6~0_combout\ & (\inst|counter\(7) & (\inst|Equal13~0_combout\ & \inst|Equal4~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal6~0_combout\,
	datab => \inst|counter\(7),
	datac => \inst|Equal13~0_combout\,
	datad => \inst|Equal4~1_combout\,
	combout => \inst|SPHI2~69_combout\);

-- Location: LCCOMB_X26_Y25_N20
\inst|SPHI2~70\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~70_combout\ = (!\inst|SPHI2~69_combout\ & (((!\inst|Equal37~3_combout\) # (!\inst|Equal37~2_combout\)) # (!\inst|Equal101~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal101~0_combout\,
	datab => \inst|Equal37~2_combout\,
	datac => \inst|Equal37~3_combout\,
	datad => \inst|SPHI2~69_combout\,
	combout => \inst|SPHI2~70_combout\);

-- Location: LCCOMB_X26_Y25_N30
\inst|SPHI2~66\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~66_combout\ = (!\inst|counter\(8) & (\inst|counter\(5) & ((\inst|Equal3~4_combout\) # (\inst|Equal29~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~4_combout\,
	datab => \inst|counter\(8),
	datac => \inst|counter\(5),
	datad => \inst|Equal29~0_combout\,
	combout => \inst|SPHI2~66_combout\);

-- Location: LCCOMB_X26_Y25_N2
\inst|SPHI2~67\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~67_combout\ = (\inst|Equal4~1_combout\ & ((\inst|Equal153~0_combout\) # ((\inst|Equal2~0_combout\ & \inst|Equal145~0_combout\)))) # (!\inst|Equal4~1_combout\ & (\inst|Equal2~0_combout\ & (\inst|Equal145~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~1_combout\,
	datab => \inst|Equal2~0_combout\,
	datac => \inst|Equal145~0_combout\,
	datad => \inst|Equal153~0_combout\,
	combout => \inst|SPHI2~67_combout\);

-- Location: LCCOMB_X26_Y25_N12
\inst|SPHI2~68\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~68_combout\ = (!\inst|SPHI2~67_combout\ & (((!\inst|Equal13~0_combout\) # (!\inst|counter\(7))) # (!\inst|SPHI2~66_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~66_combout\,
	datab => \inst|counter\(7),
	datac => \inst|Equal13~0_combout\,
	datad => \inst|SPHI2~67_combout\,
	combout => \inst|SPHI2~68_combout\);

-- Location: LCCOMB_X26_Y25_N22
\inst|SPHI2~71\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~71_combout\ = (\inst|SPHI2~70_combout\ & (\inst|SPHI2~68_combout\ & ((!\inst|Equal145~0_combout\) # (!\inst|Equal123~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal123~0_combout\,
	datab => \inst|SPHI2~70_combout\,
	datac => \inst|Equal145~0_combout\,
	datad => \inst|SPHI2~68_combout\,
	combout => \inst|SPHI2~71_combout\);

-- Location: LCCOMB_X24_Y26_N0
\inst|SPHI2~74\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~74_combout\ = (\inst|counter\(5) & (!\inst|counter\(7) & (\inst|counter\(6) & \inst|SPHI1~104_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(7),
	datac => \inst|counter\(6),
	datad => \inst|SPHI1~104_combout\,
	combout => \inst|SPHI2~74_combout\);

-- Location: LCCOMB_X24_Y26_N6
\inst|SPHI2~75\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~75_combout\ = (!\inst|counter\(5) & (\inst|counter\(7) & (!\inst|counter\(6) & !\inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(7),
	datac => \inst|counter\(6),
	datad => \inst|counter\(4),
	combout => \inst|SPHI2~75_combout\);

-- Location: LCCOMB_X24_Y26_N24
\inst|SPHI2~76\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~76_combout\ = (!\inst|counter\(8) & (\inst|Equal3~1_combout\ & ((\inst|SPHI2~74_combout\) # (\inst|SPHI2~75_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|SPHI2~74_combout\,
	datac => \inst|Equal3~1_combout\,
	datad => \inst|SPHI2~75_combout\,
	combout => \inst|SPHI2~76_combout\);

-- Location: LCCOMB_X29_Y29_N30
\inst|SPHI2~100\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~100_combout\ = (\inst|counter\(5) & (((!\inst|counter\(3) & !\inst|counter\(2))) # (!\inst|counter\(4)))) # (!\inst|counter\(5) & (\inst|counter\(3) & (\inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100101001101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(3),
	datac => \inst|counter\(4),
	datad => \inst|counter\(2),
	combout => \inst|SPHI2~100_combout\);

-- Location: LCCOMB_X29_Y26_N16
\inst|SPHI2~101\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~101_combout\ = (\inst|counter\(6) & (\inst|Equal8~0_combout\ & \inst|SPHI2~100_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datac => \inst|Equal8~0_combout\,
	datad => \inst|SPHI2~100_combout\,
	combout => \inst|SPHI2~101_combout\);

-- Location: LCCOMB_X26_Y25_N0
\inst|Equal101~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal101~1_combout\ = (\inst|counter\(7) & (!\inst|counter\(6) & (!\inst|counter\(4) & !\inst|counter\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|counter\(6),
	datac => \inst|counter\(4),
	datad => \inst|counter\(8),
	combout => \inst|Equal101~1_combout\);

-- Location: LCCOMB_X26_Y26_N2
\inst|SPHI2~78\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~78_combout\ = (\inst|Equal53~0_combout\ & (!\inst|Equal17~2_combout\ & ((!\inst|Equal101~1_combout\) # (!\inst|Equal37~3_combout\)))) # (!\inst|Equal53~0_combout\ & (((!\inst|Equal101~1_combout\)) # (!\inst|Equal37~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal53~0_combout\,
	datab => \inst|Equal37~3_combout\,
	datac => \inst|Equal101~1_combout\,
	datad => \inst|Equal17~2_combout\,
	combout => \inst|SPHI2~78_combout\);

-- Location: LCCOMB_X29_Y26_N10
\inst|Equal85~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal85~0_combout\ = (\inst|counter\(6) & (\inst|counter\(5) & (!\inst|counter\(7) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|counter\(5),
	datac => \inst|counter\(7),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal85~0_combout\);

-- Location: LCCOMB_X28_Y26_N20
\inst|SPHI2~77\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~77_combout\ = (\inst|Equal3~4_combout\ & (!\inst|Equal109~0_combout\ & ((!\inst|Equal25~0_combout\) # (!\inst|Equal53~0_combout\)))) # (!\inst|Equal3~4_combout\ & (((!\inst|Equal25~0_combout\)) # (!\inst|Equal53~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~4_combout\,
	datab => \inst|Equal53~0_combout\,
	datac => \inst|Equal25~0_combout\,
	datad => \inst|Equal109~0_combout\,
	combout => \inst|SPHI2~77_combout\);

-- Location: LCCOMB_X28_Y26_N2
\inst|SPHI2~132\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~132_combout\ = (\inst|SPHI2~77_combout\ & (((\inst|counter\(8)) # (!\inst|Equal85~0_combout\)) # (!\inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(8),
	datac => \inst|Equal85~0_combout\,
	datad => \inst|SPHI2~77_combout\,
	combout => \inst|SPHI2~132_combout\);

-- Location: LCCOMB_X28_Y26_N10
\inst|SPHI2~79\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~79_combout\ = (\inst|SPHI2~78_combout\ & (\inst|SPHI2~132_combout\ & ((!\inst|Equal105~0_combout\) # (!\inst|Equal7~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal7~5_combout\,
	datab => \inst|Equal105~0_combout\,
	datac => \inst|SPHI2~78_combout\,
	datad => \inst|SPHI2~132_combout\,
	combout => \inst|SPHI2~79_combout\);

-- Location: LCCOMB_X27_Y29_N22
\inst|Equal49~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal49~0_combout\ = (\inst|counter\(6) & (!\inst|counter\(8) & !\inst|counter\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datac => \inst|counter\(8),
	datad => \inst|counter\(4),
	combout => \inst|Equal49~0_combout\);

-- Location: LCCOMB_X26_Y26_N10
\inst|SPHI2~95\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~95_combout\ = ((\inst|counter\(5) & (!\inst|Equal4~1_combout\)) # (!\inst|counter\(5) & ((!\inst|Equal49~0_combout\)))) # (!\inst|Equal17~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal4~1_combout\,
	datab => \inst|counter\(5),
	datac => \inst|Equal49~0_combout\,
	datad => \inst|Equal17~1_combout\,
	combout => \inst|SPHI2~95_combout\);

-- Location: LCCOMB_X26_Y26_N8
\inst|Equal29~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal29~2_combout\ = (!\inst|counter\(7) & (\inst|Equal29~1_combout\ & (\inst|counter\(5) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|Equal29~1_combout\,
	datac => \inst|counter\(5),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal29~2_combout\);

-- Location: LCCOMB_X26_Y26_N26
\inst|SPHI2~96\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~96_combout\ = (\inst|SPHI2~95_combout\ & (!\inst|Equal29~2_combout\ & ((!\inst|Equal37~4_combout\) # (!\inst|Equal3~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~95_combout\,
	datab => \inst|Equal3~3_combout\,
	datac => \inst|Equal29~2_combout\,
	datad => \inst|Equal37~4_combout\,
	combout => \inst|SPHI2~96_combout\);

-- Location: LCCOMB_X26_Y26_N24
\inst|Equal41~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal41~3_combout\ = (!\inst|counter\(3) & (!\inst|counter\(4) & (\inst|Equal175~0_combout\ & \inst|Equal9~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(4),
	datac => \inst|Equal175~0_combout\,
	datad => \inst|Equal9~0_combout\,
	combout => \inst|Equal41~3_combout\);

-- Location: LCCOMB_X26_Y26_N22
\inst|SPHI2~97\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~97_combout\ = (\inst|Equal45~1_combout\ & (!\inst|Equal13~0_combout\ & ((!\inst|Equal41~3_combout\) # (!\inst|Equal3~3_combout\)))) # (!\inst|Equal45~1_combout\ & (((!\inst|Equal41~3_combout\) # (!\inst|Equal3~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal45~1_combout\,
	datab => \inst|Equal13~0_combout\,
	datac => \inst|Equal3~3_combout\,
	datad => \inst|Equal41~3_combout\,
	combout => \inst|SPHI2~97_combout\);

-- Location: LCCOMB_X26_Y26_N0
\inst|SPHI2~98\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~98_combout\ = (\inst|SPHI2~96_combout\ & (\inst|SPHI2~97_combout\ & ((!\inst|Equal53~1_combout\) # (!\inst|Equal53~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal53~0_combout\,
	datab => \inst|Equal53~1_combout\,
	datac => \inst|SPHI2~96_combout\,
	datad => \inst|SPHI2~97_combout\,
	combout => \inst|SPHI2~98_combout\);

-- Location: LCCOMB_X24_Y26_N30
\inst|SPHI2~87\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~87_combout\ = (\inst|Equal8~0_combout\ & (((!\inst|counter\(5) & \inst|Equal409~0_combout\)) # (!\inst|SPHI2~86_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|SPHI2~86_combout\,
	datac => \inst|Equal409~0_combout\,
	datad => \inst|Equal8~0_combout\,
	combout => \inst|SPHI2~87_combout\);

-- Location: LCCOMB_X28_Y25_N16
\inst|SPHI2~81\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~81_combout\ = (\inst|Equal17~1_combout\) # ((\inst|counter\(3) & (!\inst|counter\(7) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|counter\(7),
	datac => \inst|Equal17~1_combout\,
	datad => \inst|Equal13~0_combout\,
	combout => \inst|SPHI2~81_combout\);

-- Location: LCCOMB_X28_Y25_N26
\inst|SPHI2~82\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~82_combout\ = ((\inst|counter\(8)) # ((!\inst|SPHI2~81_combout\) # (!\inst|Equal37~2_combout\))) # (!\inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(8),
	datac => \inst|Equal37~2_combout\,
	datad => \inst|SPHI2~81_combout\,
	combout => \inst|SPHI2~82_combout\);

-- Location: LCCOMB_X28_Y25_N28
\inst|Equal61~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal61~1_combout\ = (!\inst|counter\(7) & (\inst|Equal61~0_combout\ & \inst|Equal13~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|counter\(7),
	datac => \inst|Equal61~0_combout\,
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal61~1_combout\);

-- Location: LCCOMB_X28_Y25_N2
\inst|SPHI2~83\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~83_combout\ = (!\inst|Equal61~1_combout\ & ((\inst|counter\(5)) # ((!\inst|Equal17~1_combout\) # (!\inst|Equal53~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal53~0_combout\,
	datac => \inst|Equal17~1_combout\,
	datad => \inst|Equal61~1_combout\,
	combout => \inst|SPHI2~83_combout\);

-- Location: LCCOMB_X28_Y25_N4
\inst|Equal57~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal57~3_combout\ = (\inst|counter\(4) & (!\inst|counter\(8) & (!\inst|counter\(7) & \inst|Equal41~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(4),
	datab => \inst|counter\(8),
	datac => \inst|counter\(7),
	datad => \inst|Equal41~4_combout\,
	combout => \inst|Equal57~3_combout\);

-- Location: LCCOMB_X28_Y25_N6
\inst|SPHI2~80\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~80_combout\ = (\inst|Equal49~0_combout\ & (!\inst|Equal21~0_combout\ & ((!\inst|Equal73~0_combout\) # (!\inst|Equal3~3_combout\)))) # (!\inst|Equal49~0_combout\ & (((!\inst|Equal73~0_combout\)) # (!\inst|Equal3~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal49~0_combout\,
	datab => \inst|Equal3~3_combout\,
	datac => \inst|Equal73~0_combout\,
	datad => \inst|Equal21~0_combout\,
	combout => \inst|SPHI2~80_combout\);

-- Location: LCCOMB_X28_Y25_N0
\inst|SPHI2~84\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~84_combout\ = (\inst|SPHI2~82_combout\ & (\inst|SPHI2~83_combout\ & (!\inst|Equal57~3_combout\ & \inst|SPHI2~80_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~82_combout\,
	datab => \inst|SPHI2~83_combout\,
	datac => \inst|Equal57~3_combout\,
	datad => \inst|SPHI2~80_combout\,
	combout => \inst|SPHI2~84_combout\);

-- Location: LCCOMB_X27_Y30_N6
\inst|SPHI2~88\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~88_combout\ = (\inst|Equal143~0_combout\ & ((\inst|counter\(4) & ((!\inst|counter\(3)) # (!\inst|counter\(2)))) # (!\inst|counter\(4) & ((\inst|counter\(3))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|counter\(4),
	datac => \inst|Equal143~0_combout\,
	datad => \inst|counter\(3),
	combout => \inst|SPHI2~88_combout\);

-- Location: LCCOMB_X28_Y26_N12
\inst|SPHI2~89\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~89_combout\ = (\inst|Equal8~0_combout\ & ((\inst|SPHI2~88_combout\) # ((\inst|Equal395~0_combout\ & !\inst|counter\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal395~0_combout\,
	datab => \inst|counter\(2),
	datac => \inst|SPHI2~88_combout\,
	datad => \inst|Equal8~0_combout\,
	combout => \inst|SPHI2~89_combout\);

-- Location: LCCOMB_X28_Y26_N8
\inst|Equal13~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal13~1_combout\ = (\inst|counter\(5) & (!\inst|counter\(8) & (!\inst|counter\(7) & \inst|Equal13~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|counter\(8),
	datac => \inst|counter\(7),
	datad => \inst|Equal13~0_combout\,
	combout => \inst|Equal13~1_combout\);

-- Location: LCCOMB_X28_Y26_N6
\inst|Equal17~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal17~3_combout\ = (!\inst|counter\(8) & (\inst|Equal17~1_combout\ & \inst|counter\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datac => \inst|Equal17~1_combout\,
	datad => \inst|counter\(5),
	combout => \inst|Equal17~3_combout\);

-- Location: LCCOMB_X28_Y26_N14
\inst|SPHI2~90\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~90_combout\ = (\inst|Equal3~4_combout\ & (!\inst|Equal13~1_combout\ & ((!\inst|Equal17~3_combout\) # (!\inst|Equal2~0_combout\)))) # (!\inst|Equal3~4_combout\ & (((!\inst|Equal17~3_combout\)) # (!\inst|Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001101011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal3~4_combout\,
	datab => \inst|Equal2~0_combout\,
	datac => \inst|Equal13~1_combout\,
	datad => \inst|Equal17~3_combout\,
	combout => \inst|SPHI2~90_combout\);

-- Location: LCCOMB_X28_Y26_N22
\inst|SPHI2~92\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~92_combout\ = (\inst|SPHI2~q\) # ((!\inst|counter\(2) & (\inst|Equal3~1_combout\ & !\inst|Equal1~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~q\,
	datab => \inst|counter\(2),
	datac => \inst|Equal3~1_combout\,
	datad => \inst|Equal1~0_combout\,
	combout => \inst|SPHI2~92_combout\);

-- Location: LCCOMB_X28_Y26_N4
\inst|Equal9~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal9~2_combout\ = (\inst|counter\(5) & (\inst|Equal9~1_combout\ & (\inst|Equal9~0_combout\ & \inst|Equal3~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal9~1_combout\,
	datac => \inst|Equal9~0_combout\,
	datad => \inst|Equal3~3_combout\,
	combout => \inst|Equal9~2_combout\);

-- Location: LCCOMB_X28_Y26_N30
\inst|SPHI2~93\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~93_combout\ = (!\inst|Equal9~2_combout\ & ((\inst|Equal8~1_combout\) # ((\inst|SPHI2~92_combout\ & !\inst|Equal3~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~92_combout\,
	datab => \inst|Equal3~5_combout\,
	datac => \inst|Equal9~2_combout\,
	datad => \inst|Equal8~1_combout\,
	combout => \inst|SPHI2~93_combout\);

-- Location: LCCOMB_X28_Y26_N28
\inst|SPHI2~91\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~91_combout\ = ((!\inst|Equal25~0_combout\ & !\inst|Equal21~0_combout\)) # (!\inst|Equal4~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|Equal4~1_combout\,
	datac => \inst|Equal25~0_combout\,
	datad => \inst|Equal21~0_combout\,
	combout => \inst|SPHI2~91_combout\);

-- Location: LCCOMB_X28_Y26_N24
\inst|SPHI2~94\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~94_combout\ = (\inst|SPHI2~89_combout\) # ((\inst|SPHI2~90_combout\ & (\inst|SPHI2~93_combout\ & \inst|SPHI2~91_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~89_combout\,
	datab => \inst|SPHI2~90_combout\,
	datac => \inst|SPHI2~93_combout\,
	datad => \inst|SPHI2~91_combout\,
	combout => \inst|SPHI2~94_combout\);

-- Location: LCCOMB_X27_Y26_N18
\inst|SPHI2~99\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~99_combout\ = (\inst|SPHI2~84_combout\ & ((\inst|SPHI2~87_combout\) # ((\inst|SPHI2~98_combout\ & \inst|SPHI2~94_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~98_combout\,
	datab => \inst|SPHI2~87_combout\,
	datac => \inst|SPHI2~84_combout\,
	datad => \inst|SPHI2~94_combout\,
	combout => \inst|SPHI2~99_combout\);

-- Location: LCCOMB_X27_Y26_N28
\inst|SPHI2~102\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~102_combout\ = (\inst|SPHI2~76_combout\) # ((\inst|SPHI2~79_combout\ & ((\inst|SPHI2~101_combout\) # (\inst|SPHI2~99_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~76_combout\,
	datab => \inst|SPHI2~101_combout\,
	datac => \inst|SPHI2~79_combout\,
	datad => \inst|SPHI2~99_combout\,
	combout => \inst|SPHI2~102_combout\);

-- Location: LCCOMB_X27_Y26_N10
\inst|SPHI2~107\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~107_combout\ = (\inst|SPHI2~71_combout\ & ((\inst|SPHI2~73_combout\) # ((\inst|SPHI2~106_combout\ & \inst|SPHI2~102_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~73_combout\,
	datab => \inst|SPHI2~106_combout\,
	datac => \inst|SPHI2~71_combout\,
	datad => \inst|SPHI2~102_combout\,
	combout => \inst|SPHI2~107_combout\);

-- Location: LCCOMB_X27_Y26_N12
\inst|SPHI2~108\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~108_combout\ = (\inst|SPHI2~60_combout\) # ((\inst|SPHI2~64_combout\ & ((\inst|SPHI2~65_combout\) # (\inst|SPHI2~107_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~60_combout\,
	datab => \inst|SPHI2~65_combout\,
	datac => \inst|SPHI2~64_combout\,
	datad => \inst|SPHI2~107_combout\,
	combout => \inst|SPHI2~108_combout\);

-- Location: LCCOMB_X27_Y26_N6
\inst|SPHI2~113\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~113_combout\ = (\inst|SPHI2~57_combout\ & ((\inst|SPHI2~58_combout\) # ((\inst|SPHI2~112_combout\ & \inst|SPHI2~108_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~57_combout\,
	datab => \inst|SPHI2~58_combout\,
	datac => \inst|SPHI2~112_combout\,
	datad => \inst|SPHI2~108_combout\,
	combout => \inst|SPHI2~113_combout\);

-- Location: LCCOMB_X27_Y26_N24
\inst|SPHI2~115\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~115_combout\ = (\inst|SPHI2~48_combout\) # ((\inst|SPHI2~51_combout\ & ((\inst|SPHI2~114_combout\) # (\inst|SPHI2~113_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~48_combout\,
	datab => \inst|SPHI2~114_combout\,
	datac => \inst|SPHI2~51_combout\,
	datad => \inst|SPHI2~113_combout\,
	combout => \inst|SPHI2~115_combout\);

-- Location: LCCOMB_X27_Y26_N26
\inst|SPHI2~120\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~120_combout\ = (\inst|SPHI2~41_combout\ & ((\inst|SPHI2~130_combout\) # ((\inst|SPHI2~119_combout\ & \inst|SPHI2~115_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~119_combout\,
	datab => \inst|SPHI2~130_combout\,
	datac => \inst|SPHI2~41_combout\,
	datad => \inst|SPHI2~115_combout\,
	combout => \inst|SPHI2~120_combout\);

-- Location: LCCOMB_X27_Y26_N2
\inst|SPHI2~134\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~134_combout\ = (\inst|SPHI2~35_combout\ & ((\inst|SPHI2~133_combout\) # ((\inst|SPHI2~120_combout\)))) # (!\inst|SPHI2~35_combout\ & (\inst|SPHI2~133_combout\ & ((\inst|SPHI1~136_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~35_combout\,
	datab => \inst|SPHI2~133_combout\,
	datac => \inst|SPHI2~120_combout\,
	datad => \inst|SPHI1~136_combout\,
	combout => \inst|SPHI2~134_combout\);

-- Location: LCCOMB_X27_Y26_N16
\inst|SPHI2~125\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~125_combout\ = (\inst|SPHI2~136_combout\ & ((\inst|SPHI2~30_combout\) # ((\inst|SPHI2~124_combout\ & \inst|SPHI2~134_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~30_combout\,
	datab => \inst|SPHI2~136_combout\,
	datac => \inst|SPHI2~124_combout\,
	datad => \inst|SPHI2~134_combout\,
	combout => \inst|SPHI2~125_combout\);

-- Location: LCCOMB_X27_Y26_N0
\inst|SPHI2~127\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|SPHI2~127_combout\ = (\inst|SPHI2~25_combout\) # ((\inst|SPHI2~26_combout\ & ((\inst|SPHI2~126_combout\) # (\inst|SPHI2~125_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|SPHI2~126_combout\,
	datab => \inst|SPHI2~26_combout\,
	datac => \inst|SPHI2~25_combout\,
	datad => \inst|SPHI2~125_combout\,
	combout => \inst|SPHI2~127_combout\);

-- Location: FF_X27_Y26_N1
\inst|SPHI2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|SPHI2~127_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|SPHI2~q\);

-- Location: LCCOMB_X24_Y29_N20
\inst|RESET~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RESET~2_combout\ = (!\inst|stage\(0) & (((!\inst|Equal199~0_combout\) # (!\inst|counter\(8))) # (!\inst|counter\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(6),
	datab => \inst|stage\(0),
	datac => \inst|counter\(8),
	datad => \inst|Equal199~0_combout\,
	combout => \inst|RESET~2_combout\);

-- Location: LCCOMB_X23_Y26_N22
\inst|RESET~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RESET~0_combout\ = (\inst|counter\(7) & (\inst|Equal4~4_combout\ & (\inst|Equal6~1_combout\ & \inst|Equal229~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(7),
	datab => \inst|Equal4~4_combout\,
	datac => \inst|Equal6~1_combout\,
	datad => \inst|Equal229~0_combout\,
	combout => \inst|RESET~0_combout\);

-- Location: LCCOMB_X23_Y30_N0
\inst|Equal5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal5~0_combout\ = (!\inst|counter\(8) & (!\inst|counter\(6) & (!\inst|counter\(7) & \inst|counter\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(8),
	datab => \inst|counter\(6),
	datac => \inst|counter\(7),
	datad => \inst|counter\(4),
	combout => \inst|Equal5~0_combout\);

-- Location: LCCOMB_X23_Y30_N30
\inst|Equal5~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal5~1_combout\ = (\inst|counter\(5)) # (((\inst|counter\(0)) # (!\inst|Equal5~0_combout\)) # (!\inst|Equal2~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|Equal2~1_combout\,
	datac => \inst|counter\(0),
	datad => \inst|Equal5~0_combout\,
	combout => \inst|Equal5~1_combout\);

-- Location: LCCOMB_X23_Y29_N14
\inst|RESET~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RESET~1_combout\ = (\inst|RESET~0_combout\) # ((\inst|Equal5~1_combout\ & ((\inst|RESET~q\) # (!\inst|Equal1~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal1~1_combout\,
	datab => \inst|RESET~0_combout\,
	datac => \inst|Equal5~1_combout\,
	datad => \inst|RESET~q\,
	combout => \inst|RESET~1_combout\);

-- Location: LCCOMB_X23_Y29_N12
\inst|RESET~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RESET~3_combout\ = (\inst|RESET~2_combout\ & ((\inst|RESET~1_combout\) # ((\inst|RESET~q\ & \inst|RBI~0_combout\)))) # (!\inst|RESET~2_combout\ & (((\inst|RESET~q\ & \inst|RBI~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|RESET~2_combout\,
	datab => \inst|RESET~1_combout\,
	datac => \inst|RESET~q\,
	datad => \inst|RBI~0_combout\,
	combout => \inst|RESET~3_combout\);

-- Location: FF_X23_Y29_N13
\inst|RESET\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|RESET~3_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|RESET~q\);

-- Location: LCCOMB_X29_Y29_N16
\inst|LE~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|LE~1_combout\ = (\inst|counter\(5) & (\inst|SPHI2~21_combout\ & (\inst|Equal3~4_combout\ & !\inst|counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(5),
	datab => \inst|SPHI2~21_combout\,
	datac => \inst|Equal3~4_combout\,
	datad => \inst|counter\(2),
	combout => \inst|LE~1_combout\);

-- Location: LCCOMB_X23_Y29_N0
\inst|LE~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|LE~0_combout\ = (\inst|LE~q\ & (((!\inst|counter\(2))) # (!\inst|SPHI1~82_combout\))) # (!\inst|LE~q\ & (!\inst|Equal1~1_combout\ & ((!\inst|counter\(2)) # (!\inst|SPHI1~82_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LE~q\,
	datab => \inst|SPHI1~82_combout\,
	datac => \inst|counter\(2),
	datad => \inst|Equal1~1_combout\,
	combout => \inst|LE~0_combout\);

-- Location: LCCOMB_X23_Y29_N10
\inst|LE~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|LE~2_combout\ = (\inst|LE~0_combout\) # ((\inst|LE~1_combout\ & (!\inst|counter\(1) & \inst|Equal430~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|LE~1_combout\,
	datab => \inst|counter\(1),
	datac => \inst|Equal430~0_combout\,
	datad => \inst|LE~0_combout\,
	combout => \inst|LE~2_combout\);

-- Location: FF_X23_Y29_N11
\inst|LE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|LE~2_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|LE~q\);

-- Location: LCCOMB_X23_Y29_N6
\inst|Equal431~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal431~2_combout\ = ((\inst|counter\(6)) # ((!\inst|counter\(0)) # (!\inst|counter\(5)))) # (!\inst|Equal435~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal435~1_combout\,
	datab => \inst|counter\(6),
	datac => \inst|counter\(5),
	datad => \inst|counter\(0),
	combout => \inst|Equal431~2_combout\);

-- Location: LCCOMB_X23_Y29_N24
\inst|RPHI2~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI2~1_combout\ = (!\inst|Equal1~0_combout\ & (!\inst|RPHI2~q\ & (!\inst|counter\(2) & \inst|Equal3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal1~0_combout\,
	datab => \inst|RPHI2~q\,
	datac => \inst|counter\(2),
	datad => \inst|Equal3~1_combout\,
	combout => \inst|RPHI2~1_combout\);

-- Location: LCCOMB_X23_Y29_N2
\inst|RPHI2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI2~0_combout\ = (\inst|RPHI2~q\ & ((\inst|stage\(0) & ((\inst|Equal5~1_combout\))) # (!\inst|stage\(0) & (\inst|Equal431~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal431~2_combout\,
	datab => \inst|stage\(0),
	datac => \inst|Equal5~1_combout\,
	datad => \inst|RPHI2~q\,
	combout => \inst|RPHI2~0_combout\);

-- Location: LCCOMB_X23_Y29_N20
\inst|RPHI2~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI2~2_combout\ = (\inst|RPHI2~0_combout\) # ((\inst|RPHI2~1_combout\ & ((\inst|Equal431~2_combout\) # (\inst|stage\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal431~2_combout\,
	datab => \inst|RPHI2~1_combout\,
	datac => \inst|stage\(0),
	datad => \inst|RPHI2~0_combout\,
	combout => \inst|RPHI2~2_combout\);

-- Location: FF_X23_Y29_N21
\inst|RPHI2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|RPHI2~2_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|RPHI2~q\);

-- Location: LCCOMB_X25_Y29_N24
\inst|RPHI1~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI1~1_combout\ = (\inst|Equal29~1_combout\ & !\inst|counter\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal29~1_combout\,
	datac => \inst|counter\(5),
	combout => \inst|RPHI1~1_combout\);

-- Location: LCCOMB_X23_Y29_N26
\inst|RPHI1~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI1~2_combout\ = (\inst|Equal1~1_combout\ & ((\inst|RPHI1~q\) # ((\inst|RPHI1~1_combout\ & \inst|Equal7~4_combout\)))) # (!\inst|Equal1~1_combout\ & (\inst|RPHI1~1_combout\ & ((\inst|Equal7~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal1~1_combout\,
	datab => \inst|RPHI1~1_combout\,
	datac => \inst|RPHI1~q\,
	datad => \inst|Equal7~4_combout\,
	combout => \inst|RPHI1~2_combout\);

-- Location: LCCOMB_X25_Y29_N2
\inst|Equal430~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal430~1_combout\ = (\inst|counter\(2) & (\inst|Equal123~0_combout\ & (!\inst|counter\(0) & \inst|Equal430~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(2),
	datab => \inst|Equal123~0_combout\,
	datac => \inst|counter\(0),
	datad => \inst|Equal430~0_combout\,
	combout => \inst|Equal430~1_combout\);

-- Location: LCCOMB_X24_Y29_N18
\inst|Equal433~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal433~0_combout\ = (((!\inst|Equal430~1_combout\) # (!\inst|Equal392~0_combout\)) # (!\inst|counter\(8))) # (!\inst|counter\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(1),
	datab => \inst|counter\(8),
	datac => \inst|Equal392~0_combout\,
	datad => \inst|Equal430~1_combout\,
	combout => \inst|Equal433~0_combout\);

-- Location: LCCOMB_X23_Y29_N8
\inst|RPHI1~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI1~3_combout\ = ((\inst|Equal431~2_combout\ & ((\inst|RPHI1~q\) # (!\inst|Equal1~1_combout\)))) # (!\inst|Equal433~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001110111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal431~2_combout\,
	datab => \inst|Equal433~0_combout\,
	datac => \inst|RPHI1~q\,
	datad => \inst|Equal1~1_combout\,
	combout => \inst|RPHI1~3_combout\);

-- Location: LCCOMB_X24_Y29_N10
\inst|Equal434~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal434~5_combout\ = ((\inst|counter\(2)) # ((\inst|counter\(4)) # (!\inst|Equal397~1_combout\))) # (!\inst|Equal434~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal434~4_combout\,
	datab => \inst|counter\(2),
	datac => \inst|counter\(4),
	datad => \inst|Equal397~1_combout\,
	combout => \inst|Equal434~5_combout\);

-- Location: LCCOMB_X24_Y29_N4
\inst|RPHI1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI1~0_combout\ = (\inst|stage\(0) & (((\inst|Equal440~0_combout\)))) # (!\inst|stage\(0) & ((\inst|Equal434~5_combout\) # ((!\inst|Equal430~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal434~5_combout\,
	datab => \inst|stage\(0),
	datac => \inst|Equal440~0_combout\,
	datad => \inst|Equal430~0_combout\,
	combout => \inst|RPHI1~0_combout\);

-- Location: LCCOMB_X23_Y29_N22
\inst|RPHI1~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RPHI1~4_combout\ = (\inst|RPHI1~0_combout\ & ((\inst|stage\(0) & (\inst|RPHI1~2_combout\)) # (!\inst|stage\(0) & ((\inst|RPHI1~3_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|RPHI1~2_combout\,
	datab => \inst|RPHI1~3_combout\,
	datac => \inst|stage\(0),
	datad => \inst|RPHI1~0_combout\,
	combout => \inst|RPHI1~4_combout\);

-- Location: FF_X23_Y29_N23
\inst|RPHI1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|RPHI1~4_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|RPHI1~q\);

-- Location: LCCOMB_X23_Y29_N16
\inst|RBI~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RBI~2_combout\ = (!\inst|stage\(0) & (((\inst|counter\(0)) # (!\inst|Equal175~0_combout\)) # (!\inst|Equal435~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal435~1_combout\,
	datab => \inst|Equal175~0_combout\,
	datac => \inst|stage\(0),
	datad => \inst|counter\(0),
	combout => \inst|RBI~2_combout\);

-- Location: LCCOMB_X24_Y29_N16
\inst|Equal430~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|Equal430~2_combout\ = (!\inst|counter\(3) & (\inst|Equal3~2_combout\ & (!\inst|counter\(1) & \inst|Equal430~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|counter\(3),
	datab => \inst|Equal3~2_combout\,
	datac => \inst|counter\(1),
	datad => \inst|Equal430~1_combout\,
	combout => \inst|Equal430~2_combout\);

-- Location: LCCOMB_X23_Y29_N18
\inst|RBI~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RBI~1_combout\ = ((!\inst|Equal430~2_combout\ & ((\inst|RBI~q\) # (!\inst|Equal1~1_combout\)))) # (!\inst|Equal433~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|Equal1~1_combout\,
	datab => \inst|RBI~q\,
	datac => \inst|Equal430~2_combout\,
	datad => \inst|Equal433~0_combout\,
	combout => \inst|RBI~1_combout\);

-- Location: LCCOMB_X23_Y29_N28
\inst|RBI~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|RBI~3_combout\ = (\inst|RBI~0_combout\ & ((\inst|RBI~q\) # ((\inst|RBI~2_combout\ & \inst|RBI~1_combout\)))) # (!\inst|RBI~0_combout\ & (\inst|RBI~2_combout\ & ((\inst|RBI~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|RBI~0_combout\,
	datab => \inst|RBI~2_combout\,
	datac => \inst|RBI~q\,
	datad => \inst|RBI~1_combout\,
	combout => \inst|RBI~3_combout\);

-- Location: FF_X23_Y29_N29
\inst|RBI\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst2|LPM_COUNTER_component|auto_generated|counter_reg_bit[6]~clkctrl_outclk\,
	d => \inst|RBI~3_combout\,
	ena => \reset_gen~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|RBI~q\);

ww_SEB <= \SEB~output_o\;

ww_IS1 <= \IS1~output_o\;

ww_IS2 <= \IS2~output_o\;

ww_SR <= \SR~output_o\;

ww_CS <= \CS~output_o\;

ww_gnd1 <= \gnd1~output_o\;

ww_gnd2 <= \gnd2~output_o\;

ww_CAL <= \CAL~output_o\;

ww_SBI <= \SBI~output_o\;

ww_SPHI1 <= \SPHI1~output_o\;

ww_SPHI2 <= \SPHI2~output_o\;

ww_RESET <= \RESET~output_o\;

ww_R12 <= \R12~output_o\;

ww_LE <= \LE~output_o\;

ww_RPHI2 <= \RPHI2~output_o\;

ww_RPHI1 <= \RPHI1~output_o\;

ww_RBI <= \RBI~output_o\;

ww_reset_gen_out <= \reset_gen_out~output_o\;
END structure;


