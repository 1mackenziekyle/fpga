library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_one_digit is
    port (
        clk : in std_logic;
        reset_in : in std_logic;
		  maxval   : in integer;
        val_display : out std_logic_vector(0 to 6);
        reset_flag : out std_logic
    );
end counter_one_digit;

architecture a of counter_one_digit is
    signal val : integer := 0;
    signal val_7seg : std_logic_vector(0 to 6);
begin
    val_display <= val_7seg; -- update the 7-segment display to reflect the current 

    process(clk, val, reset_in)
    begin
        if (reset_in = '0') then
            val <= 0;
        elsif(clk'event and clk='1') then
            if (val >maxval-1) then
                val <= 0;
                reset_flag <= '1';
            else
                val <= val + 1;
                reset_flag <= '0';
            end if;
        end if;
    end process;

    process (val)
    begin
		case val is
			when 0 => val_7seg <= "0000001";
			when 1 => val_7seg <= "1001111";
			when 2 => val_7seg<= "0010010";
			when 3 => val_7seg <= "0000110";
			when 4 => val_7seg <= "1001100";
			when 5 => val_7seg <= "0100100";
			when 6 => val_7seg <= "0100000";
			when 7 => val_7seg <= "0001111";
			when 8 => val_7seg <= "0000000";
			when 9 => val_7seg <= "0000100";
			when others => val_7seg <= "1111111";
		end case;
    end process;
end a;

