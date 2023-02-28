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
		  reset_alarm			 : in std_logic := '1'; -- KEY4
		  sys_clk				 : in std_logic; -- M9
		  
		  toggle_alarm				 : in std_logic; -- SW9
		  
		  change_time         : in std_logic; -- SW0
        change_alarm        : in std_logic; -- SW1
        toggle_increment_s    : in std_logic; -- KEY1
        toggle_increment_m    : in std_logic; -- KEY2
        toggle_increment_h      : in std_logic; -- KEY3
		  
		  -- 1hz timer
		  onehz_clk_out       : out std_logic;
		  
		  -- displays
        hour_msd_disp            : out std_logic_vector(0 to 6) := "1111111";
        hour_lsd_disp            : out std_logic_vector(0 to 6) := "1111111";
        minute_msd_disp          : out std_logic_vector(0 to 6) := "1111111";
        minute_lsd_disp          : out std_logic_vector(0 to 6) := "1111111";
        second_msd_disp          : out std_logic_vector(0 to 6) := "1111111";
        second_lsd_disp          : out std_logic_vector(0 to 6) := "1111111";
        am_pm_disp               : out std_logic := '0';
		  
		  -- reset flags
		  s_rst_disp       : out std_logic := '0';
		  m_rst_disp       : out std_logic := '0';
		  h_rst_disp       : out std_logic := '0';
		  
		  ring 				 : out std_logic
		  
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
	 
	 signal second_lsd_time      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal second_msd_time      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal minute_lsd_time      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal minute_msd_time      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal hour_lsd_time      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal hour_msd_time      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal am_pm_time         : std_logic := '0';

    signal hours_alarm          : std_logic_vector(5 downto 0) := "000000";
    signal minutes_alarm        : std_logic_vector(5 downto 0) := "000000";
    signal seconds_alarm        : std_logic_vector(5 downto 0) := "000000";
	 
	 signal second_lsd_alarm      : std_logic_vector(0 to 6) 	:= "1111111";
	 signal second_msd_alarm		: std_logic_vector(0 to 6) 	:= "1111111";
	 signal minute_lsd_alarm      : std_logic_vector(0 to 6) 	:= "1111111";
	 signal minute_msd_alarm      : std_logic_vector(0 to 6) 	:= "1111111";
	 signal hour_lsd_alarm      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal hour_msd_alarm      : std_logic_vector(0 to 6) 		:= "1111111";
	 signal am_pm_alarm         : std_logic                     := '0';
	 
	 signal sec_rst_time			  : std_logic := '0';
	 signal min_rst_time			  : std_logic := '0';
	 signal hr_rst_time			  		: std_logic := '0';
	 
	 signal sec_rst_alarm		  : std_logic := '0';
	 signal min_rst_alarm		  : std_logic := '0';
	 signal hr_rst_alarm 	: std_logic := '0';
	 
	 signal change_s				: std_logic := '0';
	 signal change_m				: std_logic := '0';
	 signal change_h				: std_logic := '0';
	 
	 signal run_time				: std_logic := '1';

	 --===================================================
    --============ Component Interfaces =================
    --===================================================
	 
	 component counter is 
		port(
		  clk : in std_logic;
        reset_in : in std_logic;
		  maxval   : in integer;
		  minval   : in integer;
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

    component clk_gen is
        port
        (
            sys_clk         : in std_logic;
				run_time			 : in std_logic;
            onehz_clk_flag  : out std_logic
        );
    end component;
	 
	 component alarm is 
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
	end component;




    
    begin
		  --===================================================
	     --========== Set Outputs from Signals ===============
	     --===================================================
		  onehz_clk_out <= onehz_clk;
		  
		  change_s <= onehz_clk or not toggle_increment_s;
		  change_m <= sec_rst_time or not toggle_increment_m;
		  change_h <= min_rst_time or not toggle_increment_h;
		  
		  run_time <= not change_time and not change_alarm;
		  
		  -- display alarm or time?
		  process (change_alarm)
		  begin
			  if (change_alarm = '1') then
					second_lsd_disp <= second_lsd_alarm;
					second_msd_disp <= second_msd_alarm;
					minute_lsd_disp <= minute_lsd_alarm;
					minute_msd_disp <= minute_msd_alarm;
					hour_lsd_disp   <= hour_lsd_alarm;
					hour_msd_disp   <= hour_msd_alarm;
					am_pm_disp      <= am_pm_alarm;
					s_rst_disp      <= sec_rst_alarm;
					m_rst_disp      <= min_rst_alarm;
					h_rst_disp      <= hr_rst_alarm;
				else 
					second_lsd_disp <= second_lsd_time;
					second_msd_disp <= second_msd_time;
					minute_lsd_disp <= minute_lsd_time;
					minute_msd_disp <= minute_msd_time;
					hour_lsd_disp   <= hour_lsd_time;
					hour_msd_disp   <= hour_msd_time;
					am_pm_disp      <= am_pm_time;
					s_rst_disp      <= sec_rst_time;
					m_rst_disp      <= min_rst_time;
					h_rst_disp      <= hr_rst_time;
				end if;
			end process;
		  

		  
		  --===================================================
        --============ Component Instantiations =============
        --===================================================
        onehz_clk_gen : clk_gen port map(
            sys_clk         => sys_clk,
				run_time			 => run_time,
            onehz_clk_flag  => onehz_clk
        );
		  
		  ctr_sec : counter port map(
			clk			    =>  change_s and not change_alarm,
			reset_in 		 => reset,
			maxval			 => 59,
			minval			 => 0,
			ones_display     => second_lsd_time,
			tens_display    => second_msd_time,
			reset_flag      => sec_rst_time
		  );
		  
		  ctr_min : counter port map(
			clk			    => change_m and not change_alarm,
			reset_in 		 => reset,
			maxval			 => 59,
			minval			 => 0,
			ones_display     => minute_lsd_time,
			tens_display    => minute_msd_time,
			reset_flag      => min_rst_time
		  );
		  
		  ctr_hr : counter port map(
			clk			    => change_h and not change_alarm,
			reset_in 		 => reset,
			maxval			 => 12,
			minval			 => 1,
			ones_display     => hour_lsd_time,
			tens_display    => hour_msd_time,
			reset_flag      => hr_rst_time
		  );
		  
		   set_alarm_sec : counter port map(
			clk			    => change_alarm and not toggle_increment_s,
			reset_in 		 => reset_alarm,
			maxval			 => 59,
			minval			 => 0,
			ones_display     => second_lsd_alarm,
			tens_display    => second_msd_alarm,
			reset_flag      => sec_rst_alarm
		  );
		  
		  set_alarm_min: counter port map(
			clk			    => change_alarm and not toggle_increment_m,
			reset_in 		 => reset_alarm,
			maxval			 => 59,
			minval			 => 0,
			ones_display     => minute_lsd_alarm,
			tens_display    => minute_msd_alarm,
			reset_flag      => min_rst_alarm
		  );
		  
		  set_alarm_hr: counter port map(
			clk			    => change_alarm and not toggle_increment_h,
			reset_in 		 => reset_alarm,
			maxval			 => 12,
			minval			 => 1,
			ones_display     => hour_lsd_alarm,
			tens_display    => hour_msd_alarm,
			reset_flag      => hr_rst_alarm
		  );
		  
		  
		  am_pm_flipflop_time : flipflop port map(
			reset				=> reset,
			enable		   => hr_rst_time,
			q					=> am_pm_time
		  );
		  
		  am_pm_flipflop_alarm : flipflop port map(
			reset				=> reset_alarm,
			enable		   => hr_rst_alarm,
			q					=> am_pm_alarm
		  );
		  
		  alm : alarm port map(
				toggle_alarm 			=> toggle_alarm,
				minute_lsd_alarm		=> minute_lsd_alarm,
				minute_lsd_time		=> minute_lsd_time,

				minute_msd_alarm		=> minute_msd_alarm,
				minute_msd_time		=> minute_msd_time,

				hour_lsd_alarm			=> hour_lsd_alarm,
				hour_lsd_time			=> hour_lsd_time,

				hour_msd_alarm			=> hour_msd_alarm, 
				hour_msd_time			=> hour_msd_time,

				am_pm_alarm				=> am_pm_alarm,
				am_pm_time				=> am_pm_time,
				
				ring						=> ring
		  );
		  
		
end Behavioral;
    