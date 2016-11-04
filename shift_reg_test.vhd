ENTITY shift_reg_test IS 
END shift_reg_test;
ARCHITECTURE behave OF shift_reg_test IS
	COMPONENT shift_register IS
	GENERIC(delay: TIME:=5ns; N: INTEGER:=8);
	PORT(
		clock : IN BIT:= '1';
		load : IN BIT;
		reset : IN BIT;
		shift : IN BIT; 
		serial_in : IN BIT; -- ce bit bag in fata 1 sau 0
		serial_out: OUT BIT;
		paralel_in : IN BIT_VECTOR(7 DOWNTO 0);
		paralel_out: OUT BIT_VECTOR(7 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT clk_generator IS
		GENERIC(t_high: TIME:=30ns; t_period: TIME:=50ns; t_reset: TIME:=10ns);
		PORT(
			clock : OUT BIT:='1';
			reset: OUT BIT
		);
	END COMPONENT;

	SIGNAL clock_s, reset_s,load_s,shift_s,serial_in_s,serial_out_s :BIT;
	SIGNAL paralel_in_s,paralel_out_s: BIT_VECTOR(7 DOWNTO 0);

	
BEGIN
	et1: shift_register GENERIC MAP(delay => 5ns, N => 8)
		PORT MAP (clock=> clock_s,load=>load_s, reset => reset_s,shift=>shift_s,  paralel_in=>paralel_in_s,paralel_out=>paralel_out_s,serial_in=>serial_in_s,serial_out=>serial_out_s);
	et2: clk_generator GENERIC MAP(t_high => 30ns, t_period => 100ns, t_reset => 30ns) PORT MAP(clock => clock_s, reset=>reset_s);
	
	load_s <= '0', '1' after 240ns, '0' after 440ns;
	paralel_in_s <= x"55" after 150ns;
	shift_s<= '0', '1' after 440ns;
	serial_in_s<= '1', '0' after 1000ns;
END behave;
