ENTITY counter IS
	GENERIC(delay: TIME:= 10ns; n: INTEGER:=3);
	PORT( 
		clock, reset, load : IN BIT;
		paralel_in : IN INTEGER;
		serial_out : OUT INTEGER
);
END counter;

ARCHITECTURE behavior OF counter IS
BEGIN
	PROCESS(clock, reset)
		VARIABLE temp: INTEGER;
		VARIABLE local_out: INTEGER;

	BEGIN
		IF reset = '0' THEN 
			    temp:=0;
		ELSIF clock = '1' AND clock'EVENT AND clock'LAST_VALUE = '0' THEN
			IF load='1' THEN
				temp:= paralel_in;
			ELSE
				temp:= temp+1;
				local_out:=temp mod n;
			END IF;
		END IF;
		serial_out <= local_out after delay;
	END PROCESS;

END behavior;
