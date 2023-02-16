library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity vec_to_nibs is
   port
   (
      
		data    	  : in STD_LOGIC_VECTOR(7 DOWNTO 0);
      l          : out STD_LOGIC_VECTOR(3 DOWNTO 0);
		r          : out STD_LOGIC_VECTOR(3 DOWNTO 0)
   );
end vec_to_nibs;

architecture a of vec_to_nibs is

begin

split : process (data)
	begin
      l <= data(7 downto 4);
		r <= data(3 downto 0);
     end process split;
end a;