module top_module ( 
    input 	p1a, p1b, p1c, p1d, p1e, p1f,
    output 	p1y,
    input 	p2a, p2b, p2c, p2d,
    output 	p2y 
);
	wire 	w_2ab,
    		w_2cd,
    		w_1abc,
    		w_1def;
    assign 	w_2ab 	= p2a & p2b,
        	w_2cd 	= p2c & p2d,
        	w_1abc	= p1a & p1b & p1c,
        	w_1def 	= p1d & p1e & p1f,
    		p2y 	= w_2ab | w_2cd,
    		p1y 	= w_1abc | w_1def;
endmodule
