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
		  s_lsd_rst_flg       : out std_logic := '0';
		  s_msd_rst_flg       : out std_logic := '0';
		  m_lsd_rst_flg       : out std_logic := '0';
		  m_msd_rst_flg       : out std_logic := '0';
		  h_lsd_rst_flg       : out std_logic := '0';
		  h_msd_rst_flg       : out std_logic := '0'
		  
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
	 
	 signal sec_lsd_rst			  : std_logic := '0';
	 signal sec_msd_rst			  : std_logic := '0';
	 signal min_lsd_rst			  : std_logic := '0';
	 signal min_msd_rst			  : std_logic := '0';
	 signal hr_lsd_rst			  : std_logic := '0';
	 signal hr_msd_rst			  : std_logic := '0';
	 
	 

	 

    --===================================================
    --============ Component Interfaces =================
    --===================================================

    component counter is
        port (
            clk : in std_logic;
            reset_in : in std_logic;
				maxval   : in integer;
            val_display : out std_logic_vector(6 downto 0);
            reset_flag : out std_logic
        );
    end component;

    component counter_one_digit is
        -- Increments value by 1 on each rising edge of enable signal
        port
        (
            input       : in std_logic_vector(5 downto 0);
            clkFlag      : in std_logic; -- increment
            maxval      : in std_logic_vector(5 downto 0);
            output      : out std_logic_vector(5 downto 0);
            resetFlag   : out std_logic
        );
    end component;
	 
	 component counter_2dig is 
		port(
		  clk : in std_logic;
        reset_in : in std_logic;
		  maxval   : in integer;
        ones_display : out std_logic_vector(0 to 6);
		  tens_display : out std_logic_vector(0 to 6);
        reset_flag : out std_logic
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
		  
		  s_lsd_rst_flg <= sec_lsd_rst;
		  s_msd_rst_flg <= sec_msd_rst;
		  m_lsd_rst_flg <= min_lsd_rst;
		  m_msd_rst_flg <= min_msd_rst;
		  h_lsd_rst_flg <= hr_lsd_rst;
		  h_msd_rst_flg <= hr_msd_rst;
		  
		  
		  
		  
		  --===================================================
        --============ Component Instantiations =============
        --===================================================
        onehz_clk_gen : clk_gen port map(
            sys_clk         => sys_clk,
            onehz_clk_flag  => onehz_clk
        );
		  
		  ctr_sec : counter_2dig port map(
			clk			    => onehz_clk,
			reset_in 		 => reset,
			maxval			 => 59,
			ones_display     => second_lsd,
			tens_display    => second_msd,
			reset_flag      => sec_lsd_rst
		  );
		  
		  
--		  ctr_sec_lsd : counter port map(
--				clk			    => onehz_clk,
--				reset_in 		 => reset,
--				maxval			 => 9,
--				val_display     => second_lsd,
--				reset_flag      => sec_lsd_rst
--			);
--			
--			ctr_sec_msd : counter port map(
--				clk			    => sec_lsd_rst,
--				reset_in 		 => reset,
--				maxval			 => 5,
--				val_display     => second_msd,
--				reset_flag      => sec_msd_rst
--			);
			
--			ctr_min_lsd : counter port map(
--				clk			    => sec_msd_rst,
--				reset_in 		 => reset,
--				maxval			 => 9,
--				val_display     => minute_lsd,
--				reset_flag      => min_lsd_rst
--			);
--			
--			ctr_min_msd : counter port map(
--				clk			    => min_lsd_rst,
--				reset_in 		 => reset,
--				maxval			 => 5,
--				val_display     => minute_msd,
--				reset_flag      => min_msd_rst
--			);
----			
--			ctr_hr_lsd : counter port map(
--				clk			    => min_msd_rst,
--				reset_in 		 => reset,
--				maxval			 => 9,
--				val_display     => hour_lsd,
--				reset_flag      => hr_lsd_rst
--			);
--			
--			ctr_hr_msd : counter port map(
--				clk			    => hr_lsd_rst,
--				reset_in 		 => reset,
--				maxval			 => 5,
--				val_display     => hour_msd,
--				reset_flag      => hr_msd_rst
--			);
		

		
end Behavioral;
    