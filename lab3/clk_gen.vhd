library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
	port
	(
		sys_clk         : in std_logic;
		half_period     : in time;
		onehz_clk_flag  : out std_logic
	);
end clk_gen;

architecture a of clk_gen is 
	
		signal count		: integer   := 1;
		signal tmp 			: std_logic := '0';
	
		begin
		process (sys_clk) is
		begin
			if (sys_clk'event and sys_clk='1') then
				count <=count+1;
			end if;
			if (count = 25000000) then
				tmp <= NOT tmp;
				count <= 1;
			end if;
			onehz_clk_flag <= tmp;
			end process;
end a;