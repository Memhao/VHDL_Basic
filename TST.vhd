ENTITY tst IS
END tst;
ARCHITECTURE struct OF tst IS
COMPONENT and_gate IS
	GENERIC(del:TIME:=4ns);
	PORT(x:IN BIT;y:IN BIT;z:OUT BIT);
END COMPONENT;
COMPONENT not_gate IS
	GENERIC(tm:TIME:=1ns);
	PORT(a:IN BIT;b:OUT BIT);
END COMPONENT;
SIGNAL x1:BIT:='1';
SIGNAL y1:BIT:='0';
SIGNAL a1,b1:BIT;

BEGIN
	
END ARCHITECTURE struct;
