library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflop is
    port (
        reset	: in std_logic;
		  enable : in std_logic;
        q 		: out std_logic
    );
end flipflop;

architecture a of flipflop is	 

		signal d			: std_logic := '0';
	
		begin
		process (enable, reset) is
		begin
			if (enable'event and enable='1') then
				d <= not d;
			end if;
			if (reset = '0') then
				d <= '0';
			end if;
			q <= d;
		end process;
end a;