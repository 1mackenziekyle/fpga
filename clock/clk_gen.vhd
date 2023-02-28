library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
	port
	(
		sys_clk         : in std_logic;
		run_time			 : in std_logic;
		onehz_clk_flag  : out std_logic
	);
end clk_gen;

architecture a of clk_gen is 
	
		signal count		: integer   := 1;
		signal tmp 			: std_logic := '0';
	
		begin
		process (sys_clk, run_time) is -- debug: remove clock from depend list
		begin
			if (sys_clk'event and sys_clk='1' and run_time='1') then
				count <=count+1;
			end if;
			if (count > 2500000 and run_time='1') then
				tmp <= NOT tmp;
				count <= 1;
			end if;
			onehz_clk_flag <= tmp;
		end process;
end a;