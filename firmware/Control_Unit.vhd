library ieee;
use ieee.std_logic_1164.all;

-- Control Unit for CSCE 230 Project
-- Spring 2012
--
-- Basic idea: set signals based on each stage of instruction execution
--             stage 1 initializes every control signal
--             subsequent stages only change contol signals as needed

entity Control_Unit is
	port (
	      -- Input clock/reset
	      clock: in std_logic;
			reset: in std_logic;
			
	      -- Input from memory block
	      mem_data: in std_logic_vector(15 downto 0);
	      nbusy, data_valid, osc: in std_logic;
			
			-- Memory Control Signals
	      mem_addr: out std_logic_vector(11 downto 0);
			nread: out std_logic;
			
			-- Channel Control Signals
			channel_select: out std_logic_vector(15 downto 0);
			pattern_select: out std_logic_vector(1 downto 0);
			channel_data: out std_logic_vector(31 downto 0);
			sel_patN: out std_logic;
			en: out std_logic;
			ld: out std_logic;
			wr: out std_logic
			);
		  
end Control_Unit;


architecture Control_Unit_arch of Control_Unit is
	
	shared variable stage: integer:= 0;
	-- Stage 0: init outputs
	-- Stage 1: read sel into channels
	-- Stage 2: read pattern into channels
	-- Stage 4: load data into shift registers
	-- Stage 5: enable output/choose pattern
	
	shared variable patternN: integer := 0;
	shared variable channelN: integer := 0;
	
	shared variable read_stage: integer := 0;
	-- Read Stage 0: issue read of high bits
	-- Read Stage 1: read high bits 
	-- Read Stage 2: issue read of low bits
   -- Read Stage 3: read low bits
	-- Read Stage 4: put data on port
	-- Read Stage 5: push data out port
	-- Read Stage 6: end read
	
	shared variable data_buffer: std_logic_vector(31 downto 0);
	
begin
	
	process (clock, reset)
	begin
	
	-- only work on positive clock
	if(rising_edge(clock)) then

		if(stage = 0) then
			wr <= '0';
			ld <= '0';
			en <= '0';
			nread <= '1';
			stage := 1;
		elsif(stage = 1) then
			if(nbusy = '1') then
				case read_stage is
					when 0 => mem_addr <= X"000";
								 nread <= '0';
					when 1 => nread <= '1';
					          data_buffer(31 downto 16) := mem_data(15 downto 0);
					when 2 => mem_addr <= X"004";
					          nread <= '0';
					when 3 => nread <= '1';
					          data_buffer(15 downto 0) := mem_data(15 downto 0);
					when 4 => channel_data <= data_buffer;
					          sel_patN <= '1';
								 channel_select <= X"FFFF";
					when 5 => wr <= '1';
					when 6 => wr <= '0';
					when others => null;
				end case;
				read_stage := read_stage + 1;
			end if; -- busy
		elsif(stage = 2) then
		
		elsif(stage = 3) then
		
		elsif(stage = 4) then
		
		elsif(stage = 5) then
		
		end if; -- stage
	
	
		stage := stage + 1;
	
	end if; -- clock cycle
	end process;
end Control_Unit_arch;