use work.sumpack.all;
ENTITY control_unit IS
	GENERIC(delay : TIME:=50ns; N: INTEGER:=4); -- sincornizare pe front scazator -- r q a au clock  -aici se stabileste algoritmul
	PORT(
		clock : IN BIT;
		begins : IN BIT; --il dau de mana dupa reset
		reset : IN BIT; -- sa tin registrele pe 000 activ pe 1
		ctrl : OUT BIT_VECTOR(5 DOWNTO 0);--semnale de control
		sel  : IN BIT_VECTOR(1 DOWNTO 0);
		--test out 
		--va : INOUT BIT_VECTOR(3 DOWNTO 0);

		-- c0 incarca de pe magistrala A si M( la mine e Q :) )
		-- pe c1 incarc M
		-- pe c2 activez loadul de la registrul A
		-- pe c3 selectez intre adunare si scadere
		-- pe c4 activez  semnalul de shiftare a registrelor
		-- pune intarzieri la semnalele de control
		-- generatorul de tact sa fie 100ns
		-- registrele sa aiba reset load 
		-- ###############################################################
		count:INOUT INTEGER;
		a_m:INOUT BIT_VECTOR(7 DOWNTO 0);
		q: INOUT BIT_VECTOR(4 DOWNTO 0) --5 bits 1 of them for op
		-- ###############################################################
	);
END control_unit;

ARCHITECTURE behave OF control_unit IS
TYPE states IS (init,scan, sub, add, test,endstate); -- s0 -> init ; s1 -> sub ; s2->add ; s3->rshiftarithm
SIGNAL current_state, next_state : states:=init;

	SIGNAL  f_s : BIT; --witch together with q(0) gives us next state
	CONSTANT ct_am : BIT_VECTOR(3 DOWNTO 0):="0000";
	CONSTANT ct_q : BIT_VECTOR(3 DOWNTO 0):="0111";
	CONSTANT ct_y : BIT_VECTOR(3 DOWNTO 0):="0111";
BEGIN
clock_process:PROCESS(clock,reset)
BEGIN
	IF reset = '0' THEN
		current_state <=init;
	ELSIF clock='0' AND clock'EVENT THEN
		current_state <= next_state;
	END IF;
END PROCESS clock_process;
state_transition_process:PROCESS(current_state,q)
	VARIABLE count :INTEGER:=0;
	VARIABLE f:BIT;
	VARIABLE a,aux_a,aux_q:BIT_VECTOR(3 DOWNTO 0);
	VARIABLE aux_a_m, amshift:BIT_VECTOR(7 DOWNTO 0);
BEGIN
	CASE 	current_state IS 
		WHEN init => 
		-- ###############################################################
			a:=ct_am;
			-- load A and M register with 0
			a_m(7 downto 4)<=ct_am; -- initialize A register with 0000
			a_m(3 downto 0)<=ct_am; -- initialize M register with 0000
			-- load Q register with multiplier and init q(0) with 0 
			q(4 downto 1)<=ct_q;
			q(0)<='0';
		-- ###############################################################


			count:=0;
			ctrl<="000011" after 1ns; -- activate c0 and c1
			next_state<=scan;

		WHEN sub => -- substract
			IF count=N THEN
				next_state<=endstate;
			ELSE 
			aux_a:=a_m(7 downto 4); --content of A
			a:=suma(aux_a,NOT ct_y,'1');--sub from A value of c2's y
			--va<=a sra 1 after 100ns;
			aux_a_m(7 downto 4):=a; -- reconstruct content of A_M
			aux_a_m(3 downto 0):=a_m(3 downto 0);
			
			a_m <=aux_a_m after 100ns; 	
	

			next_state<=test;
			END IF;
		WHEN add =>  --addition
			IF count=N THEN
				next_state<=endstate;
			ELSE 
			aux_a:=a_m(7 downto 4); --content of A
			a:=suma(aux_a,ct_y,'0');--add from A value of c2's y
			--va<=a after 100ns;
			aux_a_m(7 downto 4):=a; -- reconstruct content of A_M
			aux_a_m(3 downto 0):=a_m(3 downto 0);
			
			a_m <=aux_a_m after 100ns; 

			next_state<=test;
			END IF;
		WHEN scan => -- decide next state
			IF q(1)='0' AND q(0)='1' THEN
				next_state<=add;
			ELSIF q(1)='1' AND q(0)='0' THEN
				next_state<=sub;
			ELSE
				next_state<=test;
			END IF;
		WHEN test =>
			IF count=N THEN
				next_state<=endstate;
			ELSE

				amshift := a_m sra 1 ; 
				a_m <= amshift after 100ns ;
				 -- right shift rotation for q
				f:=q(1);
				aux_q:= q(4 downto 1) ror 1; 
				q(4 downto 1)<=aux_q after 110ns;
				q(0)<=f after 110ns;

				-- increment counter
				count:= count+1;
				next_state<=scan;
			END IF;
			
		WHEN endstate=>
				next_state<=init;
		WHEN others =>
			-- do nothing
	END CASE;
		
END PROCESS state_transition_process;
END behave;
