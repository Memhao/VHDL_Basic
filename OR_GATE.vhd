ENTITY or_gate IS
	GENERIC(delay:TIME:=4ns);
	PORT (x: IN BIT ;y: IN BIT; z: OUT BIT);
END or_gate;

ARCHITECTURE behave OF or_gate IS
BEGIN
	z <= x OR y AFTER delay;
END behave;

ARCHITECTURE struct OF or_gate IS
COMPONENT or_gate IS
	GENERIC(delay: TIME:=4ns);
	PORT (x: IN BIT ;y: IN BIT; z: OUT BIT);
END COMPONENT;

	SIGNAL sx, sy, sz : BIT;
BEGIN
	--sx <= '1' after 100ns;
	or1: or_gate PORT MAP(z=>sz,y=>sy,x=>sx);
END ARCHITECTURE struct;