LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY BCDCOUNT IS
	port(
	KEY0, CLK_FLAG	:IN 	STD_LOGIC;
	MSD, LSD :OUT STD_LOGIC_VECTOR (0 to 6);
	RESET_FLG: OUT STD_LOGIC
	);
END BCDCOUNT;

ARCHITECTURE a of BCDCOUNT is
	SIGNAL HighDigit, LowDigit: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL MSD_7SEG, LSD_7SEG: STD_LOGIC_VECTOR(0 to 6);
BEGIN

	LSD<=LSD_7SEG;
	MSD<=MSD_7SEG;

	PROCESS(ClkFlag, KEY0)
	BEGIN
		if(KEY0='0') then -- reset
			LowDigit<="0000";
			HighDigit<="0000";
		elsif(CLK_IN)'event and CLK_IN ='1') then
			if (LowDigit=9) then
				LowDigit<="0000";
				if (HighDigit=5) then
					HighDigit<="0000";
				else HighDigit<=HighDigit+'1';
				end if;
			else
				LowDigit<=LowDigit+'1';
			end if;
		end if;
	END PROCESS;

	PROCESS(LowDigit, HighDigit)
	BEGIN
		case LowDigit is
			when "0000" => LSD_7SEG <= "0000001";
			when "0001" => LSD_7SEG <= "1001111";
			when "0010" => LSD_7SEG <= "0010010";
			when "0011" => LSD_7SEG <= "0000110";
			when "0100" => LSD_7SEG <= "1001100";
			when "0101" => LSD_7SEG <= "0100100";
			when "0110" => LSD_7SEG <= "0100000";
			when "0111" => LSD_7SEG <= "0001111";
			when "1000" => LSD_7SEG <= "0000000";
			when "1001" => LSD_7SEG <= "0000100";
			when others => LSD_7SEG <= "1111111";
		end case;

		case HighDigit is
			when "0000" => MSD_7SEG <= "0000001";
			when "0001" => MSD_7SEG <= "1001111";
			when "0010" => MSD_7SEG <= "0010010";
			when "0011" => MSD_7SEG <= "0000110";
			when "0100" => MSD_7SEG <= "1001100";
			when "0101" => MSD_7SEG <= "0100100";
			when "0110" => MSD_7SEG <= "0100000";
			when "0111" => MSD_7SEG <= "0001111";
			when "1000" => MSD_7SEG <= "0000000";
			when "1001" => MSD_7SEG <= "0000100";
			when others => MSD_7SEG <= "1111111";
		end case;
	END PROCESS;

end a;

	
