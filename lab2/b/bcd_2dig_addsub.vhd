
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;




--===================================================
--=============== Top-Level Entity ==================
--===================================================
entity bcd_2dig_addsub is
    port(
        a,b      			: in   std_logic_vector(7 downto 0);
        sub      			: in   std_logic; -- 1 to subtract
        sum_l   			: out  std_logic_vector(3 downto 0); 
		sum_r   			: out  std_logic_vector(3 downto 0);
        overflow	 		: out  std_logic  
    );
end bcd_2dig_addsub;

architecture a of bcd_2dig_addsub is



	--===================================================
	--============ Define Input signals =================
	--===================================================
	signal a_r, a_l, b_r, b_l : std_logic_vector(3 downto 0); -- Break inputs into 4-bit chunks
	signal carry : std_logic; --  carries
	signal carry_out : std_logic;
	signal sum_l_temp : std_logic_vector(3 downto 0);
	signal sum_r_temp : std_logic_vector(3 downto 0);
	signal sum_l_comp : std_logic_vector(3 downto 0);
	signal sum_r_comp : std_logic_vector(3 downto 0);
	
	
	
	
	
	--===================================================
	--============== Experimental Mode ==================
	--===================================================
	signal experimental_mode : std_logic := '0';









	--===================================================
	--============== Component Interfaces ===============
	--===================================================

	--============= Interface for 4-bit adder/subtractor ===========
	component bcd_addsub is
		port(
			a,b      			: in   std_logic_vector(3 downto 0);
			sub      			: in   std_logic; -- 1 to subtract
			carry_in 			: in   std_logic;
			sum      			: out  std_logic_vector(3 downto 0); 
			carry    			: out  std_logic  
		);
	end component;



begin





	--===================================================
	--=================== Set signals ===================
	--===================================================


	a_l <= a(3 downto 0);
	a_r <= a(7 downto 4);
	b_l <= b(3 downto 0);
	b_r <= b(7 downto 4);






	--===================================================
	--========== Instantiate components =================
	--===================================================

	-- Sum least significant digit
	addsub_r : bcd_addsub port map(
		a          => a_r,
		b          => b_r,
		sub        => sub,
		carry_in   => sub,
		sum        => sum_r_temp,
		carry      => carry
	);



	addsub_l : bcd_addsub port map(
	-- Sum most significant digit
		a          => a_l,
		b          => b_l,
		sub        => sub,
		carry_in   => carry,
		sum        => sum_l_temp,
		carry => carry_out
	);
	
	
	--===================================================
	--=================== Set out_is_neg ================
	--===================================================
	

	overflow <= carry_out xor sub; -- invert if subtracting

	
	
	process(sub, sum_l_temp, sum_r_temp) is 
	begin
		if (experimental_mode = '1' and (carry_out = '1' xor sub = '1') and sub = '1') then
			case sum_l_temp is
				when "0000" => sum_l_comp<="1001";
				when "0001" => sum_l_comp<="1000";
				when "0010" => sum_l_comp<="0111";
				when "0011" => sum_l_comp<="0110";
				when "0100" => sum_l_comp<="0101";
				when "0101" => sum_l_comp<="0100";
				when "0110" => sum_l_comp<="0011";
				when "0111" => sum_l_comp<="0010";
				when "1000" => sum_l_comp<="0001";
				when "1001" => sum_l_comp<="0000";
				when others => sum_l_comp<="0000";
			end case;		
			 case sum_r_temp is
				when "0000" => sum_r_comp<="1001";
				when "0001" => sum_r_comp<="1000";
				when "0010" => sum_r_comp<="0111";
				when "0011" => sum_r_comp<="0110";
				when "0100" => sum_r_comp<="0101";
				when "0101" => sum_r_comp<="0100";
				when "0110" => sum_r_comp<="0011";
				when "0111" => sum_r_comp<="0010";
				when "1000" => sum_r_comp<="0001";
				when "1001" => sum_r_comp<="0000";
				when others => sum_r_comp<="0000";
			end case;
			
			
			-- if negative, add a single number.
			-- TODO: Test
			if (std_logic_vector(a_l & a_r) < std_logic_vector(b_l & b_r)) then
				sum_r_comp <= sum_r_comp + "0001";
			end if;
			sum_l <= sum_r_comp;
			sum_r <= sum_r_comp;
			-- End TODO
			

		else
			sum_l <= sum_l_temp;
			sum_r <= sum_r_temp;
		end if;
	end process;
	
	
end a;
