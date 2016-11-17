ENTITY d_flip_flop IS
PORT(	d:	IN BIT; -- data
	clk:		IN BIT; -- clk
	q:	OUT BIT; -- output
 	q_n:  	OUT BIT -- !output
);
END d_flip_flop;
ARCHITECTURE behave OF d_flip_flop IS
BEGIN
	process(clk,d)
	BEGIN
	IF (clk='1' and clk'EVENT) then 
		q <= d;
		q_n <= not d;
	END IF; -- else branch is not very usefull because no change occurs in memory state
	END PROCESS;
END behave;