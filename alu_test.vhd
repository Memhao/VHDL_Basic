ENTITY alu_test IS 
END alu_test;
ARCHITECTURE behave_alu OF alu_test IS
	COMPONENT alu IS
	GENERIC(delay : TIME:=50ns; N: INTEGER:=8; OP: INTEGER:=2);
	PORT(
		OPERAND_A : IN BIT_VECTOR(N-1 DOWNTO 0);	
		OPERAND_B : IN BIT_VECTOR(N-1 DOWNTO 0);
		SEL_OP    : IN BIT_VECTOR(OP-1 DOWNTO 0);			
		CLOCK     : IN BIT:= '1';
		reset :IN BIT;
		OUTPUT : OUT BIT_VECTOR(N-1 DOWNTO 0);
		CARRYOUT : OUT BIT
	);
	END COMPONENT;

	COMPONENT clk_generator IS
		GENERIC(t_high: TIME:=30ns; t_period: TIME:=50ns; t_reset: TIME:=10ns);
		PORT(
			clock : OUT BIT:='1';
			reset: OUT BIT
		);
	END COMPONENT;

	SIGNAL clock_s,carryout_s ,reset_s: BIT;
	SIGNAL SEL_OP_s : BIT_VECTOR(1 DOWNTO 0);
	SIGNAL OPERAND_A_s,OPERAND_B_s,OUTPUT_s: BIT_VECTOR(7 DOWNTO 0);

	
BEGIN
	et1: alu GENERIC MAP(delay => 50ns,N=>8,OP=>2)
		PORT MAP (OPERAND_A => OPERAND_A_s,OPERAND_B=>OPERAND_B_s,SEL_OP=>SEL_OP_s,CLOCK=>clock_s,reset=>reset_s,OUTPUT=>OUTPUT_s,CARRYOUT=>carryout_s);
	et2: clk_generator GENERIC MAP(t_high => 30ns, t_period => 100ns, t_reset => 30ns) PORT MAP(clock => clock_s, reset=>reset_s);
	
	OPERAND_A_s<=x"FF" after 100ns;
	OPERAND_B_s<=x"00" after 100ns;
	SEL_OP_s<=b"00" after 110ns, b"10" after 150ns, b"11" after 200ns;
END behave_alu;
