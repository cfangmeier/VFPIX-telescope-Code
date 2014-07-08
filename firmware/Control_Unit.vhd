library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Control Unit for MAXV chip on VFPIX Telescope
-- Summer 2014
--
-- Basic idea: Read data from onboard memory and write that data
--             to the pattern buffers for each channel. 

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
			wr: out std_logic
			);
		  
end Control_Unit;


architecture Control_Unit_arch of Control_Unit is
	
	shared variable stage: integer := 0;
	-- Stage 0: init outputs
	-- Stage 1: read sel into channels
	-- Stage 2: read pattern into channels
	-- Stage 3: enable output/choose pattern
	-- Stage 4: loop
	
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
	
	shared variable load_stage: integer := 0;
	
begin

	process (clock, reset)
	begin
	
	-- only work on positive clock
	if(rising_edge(clock)) then

		if(stage = 0) then
			wr <= '0';
			en <= '0';
			nread <= '1';
			stage := 1;
		elsif(stage = 1) then
			if(nbusy = '1') then
				case read_stage is
					when 0 => mem_addr <= X"000";
								 nread <= '0';
								 read_stage := 1;
					when 1 => nread <= '1';
					          data_buffer(31 downto 16) := mem_data(15 downto 0);
								 read_stage := 2;
					when 2 => mem_addr <= X"001";
					          nread <= '0';
								 read_stage := 3;
					when 3 => nread <= '1';
					          data_buffer(15 downto 0) := mem_data(15 downto 0);
								 read_stage := 4;
					when 4 => channel_data <= data_buffer;
					          sel_patN <= '1';
								 channel_select <= X"FFFF";
								 read_stage := 5;
					when 5 => wr <= '1';
								 read_stage := 6;
					when 6 => wr <= '0';
								 read_stage := 0;
								 stage := 2;
					when others => null;
				end case;
			end if; -- busy
		elsif(stage = 2) then
		  if(nbusy = '1') then
		  		case read_stage is
				
					when 0 => mem_addr <= std_logic_vector(to_unsigned(2+channelN*8+patternN*2, mem_addr'length));
								 nread <= '0';
								 read_stage := 1;
					when 1 => nread <= '1';
					          data_buffer(31 downto 16) := mem_data(15 downto 0);
								 read_stage := 2;
					when 2 => mem_addr <= std_logic_vector(to_unsigned(2+channelN*8+patternN*2+1, mem_addr'length));
					          nread <= '0';
								 read_stage := 3;
					when 3 => nread <= '1';
					          data_buffer(15 downto 0) := mem_data(15 downto 0);
								 read_stage := 4;
					when 4 => channel_data <= data_buffer;
					          sel_patN <= '0';
								 channel_select <= std_logic_vector(shift_left(to_unsigned(1,channel_select'LENGTH),channelN));
								 pattern_select <= std_logic_vector(to_unsigned(patternN, pattern_select'length));
								 read_stage := 5;
					when 5 => wr <= '1';
								 read_stage := 6;
					when 6 => wr <= '0';
					          if(patternN = 3 and channelN = 15) then
									  stage := 3;
								 elsif(patternN = 3) then
									  patternN := 0;
									  channelN := channelN + 1;
								 else
									  patternN := patternN + 1;
								 end if; --patternN is 3
								 read_stage := 0;
					when others => null;
				end case;
		  end if; --busy
		elsif(stage = 3) then
			pattern_select <= "00";
			en <= '1';
			stage := 4;
		elsif(stage = 4) then
--			-- do nothing.
		end if; -- stage
	
	end if; -- clock cycle
	end process;
end Control_Unit_arch;