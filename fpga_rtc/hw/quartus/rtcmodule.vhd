library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rtc is
	port(
		clk        : IN  std_logic;
		nReset     : IN  std_logic;
		Address    : IN  std_logic_vector(2 downto 0);
		ChipSelect : IN  std_logic;
		Read       : IN  std_logic;
		Write      : IN  std_logic;
		ReadData   : OUT std_logic_vector(7 DOWNTO 0);
		WriteData  : IN  std_logic_vector(7 DOWNTO 0);
		SelSeg     : out std_logic_vector(7 downto 0);
		Reset_Led  : out std_logic;
		nSelDig    : out std_logic_vector(5 downto 0);
		SwLed      : in  std_logic_vector(7 downto 0);
		nButton    : in  std_logic_vector(3 downto 0);
		LedButton  : out std_logic_vector(3 downto 0)
	);
end rtc;

architecture comp of rtc is
	signal hundreds : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- in BCD format
	signal seconds  : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- in BCD format
	signal minutes  : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- in BCD format

	signal enable_1khz  : std_logic;
	signal enable_100hz : std_logic;

	
	-- bcd incrementer function
	function increment_bcd(bcd_number : std_logic_vector(7 downto 0)) return std_logic_vector is
		variable first_digit  : unsigned(3 downto 0);
		variable second_digit : unsigned(3 downto 0);

	begin
		first_digit  := unsigned(bcd_number(7 downto 4));
		second_digit := unsigned(bcd_number(3 downto 0)) + 1;
		if second_digit >= 10 then
			first_digit  := first_digit + 1;
			second_digit := (others => '0');
		end if;
		return std_logic_vector(first_digit & second_digit);

	end function increment_bcd;

begin

	-- slow clock logic
	process(clk)
		variable count_1khz  : natural;
		variable count_100hz : natural;
	begin
		if rising_edge(clk) then
			enable_1khz <= '0';         -- TODO  change name of clock
			count_1khz  := count_1khz + 1;
			if count_1khz = 5000 then   -- assuming 50 Mhz FPGA so should be 150150, but for testing purposes faster clock!
				enable_1khz <= '1';
				count_1khz  := 0;
			end if;

			enable_100hz <= '0';
			count_100hz  := count_100hz + 1;
			if count_100hz = 500000 then -- assuming 50 Mhz FPGA so should be 500000, but for testing purposes faster clock!
				enable_100hz <= '1';
				count_100hz  := 0;
			end if;
		end if;
	end process;

	
	
	--		-- read	 
	pTimeRd : process(Clk)
	begin
		if rising_edge(Clk) then
			ReadData <= (others => '0');
			if ChipSelect = '1' and Read = '1' then
				case Address(2 downto 0) is
					when "001"  => ReadData <= hundreds;
					when "010"  => ReadData <= seconds;
					when "011"  => ReadData <= minutes;
					when others => null;
				end case;
			end if;
		end if;
	end process pTimeRd;

	
	
	-- time updater logic + write
	update_rtc : process(clk, enable_100hz, nReset)
	begin
		if nReset = '0' then
			hundreds <= (others => '0'); --   Input by default
			seconds  <= (others => '0'); --   Input by default
			minutes  <= (others => '0'); --   Input by default


		elsif rising_edge(clk) then
			if ChipSelect = '1' and Write = '1' then --   Write cycle
				case Address(2 downto 0) is
					when "001"  => hundreds <= WriteData;
					when "010"  => seconds <= WriteData;
					when "011"  => minutes <= WriteData;
					when others => null;
				end case;

			else
			
				if enable_100hz = '1' then
					hundreds <= increment_bcd(hundreds);
				end if;
				
				if minutes = "10011001" and seconds = "01011001" and hundreds = "10011001" then -- 59, 59 and 99 in BCD
					hundreds <= (others => '0');
					seconds  <= (others => '0');
					minutes  <= (others => '0');
					
				elsif seconds = "01011001" and hundreds = "10011001" then -- 59 and 99 in BCD
					seconds <= (others => '0');
					minutes <= increment_bcd(minutes);
					
				elsif hundreds = "10011001" then -- 99 in BCD
					hundreds <= (others => '0');
					seconds  <= increment_bcd(seconds);
				end if;
				
			end if;
		end if;
	end process update_rtc;

	
	
	
	-- screen updater logic
	update_screen : process(clk, enable_1khz)
		variable count_seg      : natural; -- which segment to update next
		variable show_dot			: std_logic := '0';
		variable cycle          : natural; 
		-- cycle 0 clear all segments , cycle 1 load new segment, cycle 20 remove load from segment and go to next segment
		variable number_to_show : std_logic_vector(3 DOWNTO 0) := (others => '0');
	begin
		if rising_edge(clk) and enable_1khz = '1' then

			if cycle = 0 then
				cycle     := 1;
				
				-- clear all segments
				Reset_led <= '1';
				
				-- activate segment
				case count_seg is
					when 0      => nSelDig <= "111110";
					when 1      => nSelDig <= "111101";
					when 2      => nSelDig <= "111011";
					when 3      => nSelDig <= "110111";
					when 4      => nSelDig <= "101111";
					when 5      => nSelDig <= "011111";
					when others => nSelDig <= "111111";
				end case;

			elsif cycle = 1 then
				cycle := 2;

				-- undo reset
				Reset_led <= '0';

				-- get number to show	
				case count_seg is
					when 0      => number_to_show := hundreds(3 downto 0);
										show_dot <= '0';
					when 1      => number_to_show := hundreds(7 downto 4);
										show_dot <= '0';
					when 2      => number_to_show := seconds(3 downto 0);
										show_dot <= '1';
					when 3      => number_to_show := seconds(7 downto 4);
										show_dot <= '0';
					when 4      => number_to_show := minutes(3 downto 0);
										show_dot <= '1';
					when 5      => number_to_show := minutes(7 downto 4);
										show_dot <= '0';
					when others => number_to_show := "0000";
				end case;

				-- map number to nSelDig		
				case number_to_show is
					when "0000" => SelSeg <= show_dot & "0111111";
					when "0001" => SelSeg <= show_dot & "0000110";
					when "0010" => SelSeg <= show_dot & "1011011";
					when "0011" => SelSeg <= show_dot & "1001111";
					when "0100" => SelSeg <= show_dot & "1100110";
					when "0101" => SelSeg <= show_dot & "1101101";
					when "0110" => SelSeg <= show_dot & "1111101";
					when "0111" => SelSeg <= show_dot & "0000111";
					when "1000" => SelSeg <= show_dot & "1111111";
					when "1001" => SelSeg <= show_dot & "1101111";
					when others => SelSeg <= show_dot & "0000000"; -- MODIFIED BY LUKAS before nSelDir
				end case;

			elsif cycle >= 2 and cycle <= 19 then
				cycle := cycle + 1;

			elsif cycle = 20 then
				cycle := 0;

				-- take load from segment
				SelSeg <= "00000000";

				-- update segment counter
				count_seg := count_seg + 1;
				if count_seg = 6 then
					count_seg := 0;
				end if;
			end if;

		END IF;                         -- close rising edge if

	end process update_screen;

--		-- display_rtc
--		
--
--
--		-- below is code from parallelport
--		pPort: 
--			process (iRegDir, iRegPort)
--			begin 		
--				for i in 0 to 7 loop
--					if iRegDir(i) = '1' then
--						ParPort(i) <= iRegPort(i);
--					else
--						ParPort(i) <= 'Z';
--					end if;
--				end loop;
--			end process pPort;
--			
--			iRegPin <= ParPort;
--			
--			
--		pRegWr:
--			process(Clk, nReset)
--			begin 
--				if nReset = '0' then
--					iRegDir <= (others => '0');  --   Input by default
--					
--					
--				elsif rising_edge(Clk) then 
--					if ChipSelect= '1' and Write = '1' then  --   Write cycle
--						case Address (2 downto 0) is
--							when "000" => iRegDir <= WriteData; 
--							when "010" => iRegPort <= WriteData; 
--							when "011" => iRegPort <= iRegPort OR WriteData;
--							when "100" => iRegPort <= iRegPort AND  NOT WriteData; 
--							when others => null;
--						end case;
--					end if;
--				end if;
--			end process pRegWr;
--
--
--
--
--
--		-- read	 
--		pRegRd: 
--			process(Clk) 
--			begin
--				if rising_edge(Clk) then 
--					ReadData <= (others => '0');
--					if ChipSelect = '1' and Read = '1' then 	 	
--						case Address(2 downto 0) is 
--							when "000" => ReadData <= iRegDir ; 
--							when "001" => ReadData <= iRegPin ;
--							when "010" => ReadData <= iRegPort; 
--							when others => null; 
--						end case; 
--					end if; 
--				end if; 
--			end process pRegRd; 
end architecture comp;