library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
        clk : in std_logic;
        reset_in : in std_logic;
		  maxval   : in integer;
		  minval	  : in integer;
        ones_display : out std_logic_vector(0 to 6);
		  tens_display : out std_logic_vector(0 to 6);
        reset_flag : out std_logic
    );
end counter;

architecture a of counter is
    signal val : integer := minval;
	 signal ones : integer := 0;
	 signal tens : integer := 0;
    signal ones_7seg : std_logic_vector(0 to 6);
	 signal tens_7seg : std_logic_vector(0 to 6);
begin
    ones <= val mod 10;
	 tens <= val / 10;
	 ones_display <= ones_7seg; -- update the 7-segment display to reflect the current 
	 tens_display <= tens_7seg;

    process(clk, val, reset_in)
    begin
        if (reset_in = '0') then
            val <= minval;
        elsif(clk'event and clk='1') then
            if (val >maxval-1) then
                val <= minval;
                reset_flag <= '1';
				elsif (val < minval) then
					val <= minval;
            else
                val <= val + 1;
                reset_flag <= '0';
            end if;
        end if;
    end process;

    process (ones)
    begin
		case ones is
			when 0 => ones_7seg <= "0000001";
			when 1 => ones_7seg <= "1001111";
			when 2 => ones_7seg <= "0010010";
			when 3 => ones_7seg <= "0000110";
			when 4 => ones_7seg <= "1001100";
			when 5 => ones_7seg <= "0100100";
			when 6 => ones_7seg <= "0100000";
			when 7 => ones_7seg <= "0001111";
			when 8 => ones_7seg <= "0000000";
			when 9 => ones_7seg <= "0000100";
			when others => ones_7seg <= "1111111";
		end case;
    end process;
	 
	 
    process (tens)
    begin
		case tens is
			when 0 => tens_7seg <= "0000001";
			when 1 => tens_7seg <= "1001111";
			when 2 => tens_7seg <= "0010010";
			when 3 => tens_7seg <= "0000110";
			when 4 => tens_7seg <= "1001100";
			when 5 => tens_7seg <= "0100100";
			when 6 => tens_7seg <= "0100000";
			when 7 => tens_7seg <= "0001111";
			when 8 => tens_7seg <= "0000000";
			when 9 => tens_7seg <= "0000100";
			when others => tens_7seg <= "1111111";
		end case;
    end process;
end a;

