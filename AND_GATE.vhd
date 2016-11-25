ENTITY and_gate IS
	GENERIC(delay:TIME:=4ns);
	PORT(x: IN BIT; y: IN BIT; z: OUT BIT);
END and_gate;

ARCHITECTURE behave OF and_gate IS

BEGIN
	z <= x AND y AFTER delay;
END behave;

ARCHITECTURE struct OF and_gate IS
COMPONENT and_gate IS
	GENERIC( delay: TIME:=4ns);
	PORT(x: IN BIT; y: IN BIT; z:OUT BIT);
END COMPONENT;
	SIGNAL x1,y1,z1: BIT;
BEGIN
	--sx <= '1' after 100ns;
	--or1: and_gate PORT MAP(z=>z1,y=>y1,x=>x1);
END ARCHITECTURE struct;