module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);
    
    wire [7:0]w_temp_1;
    wire [7:0]w_temp_2;
    assign w_temp_1 = a < b 		? a : b;
    assign w_temp_2 = w_temp_1 < c 	? w_temp_1 : c;
    assign min 		= w_temp_2 < d 	? w_temp_2 : d;
	
endmodule