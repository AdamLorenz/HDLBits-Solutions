module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign ena[3:1] = 	{q[3:0] == 4'd9 && q[7:4] == 4'd9 && q[11:8] == 4'd9,
                  		 q[3:0] == 4'd9 && q[7:4] == 4'd9,
                  		 q[3:0] == 4'd9};
    decade dec_lsd(
        .clk	(clk),
        .enable	(1'b1),
        .reset	(reset),
        .q		(q[3:0])
    );
    decade dec_1(
        .clk	(clk),
        .enable	(ena[1]),
        .reset	(reset),
        .q		(q[7:4])
    );
    decade dec_2(
        .clk	(clk),
        .enable	(ena[2]),
        .reset	(reset),
        .q		(q[11:8])
    );
    decade dec_msd(
        .clk	(clk),
        .enable	(ena[3]),
        .reset	(reset),
        .q		(q[15:12])
    );
endmodule

module decade(
    input 			 clk,
    input 			 enable,
    input 			 reset,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if		(reset == 1 || (enable && q == 9))	q <= 0;
        else if	(enable == 1) 						q <= q + 1'b1;
    end
endmodule
