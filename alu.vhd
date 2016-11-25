use work.sumpack.all;
ENTITY alu IS
	GENERIC(delay : TIME:=50ns; N: INTEGER:=8; OP: INTEGER:=2);
	PORT(
		OPERAND_A : IN BIT_VECTOR(N-1 DOWNTO 0);	
		OPERAND_B : IN BIT_VECTOR(N-1 DOWNTO 0);
		SEL_OP    : IN BIT_VECTOR(OP-1 DOWNTO 0);			

		OUTPUT : OUT BIT_VECTOR(N-1 DOWNTO 0)
	);
END alu;
ARCHITECTURE behave_alu OF alu IS
BEGIN

PROCESS(OPERAND_A,OPERAND_B,SEL_OP)

BEGIN
	case sel_op(1) & sel_op(0) is
		when "10"  =>
			OUTPUT <= suma(OPERAND_A,NOT OPERAND_B,'1') after 1ns;
		when "01" =>
			OUTPUT <= suma(OPERAND_A,OPERAND_B,'0') after 1ns;
		when others => -- no action
 	END CASE;
END PROCESS;
END behave_alu;