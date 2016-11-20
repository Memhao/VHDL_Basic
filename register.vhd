ENTITY register_r IS 
	GENERIC (N: NATURAL:=4);
	PORT(
		input: IN BIT_VECTOR(N-1 DOWNTO 0);
		output: OUT BIT_VECTOR(N-1 DOWNTO 0);
		clock : IN BIT;
		reset : IN BIT;
		load: IN BIT
	);
END;
ARCHITECTURE reg_behave OF register_r IS
BEGIN
PROCESS(clock,load,reset)
BEGIN
	IF reset = '0' THEN
		output<=(0 => '0', others => '0');
	ELSIF clock = '1' AND clock'EVENT THEN
		IF load = '1' THEN
			output <= input;
		END IF;
	END IF;
END PROCESS;
END reg_behave;