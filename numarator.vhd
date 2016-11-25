ENTITY numarator IS
	GENERIC( delay: TIME := 10ns);
	PORT(clock, reset, load: IN BIT;
		intrare_paralela: IN INTEGER;
		iesire: OUT INTEGER);
END numarator;

ARCHITECTURE behave OF numarator IS
--declaratii de semnale, componente, etc
BEGIN

PROCESS( clock, reset)
	VARIABLE temp: INTEGER;
BEGIN

	IF reset='0' THEN
		temp := 0;
	ELSIF clock='1' AND clock'EVENT and clock'LAST_VALUE='0' THEN
		IF load='1' THEN
			temp := intrare_paralela;
		ELSE
			temp := temp+1;
		END IF;
	END IF;

	iesire <= temp AFTER delay;
END PROCESS;

END ARCHITECTURE behave;

