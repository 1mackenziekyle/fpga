library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;





--===================================================
--=============== Top-Level Entity ==================
--===================================================
entity clock is 
    port
    (
        reset               : in std_logic; -- KEY0
        change_time         : in std_logic; -- SW9
        change_alarm        : in std_logic; -- SW8
        increment_second    : in std_logic; -- KEY1
        increment_minute    : in std_logic; -- KEY2
        increment_hour      : in std_logic; -- KEY3
		  sys_clk				 : in std_logic; -- M9

        hour_msd            : out std_logic_vector(6 downto 0);
        hour_lsd            : out std_logic_vector(6 downto 0);
        minute_msd          : out std_logic_vector(6 downto 0);
        minute_lsd          : out std_logic_vector(6 downto 0);
        second_msd          : out std_logic_vector(6 downto 0);
        second_lsd          : out std_logic_vector(6 downto 0);
        am_pm               : out std_logic;
		  onehz_clk_out       : out std_logic
    );
end clock;

--===================================================
--=============== Architecture ======================
--===================================================
architecture Behavioral of clock is

    
    --===================================================
    --============ Define Input signals =================
    --===================================================
--    signal onehz_clk_flag       : std_logic := '0';
	 signal half_period			  : time      := 500 ms;
 
    signal hours_time           : std_logic_vector(5 downto 0);
    signal minutes_time         : std_logic_vector(5 downto 0);
    signal seconds_time         : std_logic_vector(5 downto 0);

    signal hours_alarm          : std_logic_vector(5 downto 0);
    signal minutes_alarm        : std_logic_vector(5 downto 0);
    signal seconds_alarm        : std_logic_vector(5 downto 0);


    --===================================================
    --============ Component Interfaces =================
    --===================================================

    component counter is
        port (
            clk : in std_logic;
            reset_in : in std_logic;
            count_display : out std_logic_vector(6 downto 0);
            reset_flag : out std_logic
        );
    end component;

    component increment is
        -- Increments value by 1 on each rising edge of enable signal
        port
        (
            input       : in std_logic_vector(5 downto 0);
            enable      : in std_logic;
            maxval      : in std_logic_vector(5 downto 0);
            output      : out std_logic_vector(5 downto 0);
            resetFlag   : out std_logic
        );
    end component;

    component display is
        port
        (
            input       : in std_logic_vector(5 downto 0);
            output_msd  : out std_logic_vector(6 downto 0);
            output_lsd  : out std_logic_vector(6 downto 0)
        );
    end component;

    component alarm is
        port
        (
            hours_time      : in std_logic_vector(5 downto 0);
            minutes_time    : in std_logic_vector(5 downto 0);
            seconds_time    : in std_logic_vector(5 downto 0);
            hours_alarm     : in std_logic_vector(5 downto 0);
            minutes_alarm   : in std_logic_vector(5 downto 0);
            seconds_alarm   : in std_logic_vector(5 downto 0);
            am_pm           : in std_logic;
            alarmFlag       : out std_logic
        );
    end component;

    component clk_gen is
        port
        (
            sys_clk         : in std_logic;
            half_period     : in time;
            onehz_clk_flag  : out std_logic
        );
    end component;




    --===================================================
    --============ Component Instantiations =============
    --===================================================
    begin
        onehz_clk_gen : clk_gen port map(
            sys_clk         => sys_clk,
            half_period     => half_period,
            onehz_clk_flag  => onehz_clk_out
        );
		

		
end Behavioral;
    