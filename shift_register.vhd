ENTITY shift_register IS
	GENERIC(delay: TIME:=5ns ; N: INTEGER:=8);
	PORT(
		clock : IN BIT:= '1';
		load : IN BIT;
		reset: IN BIT;
		shift : IN BIT; 
		serial_in : IN BIT; -- ce bit bag in fata 1 sau 0
		serial_out: OUT BIT;
		paralel_in : IN BIT_VECTOR(N-1 DOWNTO 0);
		paralel_out: OUT BIT_VECTOR(N-1 DOWNTO 0)
	);
END shift_register;
ARCHITECTURE behave_shift of shift_register IS
BEGIN
	PROCESS(clock,load,reset)
	VARIABLE temp : BIT_VECTOR(N-1 DOWNTO 0);
	VARIABLE sout : BIT;
	BEGIN
	IF reset = '0' THEN
		temp:=(0 => '0', others => '0');
	ELSIF clock = '1' AND clock'EVENT THEN
		IF load ='1' THEN
			temp:= paralel_in;
		ELSIF shift='1' THEN
			sout := temp(0);
			temp := temp srl 1;
			temp(7):=serial_in;
		END IF;
	END IF;
	paralel_out <= temp AFTER delay;
	serial_out <= sout AFTER delay;
	END PROCESS;
END behave_shift;