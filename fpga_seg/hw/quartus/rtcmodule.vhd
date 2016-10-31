
library ieee;
use ieee.std_logic_1164.all;

entity parallelport is
    port(
		clk : IN std_logic;
		nReset : IN std_logic;
		Address : IN std_logic_vector( 2 downto 0);
		ChipSelect : IN std_logic;
		
		Read : IN std_logic;
		Write : IN std_logic;
		
		ReadData : OUT std_logic_vector( 7 DOWNTO 0);
		WriteData : IN std_logic_vector( 7 DOWNTO 0);
		

		SelSeg           : out   std_logic_vector(7 downto 0);
		Reset_Led        : out   std_logic;
		nSelDig          : out   std_logic_vector(5 downto 0); 
		SwLed            : in    std_logic_vector(7 downto 0);
		nButton          : in    std_logic_vector(3 downto 0);
		LedButton        : out   std_logic_vector(3 downto 0)

);
	end parallelport;
		
	architecture comp of parallelport is
			signal hundreds : unsigned (7 DOWNTO 0); -- 7 bits are also enough, maybe chance it later
			signal seconds : unsigned (7 DOWNTO 0);
			signal minutes : unsigned (7 DOWNTO 0);
			
			signal  enable_1khz : std_logic;
			signal  enable_100hz : std_logic;
			variable count : natural;
		begin


		-- slow clock logic
		process(clk)
			variable count : natural;
		begin
			if rising_edge(clk) then
				enable_1khz <= '0';
				count := count + 1;
				if count = 5000 then -- value to be seen, assuming 50 Mhz FPGA
					enable_1khz <= '1';
					count := 0;
				end if;
			end if;
		end process;

		-- time updater logic
		update_rtc : process(clk_100hz)
		begin
			if rising_edge(clk) and enable_100hz = '1' then
				hundreds <= hundreds + 1;

				if hundreds >= 100-1 then -- -1 because hundreds is only updated after the execution of the process!
					hundreds <= 0;
					seconds <= seconds + 1;
				end if;
				if seconds >= 60-1  then
					seconds <= 0;
					minutes <= minutes + 1;
				end if;
				if minutes >= 100-1 then
					minutes <= 0;
				end if;
			end if;
		end process update_rtc;
		
		-- screen updater logic
		update_screen : process(clk_todo) -- 
			variable seg_cnt : natural; -- which segmet to update next
		begin
			SelSeg <= std_logic_vector(2**seg_cnt); -- not sure if the power will synthesize correctly
			
			
			
			
		end process update_screen

		-- display_rtc
		


		-- below is code from parallelport
		pPort: 
			process (iRegDir, iRegPort)
			begin 		
				for i in 0 to 7 loop
					if iRegDir(i) = '1' then
						ParPort(i) <= iRegPort(i);
					else
						ParPort(i) <= 'Z';
					end if;
				end loop;
			end process pPort;
			
			iRegPin <= ParPort;
			
			
		pRegWr:
			process(Clk, nReset)
			begin 
				if nReset = '0' then
					iRegDir <= (others => '0');  --   Input by default
					
					
				elsif rising_edge(Clk) then 
					if ChipSelect= '1' and Write = '1' then  --   Write cycle
						case Address (2 downto 0) is
							when "000" => iRegDir <= WriteData; 
							when "010" => iRegPort <= WriteData; 
							when "011" => iRegPort <= iRegPort OR WriteData;
							when "100" => iRegPort <= iRegPort AND  NOT WriteData; 
							when others => null;
						end case;
					end if;
				end if;
			end process pRegWr;





		-- read	 
		pRegRd: 
			process(Clk) 
			begin
				if rising_edge(Clk) then 
					ReadData <= (others => '0');
					if ChipSelect = '1' and Read = '1' then 	 	
						case Address(2 downto 0) is 
							when "000" => ReadData <= iRegDir ; 
							when "001" => ReadData <= iRegPin ;
							when "010" => ReadData <= iRegPort; 
							when others => null; 
						end case; 
					end if; 
				end if; 
			end process pRegRd; 
end architecture comp;