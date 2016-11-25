ENTITY xor_gate IS
	GENERIC(delay: TIME:=4ns);
	PORT(x : IN BIT; y: IN BIT; z: OUT BIT);
END xor_gate;

ARCHITECTURE behave OF xor_gate IS
BEGIN
	z <= x XOR y AFTER delay;
END ARCHITECTURE behave;


ARCHITECTURE struct OF xor_gate IS
COMPONENT xor_gate IS
	GENERIC(delay: TIME:=4ns);
	PORT(x:IN BIT;y:IN BIT;z:OUT BIT);
END COMPONENT xor_gate;
SIGNAL xa,ya,za : BIT;
BEGIN
	xorlabel: xor_gate PORT MAP(x=>xa,y=>ya,z=>za);
END ARCHITECTURE struct;