ENTITY control_unit IS
	GENERIC(delay : TIME:=50ns); -- sincornizare pe front scazator -- r q a au clock  -aici se stabileste algoritmul
	-- cum testatm ctrl unit
	-- vezi pseudo cod pas 1 INBUS ...
	-- fiecare e o stare

	-- stare de test separat in care numa testez nu activeaza semnal de iesire
	-- when case current_st is
	--	=> s0 next state is ...
	-- cand se afla intr-o stare se seteaza anumite iesiri 
	-- declar a m q intern sa testez ca vectori de biti
	-- pune delay la semnalele de shift clear etc....
	
	PORT(
		clock : IN BIT;
		begins : IN BIT;
		op : IN BIT_VECTOR(1 DOWNTO 0);
		--m: IN BIT; -- assert loadA or not
		--registrele functioneaza pe frontul crescator al clk 
		ends : OUT BIT;
		load_i: OUT BIT; -- incarca datele in registii operanzilor 
		clear_a: OUT BIT; -- sterge continutul registrului a
		load_a: OUT BIT; -- incarca continutul registrului a cu rezultatul adunarii
		shift: OUT BIT; -- shifteaza continutul acumulatorului si a inmultitorului(coeficient)
		add_sub: OUT BIT; -- select the operation
		reset_f : OUT BIT -- reset the flip flop for q(-1)
		
	);
END control_unit;

ARCHITECTURE behave OF control_unit IS
TYPE states IS (s0, s1, s2, s3);
SIGNAL current_state, next_state : states:=s0;
	SIGNAL  a,m,q: BIT_VECTOR(3 DOWNTO 0);
	SIGNAL  c_0,c_1 : BIT;
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
state_transition_process:PROCESS(current_state,op)
	VARIABLE count :INTEGER:=0;
BEGIN
	CASE 	current_state IS 
		WHEN s0 =>
			a<=ct_am;
			m<=ct_am;
			q<=ct_y;
			c_0<=q(0);
			c_1<='0';
		WHEN others =>
			-- do nothing
	END CASE;
		
END PROCESS state_transition_process;
END behave;
