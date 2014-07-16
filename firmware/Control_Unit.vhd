library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Control Unit for MAXV chip on VFPIX Telescope
-- Summer 2014
--
-- Basic idea: Read data from onboard memory and write that data
--             to the pattern buffers for each channel. 

ENTITY Control_Unit IS
	PORT (
	      -- Input clock/reset
	      clk: IN std_logic;
			
			-- Command input
			pattern_select: IN std_logic_vector(3 DOWNTO 0);
			
			-- Output channels
			LE   : OUT std_logic;
			RBI  : OUT std_logic;
			RP1  : OUT std_logic;
			RP2  : OUT std_logic;
			SE   : OUT std_logic;
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
		  
END Control_Unit;


ARCHITECTURE Control_Unit_arch OF Control_Unit IS
	
	SIGNAL first_clk: bit := '1';
	SIGNAL out_select: std_logic_vector(3 DOWNTO 0) := "0000";
	
BEGIN

	PROCESS (clk, res)
	BEGIN
	
	-- only work on positive clock
	IF(rising_edge(clk)) THEN

		IF(first_clk = '0') THEN
			first_clk <= '1';
			-- Set appropriate out_select here
			out_select <= pattern_select;
		ELSE
			first_clk <= '0';
		END IF;
	
		CASE out_select IS
			WHEN "0000" => -- Reset
				IF(first_clk = '1') THEN
					LE   <= '0';
					RBI  <= '0';
					RP1  <= '1';
					RP2  <= '0';
					SE   <= '1';
					SBI  <= '0';
					SP1  <= '1';
					SP2  <= '0';
					CAL  <= '0';
					IS1  <= '0';
					IS2  <= '0';
					SR   <= '0';
					CS   <= '0';
					RES  <= '1';
					R12  <= '0';
				ELSE
					LE   <= '0';
					RBI  <= '0';
					RP1  <= '0';
					RP2  <= '1';
					SE   <= '1';
					SBI  <= '0';
					SP1  <= '0';
					SP2  <= '1';
					CAL  <= '0';
					IS1  <= '0';
					IS2  <= '0';
					SR   <= '0';
					CS   <= '0';
					RES  <= '1';
					R12  <= '0';
				END IF; -- 0000
			WHEN "0001" => -- Take Data - Stage 1
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN "0010" => -- Take Data - Stage 2
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN "0011" => -- Calibration - Stage 1
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN "0100" => -- Calibration - Stage 2
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN "0101" => -- Readout - Stage 1a
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN "0110" => -- Readout - Stage 1b
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN "0111" => -- Readout - Stage 2a
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN "1000" => -- Readout - Stage 2b
				IF(first_clk = '1') THEN
				
				ELSE
				
				END IF; -- 0000
			WHEN OTHERS => 
		END CASE;
	END IF; -- clock cycle
	END PROCESS;
END Control_Unit_arch;