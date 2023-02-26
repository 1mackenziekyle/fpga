library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;





--===================================================
--=============== Top-Level Entity ==================
--===================================================
entity clock is 
    port
    (
        reset               : in std_logic := '1'; -- KEY0
		  sys_clk				 : in std_logic; -- M9
		  
--		  change_time         : in std_logic; -- SW9
--        change_alarm        : in std_logic; -- SW8
--        increment_second    : in std_logic; -- KEY1
--        increment_minute    : in std_logic; -- KEY2
--        increment_hour      : in std_logic; -- KEY3
		  
		  -- 1hz timer
		  onehz_clk_out       : out std_logic;
		  
		  -- displays
        hour_msd            : out std_logic_vector(0 to 6) := "1111111";
        hour_lsd            : out std_logic_vector(0 to 6) := "1111111";
        minute_msd          : out std_logic_vector(0 to 6) := "1111111";
        minute_lsd          : out std_logic_vector(0 to 6) := "1111111";
        second_msd          : out std_logic_vector(0 to 6) := "1111111";
        second_lsd          : out std_logic_vector(0 to 6) := "1111111";
        am_pm               : out std_logic := '0';
		  
		  -- reset flags
		  s_rst_disp       : out std_logic := '0';
		  m_rst_disp       : out std_logic := '0';
		  h_rst_disp       : out std_logic := '0'
		  
    );
end clock;

--===================================================
--=============== Architecture ======================
--===================================================
architecture Behavioral of clock is

    
    --===================================================
    --============ Define Input signals =================
    --===================================================
	 signal onehz_clk				  : std_logic := '0';
 
    signal hours_time           : std_logic_vector(5 downto 0) := "000000";
    signal minutes_time         : std_logic_vector(5 downto 0) := "000000";
    signal seconds_time         : std_logic_vector(5 downto 0) := "000000";

    signal hours_alarm          : std_logic_vector(5 downto 0) := "000000";
    signal minutes_alarm        : std_logic_vector(5 downto 0) := "000000";
    signal seconds_alarm        : std_logic_vector(5 downto 0) := "000000";
	 
	 signal sec_rst			  : std_logic := '0';
	 signal min_rst			  : std_logic := '0';
	 signal hr_rst			  		: std_logic := '0';

	 --===================================================
    --============ Component Interfaces =================
    --===================================================
	 
	 component counter is 
		port(
		  clk : in std_logic;
        reset_in : in std_logic;
		  maxval   : in integer;
        ones_display : out std_logic_vector(0 to 6);
		  tens_display : out std_logic_vector(0 to 6);
        reset_flag : out std_logic
		);
	 end component;
	 
	 component flipflop is
		port(
		  reset	: in std_logic;
		  enable : in std_logic;
        q 		: out std_logic
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
            onehz_clk_flag  : out std_logic
        );
    end component;




    
    begin
		  --===================================================
	     --========== Set Outputs from Signals ===============
	     --===================================================
		  onehz_clk_out <= onehz_clk;
		  s_rst_disp <= sec_rst;
		  m_rst_disp <= min_rst;
		  h_rst_disp <= hr_rst;

		  
		  --===================================================
        --============ Component Instantiations =============
        --===================================================
        onehz_clk_gen : clk_gen port map(
            sys_clk         => sys_clk,
            onehz_clk_flag  => onehz_clk
        );
		  
		  ctr_sec : counter port map(
			clk			    => onehz_clk,
			reset_in 		 => reset,
			maxval			 => 59,
			ones_display     => second_lsd,
			tens_display    => second_msd,
			reset_flag      => sec_rst
		  );
		  
		  ctr_min : counter port map(
			clk			    => sec_rst,
			reset_in 		 => reset,
			maxval			 => 59,
			ones_display     => minute_lsd,
			tens_display    => minute_msd,
			reset_flag      => min_rst
		  );
		  
		  ctr_hr : counter port map(
			clk			    => min_rst,
			reset_in 		 => reset,
			maxval			 => 11,
			ones_display     => hour_lsd,
			tens_display    => hour_msd,
			reset_flag      => hr_rst
		  );
		  
		  am_pm_flipflop : flipflop port map(
			reset				=> reset,
			enable		   => hr_rst,
			q					=> am_pm
		  );
		
end Behavioral;
    