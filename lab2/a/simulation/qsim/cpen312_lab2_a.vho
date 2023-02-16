-- Copyright (C) 2016  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition"

-- DATE "02/15/2023 00:14:40"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	cpen312_lab2_a IS
    PORT (
	a : IN std_logic_vector(3 DOWNTO 0);
	b : IN std_logic_vector(3 DOWNTO 0);
	toggle_a : IN std_logic;
	toggle_b : IN std_logic;
	sub : IN std_logic;
	carry_in : IN std_logic;
	res : OUT std_logic_vector(3 DOWNTO 0);
	carry : OUT std_logic
	);
END cpen312_lab2_a;

-- Design Ports Information
-- res[0]	=>  Location: PIN_Y10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- res[1]	=>  Location: PIN_P12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- res[2]	=>  Location: PIN_Y9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- res[3]	=>  Location: PIN_R9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- carry	=>  Location: PIN_T10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sub	=>  Location: PIN_AB12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[0]	=>  Location: PIN_AA15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- toggle_b	=>  Location: PIN_U7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[1]	=>  Location: PIN_AB15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[2]	=>  Location: PIN_AA14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[3]	=>  Location: PIN_AA13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[0]	=>  Location: PIN_U13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- toggle_a	=>  Location: PIN_W9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- carry_in	=>  Location: PIN_AB13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[1]	=>  Location: PIN_V13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[2]	=>  Location: PIN_T13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[3]	=>  Location: PIN_T12,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF cpen312_lab2_a IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_a : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_b : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_toggle_a : std_logic;
SIGNAL ww_toggle_b : std_logic;
SIGNAL ww_sub : std_logic;
SIGNAL ww_carry_in : std_logic;
SIGNAL ww_res : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_carry : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \sub~input_o\ : std_logic;
SIGNAL \b[0]~input_o\ : std_logic;
SIGNAL \toggle_b~input_o\ : std_logic;
SIGNAL \b[3]~input_o\ : std_logic;
SIGNAL \b[2]~input_o\ : std_logic;
SIGNAL \b[1]~input_o\ : std_logic;
SIGNAL \math_op|Mux3~0_combout\ : std_logic;
SIGNAL \toggle_a~input_o\ : std_logic;
SIGNAL \a[0]~input_o\ : std_logic;
SIGNAL \carry_in~input_o\ : std_logic;
SIGNAL \math_op|Add0~22_cout\ : std_logic;
SIGNAL \math_op|Add0~1_sumout\ : std_logic;
SIGNAL \a[1]~input_o\ : std_logic;
SIGNAL \math_op|Add0~2\ : std_logic;
SIGNAL \math_op|Add0~5_sumout\ : std_logic;
SIGNAL \a[2]~input_o\ : std_logic;
SIGNAL \math_op|Add0~6\ : std_logic;
SIGNAL \math_op|Add0~9_sumout\ : std_logic;
SIGNAL \a[3]~input_o\ : std_logic;
SIGNAL \math_op|Mux0~0_combout\ : std_logic;
SIGNAL \math_op|Add0~10\ : std_logic;
SIGNAL \math_op|Add0~14\ : std_logic;
SIGNAL \math_op|Add0~17_sumout\ : std_logic;
SIGNAL \math_op|Add0~13_sumout\ : std_logic;
SIGNAL \math_op|sum[1]~0_combout\ : std_logic;
SIGNAL \math_op|sum[2]~1_combout\ : std_logic;
SIGNAL \math_op|sum[3]~2_combout\ : std_logic;
SIGNAL \math_op|LessThan0~0_combout\ : std_logic;
SIGNAL \latch_b|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \latch_a|q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \math_op|ALT_INV_Add0~5_sumout\ : std_logic;
SIGNAL \math_op|ALT_INV_Add0~9_sumout\ : std_logic;
SIGNAL \math_op|ALT_INV_Add0~13_sumout\ : std_logic;
SIGNAL \math_op|ALT_INV_Add0~17_sumout\ : std_logic;
SIGNAL \math_op|ALT_INV_Mux3~0_combout\ : std_logic;
SIGNAL \math_op|ALT_INV_Mux0~0_combout\ : std_logic;
SIGNAL \latch_b|ALT_INV_q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \latch_a|ALT_INV_q\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_sub~input_o\ : std_logic;
SIGNAL \ALT_INV_b[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_toggle_b~input_o\ : std_logic;
SIGNAL \ALT_INV_b[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_toggle_a~input_o\ : std_logic;
SIGNAL \ALT_INV_carry_in~input_o\ : std_logic;
SIGNAL \ALT_INV_a[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[3]~input_o\ : std_logic;

BEGIN

ww_a <= a;
ww_b <= b;
ww_toggle_a <= toggle_a;
ww_toggle_b <= toggle_b;
ww_sub <= sub;
ww_carry_in <= carry_in;
res <= ww_res;
carry <= ww_carry;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\math_op|ALT_INV_Add0~5_sumout\ <= NOT \math_op|Add0~5_sumout\;
\math_op|ALT_INV_Add0~9_sumout\ <= NOT \math_op|Add0~9_sumout\;
\math_op|ALT_INV_Add0~13_sumout\ <= NOT \math_op|Add0~13_sumout\;
\math_op|ALT_INV_Add0~17_sumout\ <= NOT \math_op|Add0~17_sumout\;
\math_op|ALT_INV_Mux3~0_combout\ <= NOT \math_op|Mux3~0_combout\;
\math_op|ALT_INV_Mux0~0_combout\ <= NOT \math_op|Mux0~0_combout\;
\latch_b|ALT_INV_q\(0) <= NOT \latch_b|q\(0);
\latch_b|ALT_INV_q\(1) <= NOT \latch_b|q\(1);
\latch_b|ALT_INV_q\(2) <= NOT \latch_b|q\(2);
\latch_a|ALT_INV_q\(0) <= NOT \latch_a|q\(0);
\latch_b|ALT_INV_q\(3) <= NOT \latch_b|q\(3);
\latch_a|ALT_INV_q\(1) <= NOT \latch_a|q\(1);
\latch_a|ALT_INV_q\(3) <= NOT \latch_a|q\(3);
\latch_a|ALT_INV_q\(2) <= NOT \latch_a|q\(2);
\ALT_INV_sub~input_o\ <= NOT \sub~input_o\;
\ALT_INV_b[0]~input_o\ <= NOT \b[0]~input_o\;
\ALT_INV_toggle_b~input_o\ <= NOT \toggle_b~input_o\;
\ALT_INV_b[1]~input_o\ <= NOT \b[1]~input_o\;
\ALT_INV_b[2]~input_o\ <= NOT \b[2]~input_o\;
\ALT_INV_b[3]~input_o\ <= NOT \b[3]~input_o\;
\ALT_INV_a[0]~input_o\ <= NOT \a[0]~input_o\;
\ALT_INV_toggle_a~input_o\ <= NOT \toggle_a~input_o\;
\ALT_INV_carry_in~input_o\ <= NOT \carry_in~input_o\;
\ALT_INV_a[1]~input_o\ <= NOT \a[1]~input_o\;
\ALT_INV_a[2]~input_o\ <= NOT \a[2]~input_o\;
\ALT_INV_a[3]~input_o\ <= NOT \a[3]~input_o\;

-- Location: IOOBUF_X23_Y0_N93
\res[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \math_op|Add0~1_sumout\,
	devoe => ww_devoe,
	o => ww_res(0));

-- Location: IOOBUF_X24_Y0_N36
\res[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \math_op|sum[1]~0_combout\,
	devoe => ww_devoe,
	o => ww_res(1));

-- Location: IOOBUF_X23_Y0_N76
\res[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \math_op|sum[2]~1_combout\,
	devoe => ww_devoe,
	o => ww_res(2));

-- Location: IOOBUF_X23_Y0_N42
\res[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \math_op|sum[3]~2_combout\,
	devoe => ww_devoe,
	o => ww_res(3));

-- Location: IOOBUF_X23_Y0_N59
\carry~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \math_op|LessThan0~0_combout\,
	devoe => ww_devoe,
	o => ww_carry);

-- Location: IOIBUF_X33_Y0_N75
\sub~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sub,
	o => \sub~input_o\);

-- Location: IOIBUF_X36_Y0_N35
\b[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(0),
	o => \b[0]~input_o\);

-- Location: IOIBUF_X10_Y0_N92
\toggle_b~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_toggle_b,
	o => \toggle_b~input_o\);

-- Location: LABCELL_X10_Y1_N33
\latch_b|q[0]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_b|q\(0) = ( \latch_b|q\(0) & ( (!\toggle_b~input_o\) # (\b[0]~input_o\) ) ) # ( !\latch_b|q\(0) & ( (\b[0]~input_o\ & \toggle_b~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001010101000000000101010111111111010101011111111101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_b[0]~input_o\,
	datad => \ALT_INV_toggle_b~input_o\,
	dataf => \latch_b|ALT_INV_q\(0),
	combout => \latch_b|q\(0));

-- Location: IOIBUF_X34_Y0_N35
\b[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(3),
	o => \b[3]~input_o\);

-- Location: LABCELL_X10_Y1_N15
\latch_b|q[3]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_b|q\(3) = ( \latch_b|q\(3) & ( (!\toggle_b~input_o\) # (\b[3]~input_o\) ) ) # ( !\latch_b|q\(3) & ( (\b[3]~input_o\ & \toggle_b~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111111111111000011111111111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_b[3]~input_o\,
	datad => \ALT_INV_toggle_b~input_o\,
	dataf => \latch_b|ALT_INV_q\(3),
	combout => \latch_b|q\(3));

-- Location: IOIBUF_X34_Y0_N52
\b[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(2),
	o => \b[2]~input_o\);

-- Location: LABCELL_X10_Y1_N39
\latch_b|q[2]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_b|q\(2) = ( \latch_b|q\(2) & ( \toggle_b~input_o\ & ( \b[2]~input_o\ ) ) ) # ( !\latch_b|q\(2) & ( \toggle_b~input_o\ & ( \b[2]~input_o\ ) ) ) # ( \latch_b|q\(2) & ( !\toggle_b~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_b[2]~input_o\,
	datae => \latch_b|ALT_INV_q\(2),
	dataf => \ALT_INV_toggle_b~input_o\,
	combout => \latch_b|q\(2));

-- Location: IOIBUF_X36_Y0_N52
\b[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(1),
	o => \b[1]~input_o\);

-- Location: MLABCELL_X9_Y1_N33
\latch_b|q[1]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_b|q\(1) = ( \b[1]~input_o\ & ( \toggle_b~input_o\ ) ) # ( \b[1]~input_o\ & ( !\toggle_b~input_o\ & ( \latch_b|q\(1) ) ) ) # ( !\b[1]~input_o\ & ( !\toggle_b~input_o\ & ( \latch_b|q\(1) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \latch_b|ALT_INV_q\(1),
	datae => \ALT_INV_b[1]~input_o\,
	dataf => \ALT_INV_toggle_b~input_o\,
	combout => \latch_b|q\(1));

-- Location: MLABCELL_X23_Y1_N12
\math_op|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Mux3~0_combout\ = ( \latch_b|q\(1) & ( (\latch_b|q\(0)) # (\latch_b|q\(3)) ) ) # ( !\latch_b|q\(1) & ( ((\latch_b|q\(3) & \latch_b|q\(2))) # (\latch_b|q\(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001111111111000000111111111100110011111111110011001111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \latch_b|ALT_INV_q\(3),
	datac => \latch_b|ALT_INV_q\(2),
	datad => \latch_b|ALT_INV_q\(0),
	dataf => \latch_b|ALT_INV_q\(1),
	combout => \math_op|Mux3~0_combout\);

-- Location: IOIBUF_X11_Y0_N35
\toggle_a~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_toggle_a,
	o => \toggle_a~input_o\);

-- Location: IOIBUF_X33_Y0_N41
\a[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(0),
	o => \a[0]~input_o\);

-- Location: LABCELL_X12_Y1_N30
\latch_a|q[0]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_a|q\(0) = ( \a[0]~input_o\ & ( \latch_a|q\(0) ) ) # ( !\a[0]~input_o\ & ( \latch_a|q\(0) & ( !\toggle_a~input_o\ ) ) ) # ( \a[0]~input_o\ & ( !\latch_a|q\(0) & ( \toggle_a~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000001111111111111111000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_toggle_a~input_o\,
	datae => \ALT_INV_a[0]~input_o\,
	dataf => \latch_a|ALT_INV_q\(0),
	combout => \latch_a|q\(0));

-- Location: IOIBUF_X33_Y0_N92
\carry_in~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_carry_in,
	o => \carry_in~input_o\);

-- Location: MLABCELL_X23_Y1_N30
\math_op|Add0~22\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Add0~22_cout\ = CARRY(( \carry_in~input_o\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_carry_in~input_o\,
	cin => GND,
	cout => \math_op|Add0~22_cout\);

-- Location: MLABCELL_X23_Y1_N33
\math_op|Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Add0~1_sumout\ = SUM(( (!\sub~input_o\ & (\latch_b|q\(0))) # (\sub~input_o\ & ((!\math_op|Mux3~0_combout\))) ) + ( \latch_a|q\(0) ) + ( \math_op|Add0~22_cout\ ))
-- \math_op|Add0~2\ = CARRY(( (!\sub~input_o\ & (\latch_b|q\(0))) # (\sub~input_o\ & ((!\math_op|Mux3~0_combout\))) ) + ( \latch_a|q\(0) ) + ( \math_op|Add0~22_cout\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000000000000000000000111001001110010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_sub~input_o\,
	datab => \latch_b|ALT_INV_q\(0),
	datac => \math_op|ALT_INV_Mux3~0_combout\,
	dataf => \latch_a|ALT_INV_q\(0),
	cin => \math_op|Add0~22_cout\,
	sumout => \math_op|Add0~1_sumout\,
	cout => \math_op|Add0~2\);

-- Location: IOIBUF_X33_Y0_N58
\a[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(1),
	o => \a[1]~input_o\);

-- Location: LABCELL_X12_Y1_N6
\latch_a|q[1]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_a|q\(1) = ( \latch_a|q\(1) & ( (!\toggle_a~input_o\) # (\a[1]~input_o\) ) ) # ( !\latch_a|q\(1) & ( (\a[1]~input_o\ & \toggle_a~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111111111111000011111111111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_a[1]~input_o\,
	datad => \ALT_INV_toggle_a~input_o\,
	dataf => \latch_a|ALT_INV_q\(1),
	combout => \latch_a|q\(1));

-- Location: MLABCELL_X23_Y1_N36
\math_op|Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Add0~5_sumout\ = SUM(( \latch_a|q\(1) ) + ( (\latch_b|q\(1) & ((!\sub~input_o\) # (!\latch_b|q\(3)))) ) + ( \math_op|Add0~2\ ))
-- \math_op|Add0~6\ = CARRY(( \latch_a|q\(1) ) + ( (\latch_b|q\(1) & ((!\sub~input_o\) # (!\latch_b|q\(3)))) ) + ( \math_op|Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110001000100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_sub~input_o\,
	datab => \latch_b|ALT_INV_q\(3),
	datac => \latch_a|ALT_INV_q\(1),
	dataf => \latch_b|ALT_INV_q\(1),
	cin => \math_op|Add0~2\,
	sumout => \math_op|Add0~5_sumout\,
	cout => \math_op|Add0~6\);

-- Location: IOIBUF_X34_Y0_N1
\a[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(2),
	o => \a[2]~input_o\);

-- Location: LABCELL_X12_Y1_N15
\latch_a|q[2]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_a|q\(2) = ( \a[2]~input_o\ & ( \latch_a|q\(2) ) ) # ( !\a[2]~input_o\ & ( \latch_a|q\(2) & ( !\toggle_a~input_o\ ) ) ) # ( \a[2]~input_o\ & ( !\latch_a|q\(2) & ( \toggle_a~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011110000111111110000111100001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_toggle_a~input_o\,
	datae => \ALT_INV_a[2]~input_o\,
	dataf => \latch_a|ALT_INV_q\(2),
	combout => \latch_a|q\(2));

-- Location: MLABCELL_X23_Y1_N39
\math_op|Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Add0~9_sumout\ = SUM(( \latch_a|q\(2) ) + ( (!\sub~input_o\ & (((\latch_b|q\(2))))) # (\sub~input_o\ & (!\latch_b|q\(3) & (!\latch_b|q\(1) $ (!\latch_b|q\(2))))) ) + ( \math_op|Add0~6\ ))
-- \math_op|Add0~10\ = CARRY(( \latch_a|q\(2) ) + ( (!\sub~input_o\ & (((\latch_b|q\(2))))) # (\sub~input_o\ & (!\latch_b|q\(3) & (!\latch_b|q\(1) $ (!\latch_b|q\(2))))) ) + ( \math_op|Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111110110001010100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_sub~input_o\,
	datab => \latch_b|ALT_INV_q\(3),
	datac => \latch_b|ALT_INV_q\(1),
	datad => \latch_a|ALT_INV_q\(2),
	dataf => \latch_b|ALT_INV_q\(2),
	cin => \math_op|Add0~6\,
	sumout => \math_op|Add0~9_sumout\,
	cout => \math_op|Add0~10\);

-- Location: IOIBUF_X34_Y0_N18
\a[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(3),
	o => \a[3]~input_o\);

-- Location: LABCELL_X12_Y1_N18
\latch_a|q[3]\ : cyclonev_lcell_comb
-- Equation(s):
-- \latch_a|q\(3) = ( \latch_a|q\(3) & ( (!\toggle_a~input_o\) # (\a[3]~input_o\) ) ) # ( !\latch_a|q\(3) & ( (\a[3]~input_o\ & \toggle_a~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000001111000000000000111111111111000011111111111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_a[3]~input_o\,
	datad => \ALT_INV_toggle_a~input_o\,
	dataf => \latch_a|ALT_INV_q\(3),
	combout => \latch_a|q\(3));

-- Location: MLABCELL_X23_Y1_N15
\math_op|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Mux0~0_combout\ = ( !\latch_b|q\(1) & ( (!\latch_b|q\(2) & !\latch_b|q\(3)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000100010001000100010001000100000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \latch_b|ALT_INV_q\(2),
	datab => \latch_b|ALT_INV_q\(3),
	dataf => \latch_b|ALT_INV_q\(1),
	combout => \math_op|Mux0~0_combout\);

-- Location: MLABCELL_X23_Y1_N42
\math_op|Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Add0~13_sumout\ = SUM(( \latch_a|q\(3) ) + ( (!\sub~input_o\ & (\latch_b|q\(3))) # (\sub~input_o\ & ((\math_op|Mux0~0_combout\))) ) + ( \math_op|Add0~10\ ))
-- \math_op|Add0~14\ = CARRY(( \latch_a|q\(3) ) + ( (!\sub~input_o\ & (\latch_b|q\(3))) # (\sub~input_o\ & ((\math_op|Mux0~0_combout\))) ) + ( \math_op|Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011111100000000000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \latch_a|ALT_INV_q\(3),
	datab => \latch_b|ALT_INV_q\(3),
	datac => \ALT_INV_sub~input_o\,
	dataf => \math_op|ALT_INV_Mux0~0_combout\,
	cin => \math_op|Add0~10\,
	sumout => \math_op|Add0~13_sumout\,
	cout => \math_op|Add0~14\);

-- Location: MLABCELL_X23_Y1_N45
\math_op|Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|Add0~17_sumout\ = SUM(( GND ) + ( GND ) + ( \math_op|Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	cin => \math_op|Add0~14\,
	sumout => \math_op|Add0~17_sumout\);

-- Location: MLABCELL_X23_Y1_N0
\math_op|sum[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|sum[1]~0_combout\ = ( \math_op|Add0~13_sumout\ & ( (!\math_op|Add0~5_sumout\ & ((\math_op|Add0~17_sumout\) # (\math_op|Add0~9_sumout\))) ) ) # ( !\math_op|Add0~13_sumout\ & ( !\math_op|Add0~5_sumout\ $ (!\math_op|Add0~17_sumout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010110101010010101011010101000100010101010100010001010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \math_op|ALT_INV_Add0~5_sumout\,
	datab => \math_op|ALT_INV_Add0~9_sumout\,
	datad => \math_op|ALT_INV_Add0~17_sumout\,
	dataf => \math_op|ALT_INV_Add0~13_sumout\,
	combout => \math_op|sum[1]~0_combout\);

-- Location: MLABCELL_X23_Y1_N3
\math_op|sum[2]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|sum[2]~1_combout\ = (!\math_op|Add0~5_sumout\ & ((!\math_op|Add0~9_sumout\ & ((\math_op|Add0~17_sumout\))) # (\math_op|Add0~9_sumout\ & (!\math_op|Add0~13_sumout\ & !\math_op|Add0~17_sumout\)))) # (\math_op|Add0~5_sumout\ & 
-- (\math_op|Add0~9_sumout\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000110011001001100011001100100110001100110010011000110011001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \math_op|ALT_INV_Add0~5_sumout\,
	datab => \math_op|ALT_INV_Add0~9_sumout\,
	datac => \math_op|ALT_INV_Add0~13_sumout\,
	datad => \math_op|ALT_INV_Add0~17_sumout\,
	combout => \math_op|sum[2]~1_combout\);

-- Location: MLABCELL_X23_Y1_N6
\math_op|sum[3]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|sum[3]~2_combout\ = ( \math_op|Add0~13_sumout\ & ( (!\math_op|Add0~5_sumout\ & !\math_op|Add0~9_sumout\) ) ) # ( !\math_op|Add0~13_sumout\ & ( (\math_op|Add0~17_sumout\ & ((\math_op|Add0~9_sumout\) # (\math_op|Add0~5_sumout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001110111000000000111011110001000100010001000100010001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \math_op|ALT_INV_Add0~5_sumout\,
	datab => \math_op|ALT_INV_Add0~9_sumout\,
	datad => \math_op|ALT_INV_Add0~17_sumout\,
	dataf => \math_op|ALT_INV_Add0~13_sumout\,
	combout => \math_op|sum[3]~2_combout\);

-- Location: MLABCELL_X23_Y1_N9
\math_op|LessThan0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \math_op|LessThan0~0_combout\ = ( \math_op|Add0~13_sumout\ & ( ((\math_op|Add0~17_sumout\) # (\math_op|Add0~9_sumout\)) # (\math_op|Add0~5_sumout\) ) ) # ( !\math_op|Add0~13_sumout\ & ( \math_op|Add0~17_sumout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111101111111011111110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \math_op|ALT_INV_Add0~5_sumout\,
	datab => \math_op|ALT_INV_Add0~9_sumout\,
	datac => \math_op|ALT_INV_Add0~17_sumout\,
	dataf => \math_op|ALT_INV_Add0~13_sumout\,
	combout => \math_op|LessThan0~0_combout\);

-- Location: LABCELL_X10_Y13_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


