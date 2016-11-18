ENTITY alu_test IS 
END alu_test;
ARCHITECTURE behave_alu OF alu_test IS
	COMPONENT alu IS
	GENERIC(delay : TIME:=50ns; N: INTEGER:=8; OP: INTEGER:=2);
	PORT(
		OPERAND_A : IN BIT_VECTOR(N-1 DOWNTO 0);	
		OPERAND_B : IN BIT_VECTOR(N-1 DOWNTO 0);
		SEL_OP    : IN BIT_VECTOR(OP-1 DOWNTO 0);			

		OUTPUT : OUT BIT_VECTOR(N-1 DOWNTO 0)
	);
	END COMPONENT;

	SIGNAL SEL_OP_s : BIT_VECTOR(1 DOWNTO 0);
	SIGNAL OPERAND_A_s,OPERAND_B_s,OUTPUT_s: BIT_VECTOR(7 DOWNTO 0);

	
BEGIN
	et1: alu  GENERIC MAP(delay => 50ns,N=>8,OP=>2)
		PORT MAP (OPERAND_A => OPERAND_A_s,OPERAND_B=>OPERAND_B_s,SEL_OP=>SEL_OP_s,OUTPUT=>OUTPUT_s);

	SEL_OP_s<=b"10" after 50ns, b"00" after 200ns, b"10" after 300ns, b"00" after 400ns, b"11" after 500ns, b"01" after 600ns;
	OPERAND_A_s<=x"03" after 100ns;
	OPERAND_B_s<=x"02" after 100ns;
	
END behave_alu;
