library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



--===================================================
--=============== Top-Level Entity ==================
--===================================================
entity cpen312_lab2_a is 
	port
	(
		-- Inputs
		input_l				: in std_logic_vector(3 downto 0);
		input_r				: in std_logic_vector(3 downto 0);
		toggle_a 			: in std_logic;
		toggle_b 			: in std_logic;

		sub  				: in std_logic;

		-- Display A and B
		a_7seg_l			: out std_logic_vector(6 downto 0);
		a_7seg_r			: out std_logic_vector(6 downto 0);
		b_7seg_l			: out std_logic_vector(6 downto 0);
		b_7seg_r			: out std_logic_vector(6 downto 0);

		-- Display sum
		sum_l_7seg				: out std_logic_vector(6 downto 0);
		sum_r_7seg				: out std_logic_vector(6 downto 0);
		overflow					: out std_logic

	);
	end cpen312_lab2_a;

architecture Behavioral of cpen312_lab2_a is


	--===================================================
	--============ Define Input signals =================
	--===================================================

	signal a_stored_l : std_logic_vector(3 downto 0) := "0000";
	signal a_stored_r : std_logic_vector(3 downto 0) := "0000";
	signal b_stored_l : std_logic_vector(3 downto 0) := "0000";
	signal b_stored_r : std_logic_vector(3 downto 0) := "0000";
	signal sum_l      : std_logic_vector(3 downto 0) := "0000";
	signal sum_r      : std_logic_vector(3 downto 0) := "0000";
	signal carry_out  : std_logic;
	
	
	
	
	

	--===================================================
	--============== Component Interfaces ===============
	--===================================================

	--================== 8-bit latch ====================
	component latch_4bit is
	port(
		enable 		: in std_logic;
		data		: in std_logic_vector(3 downto 0);
		q			: out std_logic_vector(3 downto 0)
	);
	end component;

	--=========== BCD to 7 Segment Display ==============
	component bcdto7seg is 
	port(
		bcd			: in std_logic_vector(3 downto 0);
		display		: out std_logic_vector(6 downto 0)
	);
	end component;

	--============ 8-bit adder or subtractor ============
	component bcd_addsub is
	port(
		a,b        : in   std_logic_vector(7 downto 0);
		sub        : in   std_logic; -- 1 to subtract
		carry_in   : in   std_logic;
		sum        : out  std_logic_vector(7 downto 0);
		carry	   : out  std_logic
	);
	end component;

	component bcd_2dig_addsub is
		port(
			a,b      			: in   std_logic_vector(7 downto 0);
			sub      			: in   std_logic; -- 1 to subtract
			sum_l   			: out  std_logic_vector(3 downto 0); 
			sum_r   			: out  std_logic_vector(3 downto 0);
			overflow	 		: out  std_logic  
		);
	end component;
	



	--===================================================
	--========== Instantiate components =================
	--===================================================

	begin
		-- 
		latch_a_l : latch_4bit port map(
			enable		=> toggle_a,
			data			=> input_l,
			q				=> a_stored_l
		);

		latch_a_r : latch_4bit port map(
			enable		=> toggle_a,
			data			=> input_r,
			q				=> a_stored_r
		);

		latch_b_l : latch_4bit port map(
			enable		=> toggle_b,
			data			=> input_l,
			q				=> b_stored_l
		);

		latch_b_r : latch_4bit port map(
			enable		=> toggle_b,
			data			=> input_r,
			q				=> b_stored_r
		);
	
		display_a_l : bcdto7seg port map(
			bcd		=> a_stored_l(3 downto 0),
			display		=> a_7seg_l
		);

		display_a_r : bcdto7seg port map(
			bcd		=> a_stored_r(3 downto 0),
			display		=> a_7seg_r
		);

		display_b_l : bcdto7seg port map(
			bcd		=> b_stored_l(3 downto 0),
			display		=> b_7seg_l
		);

		display_b_r : bcdto7seg port map(
			bcd		=> b_stored_r(3 downto 0),
			display		=> b_7seg_r
		);

		math_op : bcd_2dig_addsub port map(
			a			=> a_stored_r & a_stored_l,
			b			=> b_stored_r & b_stored_l,
			sub			=> sub,
			sum_l		=> sum_l,
			sum_r		=> sum_r,
			overflow	=> overflow
		);

		display_sum_l : bcdto7seg port map(
			bcd		=> sum_l,
			display		=> sum_l_7seg
		);

		display_sum_r : bcdto7seg port map(
			bcd		=> sum_r,
			display		=> sum_r_7seg
		);
		
		
end Behavioral;