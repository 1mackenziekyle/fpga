library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity latch_4bit is
   port
   (
      enable			: in STD_LOGIC;
		data    			: in STD_LOGIC_VECTOR(3 DOWNTO 0);
      q              : out STD_LOGIC_VECTOR(3 DOWNTO 0)
   );
end latch_4bit;
architecture a of latch_4bit is
begin
latch : process (enable, data)
      begin
         if (enable = '0') then
            q <= data;
         end if;
      end process latch;
END a;