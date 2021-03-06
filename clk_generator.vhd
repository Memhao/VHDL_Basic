ENTITY clk_generator is
	GENERIC(t_high: TIME:= 30ns; t_period: TIME:= 100ns; t_reset:TIME:=10ns);
	PORT(clock: OUT BIT:='1'; reset: OUT BIT);
END clk_generator;
ARCHITECTURE behave OF clk_generator IS
BEGIN
	reset<='0', '1' AFTER t_reset;
	PROCESS 
	BEGIN
		clock<='1','0' AFTER t_high;
		WAIT FOR t_period;
	END PROCESS;
END ARCHITECTURE;