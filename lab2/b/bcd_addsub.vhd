library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_addsub is
    port(
        a,b      : in   std_logic_vector(3 downto 0);
        sub      : in   std_logic; -- 1 to subtract
        carry_in : in   std_logic;
        sum      : out  std_logic_vector(3 downto 0); 
        carry    : out  std_logic  
    );
end bcd_addsub;

architecture a of bcd_addsub is
	signal sum_temp : std_logic_vector(4 downto 0);
	signal sum_temp_adjs : std_logic_vector(4 downto 0);
	signal sum_l : std_logic_vector(4 downto 0);

begin

	process(b, sub) is
	begin
		-- If subtracting, get 9's complement
		if sub = '1' then
			case b is
				when "0000" => sum_l<="01001";
				when "0001" => sum_l<="01000";
				when "0010" => sum_l<="00111";
				when "0011" => sum_l<="00110";
				when "0100" => sum_l<="00101";
				when "0101" => sum_l<="00100";
				when "0110" => sum_l<="00011";
				when "0111" => sum_l<="00010";
				when "1000" => sum_l<="00001";
				when "1001" => sum_l<="00000";
				when others => sum_l<="00000";
			end case;

		else
			sum_l<=('0' & b);
		end if;
	end process;

	process(a, sum_l, sum_temp, carry_in, sum_temp_adjs)
	begin
	    sum_temp <= ('0' & a) + sum_l + ("0000" & carry_in); -- Sum a and b
		 sum_temp_adjs <= sum_temp + "00110"; -- add 6 to convert bin to bcd
	    if(sum_temp > 9) then -- carry bit
	        carry <= '1'; 
	        sum <= sum_temp_adjs(3 downto 0);
	    else
	        carry <= '0';
	        sum <= sum_temp(3 downto 0);
	    end if; 
	end process;   

end a;