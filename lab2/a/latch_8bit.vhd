library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity latch_8bit is
   port
   (
      enable			: in STD_LOGIC;
		data    			: in STD_LOGIC_VECTOR(7 DOWNTO 0);
      q             : out STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
end latch_8bit;
architecture a of latch_8bit is
begin
latch : process (enable, data)
      begin
         if (enable = '0') then
            q <= data;
         end if;
      end process latch;
END a;