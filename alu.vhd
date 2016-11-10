ENTITY alu IS
	GENERIC(delay : TIME:=50ns; N: INTEGER:=8; OP: INTEGER:=2);
	PORT(
		OPERAND_A : IN BIT_VECTOR(N-1 DOWNTO 0);	
		OPERAND_B : IN BIT_VECTOR(N-1 DOWNTO 0);
		SEL_OP    : IN BIT_VECTOR(OP-1 DOWNTO 0);			
		CLOCK     : IN BIT:= '1';
		reset : IN BIT;
		OUTPUT : OUT BIT_VECTOR(N-1 DOWNTO 0);
		CARRYOUT : OUT BIT
	);
END alu;
ARCHITECTURE behave_alu OF alu IS
BEGIN


PROCESS(clock,sel_op)
	VARIABLE temp_a : BIT_VECTOR(N-1 DOWNTO 0);
	VARIABLE temp_b : BIT_VECTOR(N-1 DOWNTO 0);
	VARIABLE temp_res: BIT_VECTOR(N DOWNTO 0);
	VARIABLE ovr : BIT;
	BEGIN
	IF clock = '1' AND clock'EVENT THEN
		IF sel_op(0) ='0' AND sel_op(1)='0' THEN
			temp_a:= OPERAND_A;
			temp_b:= OPERAND_B;
		ELSIF sel_op(0) ='0' AND sel_op(1)='1' THEN
			temp_res := temp_a xor temp_b ;
		ELSIF sel_op(0) ='1' AND sel_op(1)='0' THEN
			temp_res := temp_a xor not temp_b ;
		END IF;
	END IF;
	OUTPUT<= temp_res(N-1 DOWNTO 0);
	CARRYOUT <= temp_res(N);
	END PROCESS;
END behave_alu;