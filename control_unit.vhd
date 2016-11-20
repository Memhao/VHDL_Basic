use work.sumpack.all;
ENTITY control_unit IS
	GENERIC(delay : TIME:=50ns; N: INTEGER:=4); -- sincornizare pe front scazator -- r q a au clock  -aici se stabileste algoritmul
	PORT(
		clock : IN BIT;
		begins : IN BIT;
		c : OUT BIT_VECTOR(6 DOWNTO 0);
		--test out 
		va : INOUT BIT_VECTOR(3 DOWNTO 0);

		a_m:INOUT BIT_VECTOR(7 DOWNTO 0);
		q: INOUT BIT_VECTOR(4 DOWNTO 0) --5 bits 1 of them for op

	);
END control_unit;

ARCHITECTURE behave OF control_unit IS
TYPE states IS (s0, s1, s2, s3);
SIGNAL current_state, next_state : states:=s0;

	SIGNAL  f_s : BIT; --witch together with q(0) gives us next state
	CONSTANT ct_am : BIT_VECTOR(3 DOWNTO 0):="0000";
	CONSTANT ct_q : BIT_VECTOR(3 DOWNTO 0):="0011";
	CONSTANT ct_y : BIT_VECTOR(3 DOWNTO 0):="0101";
BEGIN
clock_process:PROCESS(clock)
BEGIN
	IF clock='0' AND clock'EVENT THEN
		current_state <= next_state;
	END IF;
END PROCESS clock_process;
state_transition_process:PROCESS(current_state,q)
	VARIABLE count :INTEGER:=0;
	VARIABLE a,aux_a,aux_q:BIT_VECTOR(3 DOWNTO 0);
	VARIABLE amshift:BIT_VECTOR(7 DOWNTO 0);
BEGIN
	CASE 	current_state IS 
		WHEN s0 =>
			a:=ct_am;

			a_m(7 downto 4)<=ct_am; -- initialize A register with 0000
			a_m(3 downto 0)<=ct_am; -- initialize M register with 0000
			--a_m<="00000001";
			q(4 downto 1)<=ct_y;
			q(0)<='0';

			f_s<='0';
			c<="0000001";
			IF q(1)='1' AND q(0)='0'  THEN
			 	next_state<= s1;
			END IF;
		WHEN s1 =>
			--------------------------------------------------------
			aux_a:=a_m(7 downto 4); --content of A
			a:=suma(aux_a,NOT ct_y,'1');--sub from A value of c2's y
			va<=a sra 1 after 100ns;
			amshift(7 downto 4):=a; -- reconstruct content of A_M
			amshift(3 downto 0):=a_m(3 downto 0);
			amshift := amshift sra 1 ; -- right shift arithm

			a_m <=amshift after 100ns; 	
			--------------------------------------------------------
			--q(0)<=q(1);
			--aux_q:= q(4 downto 1) srl 1; 
			--q(4 downto 1)<=aux_q;
			--------------------------------------------------------
			c<="0001001";
			--IF q(1)='1' AND q(0)='1' THEN
				next_state<= s2;
			--END IF;
		WHEN s2 =>
			aux_a:=a_m(7 downto 4); --content of A
			a:=suma(aux_a,ct_y,'0');--add from A value of c2's y
			va<=a sra 1 after 100ns;
			amshift(7 downto 4):=a; -- reconstruct content of A_M
			amshift(3 downto 0):=a_m(3 downto 0);
			amshift := amshift sra 1 ; -- right shift arithm

			a_m <=amshift after 200ns; 
			--c<="11001100";
			IF q(1)='0' AND q(0)='1' THEN
				next_state<= s1;
			END IF;
		WHEN others =>
			-- do nothing
	END CASE;
		
END PROCESS state_transition_process;
END behave;
