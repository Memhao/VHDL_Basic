ENTITY not_gate IS 
	GENERIC(delay: TIME:= 1ns);
	PORT (x: IN BIT; y: OUT BIT);
END not_gate;

ARCHITECTURE behave OF not_gate IS
	-- comportamental
BEGIN
	y <= NOT x AFTER delay;
END behave;


ARCHITECTURE struct OF not_gate IS
COMPONENT not_gate IS 
	GENERIC(delay: TIME:= 1ns);
	PORT (x: IN BIT; y: OUT BIT);
END COMPONENT;
	SIGNAL sin, sout : BIT;
BEGIN	
	not1: not_gate PORT MAP(y=>sout, x=>sin);
END ARCHITECTURE struct ;
	   