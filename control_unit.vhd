ENTITY control_unit IS
	GENERIC(delay : TIME:=50ns);
	PORT(
		clock : IN BIT;
		begins : IN BIT;
		m: IN BIT; -- assert loadA or not

		ends : OUT BIT;
		load_i: OUT BIT; -- incarca datele in registii operanzilor 
		clear_a: OUT BIT; -- sterge continutul registrului a
		load_a: OUT BIT; -- incarca continutul registrului a cu rezultatul adunarii
		shift: OUT BIT; -- shifteaza continutul acumulatorului si a inmultitorului(coeficient)
		add_sub: OUT BIT; -- select the operation
		reset_f : OUT BIT -- reset the flip flop
		
	);
END control_unit;

ARCHITECTURE behave OF control_unit IS
BEGIN
END behave;
