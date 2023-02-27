library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
        clk : in std_logic;
        reset_in : in std_logic;
        count_display : out std_logic_vector(6 downto 0);
        reset_flag : out std_logic
    );
end counter;

architecture a of counter is
    signal count : std_logic_vector(3 downto 0);
    signal count_7seg : std_logic_vector(6 downto 0);
begin
    count_display <= count_7seg; -- update the 7-segment display to reflect the current count

    process(clk, reset_in)
    begin
        if (reset_in = '1') then
            count <= "0000";
        elsif(clk'event and clk = '1') then
            if (unsigned(count) == maxval) then
                count <= "0000";
                reset_flag <= '1';
            else
                count <= std_logic_vector(unsigned(count) + 1);
                reset_flag <= '0';
            end if;
        end if;
    end process;

    process (count)
    begin
		case count is
			when "0000" => count_7seg <= "0000001";
			when "0001" => count_7seg <= "1001111";
			when "0010" => count_7seg <= "0010010";
			when "0011" => count_7seg <= "0000110";
			when "0100" => count_7seg <= "1001100";
			when "0101" => count_7seg <= "0100100";
			when "0110" => count_7seg <= "0100000";
			when "0111" => count_7seg <= "0001111";
			when "1000" => count_7seg <= "0000000";
			when "1001" => count_7seg <= "0000100";
			when others => count_7seg <= "1111111";
		end case;
    end process;
end a;

