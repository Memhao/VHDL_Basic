package sumpack is
	function suma(op1, op2: bit_vector; cin: bit) return bit_vector;
end sumpack;

package body sumpack is
	function suma(op1, op2: bit_vector; cin: bit) return bit_vector is
		variable carry_temp: bit;
		variable res: bit_vector(op1'high downto op1'low);
	begin
		carry_temp:= cin;
		for i in op1'low to op1'high loop
			res(i):= op1(i) xor op2(i) xor carry_temp;
			carry_temp:= (op1(i) and op2(i)) or (op1(i) and carry_temp) or (op2(i) and carry_temp);
		end loop;
		return res;
	end function;
end package body;
