ENTITY test IS 
END test;

ARCHITECTURE behave OF test IS
	COMPONENT counter IS	
		GENERIC( delay: TIME:= 10ns ; n: INTEGER:=5);
		PORT(
			clock,reset,load: IN BIT;
			paralel_in: IN INTEGER;
			serial_out: OUT INTEGER
		);
	END COMPONENT;

	COMPONENT clk_generator IS
		GENERIC(t_high: TIME:=30ns; t_period: TIME:=50ns; t_reset: TIME:=10ns);
		PORT(
			clock : OUT BIT:='1';
			reset: OUT BIT
		);
	END COMPONENT;
	SIGNAL clock_s, reset_s,load_s :BIT;
	SIGNAL paralel_in_s: INTEGER:= 10;
	SIGNAL out_s : INTEGER;
	
BEGIN
	et1: counter GENERIC MAP(delay => 5ns, n => 9)
		PORT MAP (clock=> clock_s, reset => reset_s, load=>load_s, paralel_in=>paralel_in_s,serial_out=>out_s);
	et2: clk_generator GENERIC MAP(t_high => 30ns, t_period => 100ns, t_reset => 30ns) PORT MAP(clock => clock_s, reset=>reset_s);
	load_s <= '0', '1' after 240ns, '0' after 440ns;
	paralel_in_s <= 100 after 150ns;
END behave;

