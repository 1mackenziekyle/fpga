library ieee;
use IEEE.STD_LOGIC_1164.all;



entity bcdto7seg is
	port
	(
		-- Input ports
		bcd		: in STD_LOGIC_VECTOR (3 downto 0);
		-- Output ports
		display	: out STD_LOGIC_VECTOR (0 to 6)
	);
end bcdto7seg;



architecture a of bcdto7seg is 
	-- Declarations (optional)
	signal bcd_in 			: STD_LOGIC_VECTOR (3 downto 0);
	signal display_out 	: STD_LOGIC_VECTOR (0 to 6);
	
	--===================================================
	--============ Function Definition ==================
	--===================================================
	function reverse_any_vector (a: in std_logic_vector)
	return std_logic_vector is
	  variable result: std_logic_vector(a'RANGE);
	  alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
	begin
	  for i in aa'RANGE loop
		 result(i) := aa(i);
	  end loop;
	  return result;
	end; -- function reverse_any_vector
	
	
begin
			bcd_in 	<= bcd;
			display 	<= display_out;
		
		process( bcd_in) is
		-- Declaration(s)
		begin
		-- Sequential Statement(s)
		case bcd_in is
			when "0000" =>
				display_out <= reverse_any_vector("0000001");
			when "0001" =>
				display_out <= reverse_any_vector("1001111");
			when "0010" =>
				display_out <= reverse_any_vector("0010010");
			when "0011" =>
				display_out <= reverse_any_vector("0000110");
			when "0100" =>
				display_out <= reverse_any_vector("1001100");
			when "0101" =>
				display_out <= reverse_any_vector("0100100");
			when "0110" =>
				display_out <= reverse_any_vector("0100000");
			when "0111" =>
				display_out <= reverse_any_vector("0001111");
			when "1000" =>
				display_out <= reverse_any_vector("0000000");
			when "1001" =>
				display_out <= reverse_any_vector("0000100");
			when others =>
				display_out <= reverse_any_vector("1111111");
		end case;
	end process;
end a;