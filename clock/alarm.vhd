library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alarm is
	port
	(
	   toggle_alarm : in std_logic;

		minute_lsd_alarm		: in std_logic_vector(0 to 6);
		minute_lsd_time		: in std_logic_vector(0 to 6);

		minute_msd_alarm		: in std_logic_vector(0 to 6);
		minute_msd_time		: in std_logic_vector(0 to 6);

		hour_lsd_alarm			: in std_logic_vector(0 to 6);
		hour_lsd_time			: in std_logic_vector(0 to 6);

		hour_msd_alarm			: in std_logic_vector(0 to 6);
		hour_msd_time			: in std_logic_vector(0 to 6);

		am_pm_alarm				: in std_logic;
		am_pm_time				: in std_logic;
		
		ring						: out std_logic
	);
end alarm;

architecture a of alarm is 

	signal tmp : std_logic := '0';

	begin
	process (toggle_alarm, 
	minute_lsd_alarm, minute_lsd_time,
	minute_msd_alarm, minute_msd_time,
	hour_lsd_alarm, hour_lsd_time,
	hour_msd_alarm, hour_msd_time,
	am_pm_alarm,    am_pm_time
	) is -- debug: remove clock from depend list
	begin
		if (
		toggle_alarm = '1' and
		minute_lsd_alarm = minute_lsd_time and
		minute_msd_alarm = minute_msd_time and
		hour_lsd_alarm = hour_lsd_time and
		hour_msd_alarm = hour_msd_time and
		am_pm_alarm    = am_pm_time
		) then
			tmp <= '1';
		else
			tmp <= '0';
		end if;
		ring <= tmp;
	end process;
end a;