use work.sumpack.all;
entity stud1 is
end;

architecture a of stud1 is
	signal s1, s2, sumas: bit_vector(7 downto 0):=x"03";
	signal cin: bit:='0';
begin
	s1 <= x"01" after 50ns, x"0e" after 300ns;
	s2 <= x"09" after 100ns;
	sumas <= suma(s1, s2, cin);
end;
