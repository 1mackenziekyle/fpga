library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



--===================================================
--=============== Top-Level Entity ==================
--===================================================
entity cpen312_lab2_b is 
	port
	(
		input				: in std_logic_vector(7 downto 0);
		toggle_a 		: in std_logic;
		toggle_b 		: in std_logic;
		sub  				: in std_logic;
		carry_in			: in std_logic;
		res				: out std_logic_vector(7 downto 0);
		carry				: out std_logic;
		a_7seg_l			: out std_logic_vector(6 downto 0);
		a_7seg_r			: out std_logic_vector(6 downto 0);
		b_7seg_l			: out std_logic_vector(6 downto 0);
		b_7seg_r			: out std_logic_vector(6 downto 0)

	);
	end cpen312_lab2_b;

architecture Behavioral of cpen312_lab2_b is


	--===================================================
	--============ Define Input Signals =================
	--===================================================

	signal a_stored_l : std_logic_vector(3 downto 0) := "0000"; -- 10s digit of A
	signal a_stored_r : std_logic_vector(3 downto 0) := "0000"; -- 1s digit of A
	signal b_stored_l : std_logic_vector(3 downto 0) := "0000"; -- 10s digit of B
	signal b_stored_r : std_logic_vector(3 downto 0) := "0000"; -- 1s digit of B
	
	
	
	
	

	--===================================================
	--============== Component Templates ================
	--===================================================

	--================== 8-bit latch ====================
	component latch_8bit is
	port(
		enable 		: in std_logic;
		data			: in std_logic_vector(7 downto 0);
		q				: out std_logic_vector(7 downto 0)
	);
	end component;

	--=========== BCD to 7 Segment Display ==============
	component bcdto7seg is 
	port(
		bcd		: in std_logic_vector(3 downto 0);
		display		: out std_logic_vector(6 downto 0)
	);
	end component;

	--============ 8-bit adder or subtractor ============
	component bcd_addsub is
	port(
		  a,b      : in   std_logic_vector(7 downto 0);
		  sub      : in   std_logic; -- 1 to subtract
		  carry_in : in   std_logic;
		  sum      : out  std_logic_vector(7 downto 0);
		  carry	  : out  std_logic
	);
	end component;
	
	--=========== Vector to 4-bit nibbles ===============
	component vec_to_nibs is 
	port(
		data    	  : in STD_LOGIC_VECTOR(7 DOWNTO 0);
      l          : out STD_LOGIC_VECTOR(3 DOWNTO 0);
		r          : out STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
	end component;





	--===================================================
	--========== Instantiate components =================
	--===================================================

	begin

		latch_a : latch_8bit port map(
			enable		=> toggle_a,
			data			=> input,
			q				=> a_stored
		);

		latch_b : latch_8bit port map(
			enable		=> toggle_b,
			data			=> input,
			q				=> b_stored
		);
		
		-- split_a : vec_to_nibs port map(
		-- 	data		=> a_stored,
		-- 	l			=> a_stored_l,
		-- 	r			=> a_stored_r
		-- );	

		display_a_l : bcdto7seg port map(
			bcd		=> a_stored(3 downto 0),
			display		=> a_7seg
		);

		display_b_l : bcdto7seg port map(
			bcd		=> b_stored(3 downto 0),
			display		=> b_7seg
		);

		math_op : bcd_addsub port map(
			a				=> a_stored,
			b				=> b_stored,
		  sub      		=> sub,
		  carry_in 		=> carry_in,
		  sum      		=> res,
		  carry			=> carry
		);

		
end Behavioral;