library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY step_curve IS
	PORT(
		clk: IN std_logic;
		
		LE   : OUT std_logic;
		RBI  : OUT std_logic;
		RP1  : OUT std_logic;
		RP2  : OUT std_logic;
		SEB   : OUT std_logic;
		SBI  : OUT std_logic;
		SP1  : OUT std_logic;
		SP2  : OUT std_logic;
		CAL  : OUT std_logic;
		IS1  : OUT std_logic;
		IS2  : OUT std_logic;
		SR   : OUT std_logic;
		CS   : OUT std_logic;
		RES  : OUT std_logic;
		R12  : OUT std_logic
	);
END step_curve;

ARCHITECTURE step_curve_arch OF step_curve IS
SIGNAL alternator: std_logic := '1';
SIGNAL channel_counter: integer := 0;
BEGIN
	PROCESS (clk)
	BEGIN
		IF(rising_edge(clk)) THEN
		
			LE   <= '1';
			SEB   <= '1';
			SBI  <= '0';
			SP1  <= '0';
			SP2  <= '0';
			IS1  <= '1';
			IS2  <= '0';
			SR   <= '1';
			CS   <= '0'; -- Can change!
			RES  <= '0';
			R12  <= '0'; -- Can change!
			
			IF(channel_counter < 64) THEN
				CAL  <= '1';
			ELSE
				CAL <= '0';
			END IF;
		
			IF(channel_counter = 0) THEN
				RBI <= '1';
			ELSE
				RBI <= '0';
			END IF;
			
			RP1 <= alternator;
			RP2 <= NOT alternator;
		
			IF(alternator ='0') THEN
				channel_counter <= (channel_counter + 1) MOD 128;
			END IF;
			
			alternator <= NOT alternator;
		END IF; -- clk
	END PROCESS;
END step_curve_arch;