ENTITY control_unit_test IS 
END control_unit_test;
ARCHITECTURE behave_control_unit_test OF control_unit_test IS




COMPONENT clk_generator IS
		GENERIC(t_high: TIME:=30ns; t_period: TIME:=50ns; t_reset: TIME:=10ns);
		PORT(
			clock : OUT BIT:='1';
			reset: OUT BIT
		);
END COMPONENT;
COMPONENT control_unit IS
	GENERIC(delay : TIME:=50ns;N: INTEGER:=4); -- sincornizare pe front scazator -- r q a au clock  -aici se stabileste algoritmul
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
END COMPONENT;

SIGNAL clock_s, reset_s :BIT;
SIGNAL begins_s:BIT;
SIGNAL sel_s :  BIT_VECTOR(1 DOWNTO 0);
SIGNAL ctrl_s:BIT_VECTOR(5 DOWNTO 0);
SIGNAL a_m_s:BIT_VECTOR(7 DOWNTO 0);
SIGNAL q_s:BIT_VECTOR(4 DOWNTO 0);

SIGNAL count_s:INTEGER;
BEGIN

et2a: clk_generator GENERIC MAP(t_high => 30ns, t_period => 100ns, t_reset => 30ns)
	 PORT MAP(clock => clock_s, reset=>reset_s);
et1a: control_unit GENERIC MAP(delay => 50ns,N =>4) PORT MAP(clock=>clock_s,begins=>begins_s,reset=>reset_s,sel=>sel_s,ctrl=>ctrl_s,count=>count_s,a_m=>a_m_s,q=>q_s);	

END behave_control_unit_test;