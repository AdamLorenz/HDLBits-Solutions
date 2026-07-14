module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q1;
    wire [7:0] q2;
    wire [7:0] q3;
	my_dff8(
        .clk(clk),
        .d(d),
        .q(q1)
    );
    my_dff8(
        .clk(clk),
        .d(q1),
        .q(q2)
    );
    my_dff8(
        .clk(clk),
        .d(q2),
        .q(q3)
    );
    always_comb begin
    case(sel)
        2'b0:	q = d;
        2'b1:	q = q1;
        2'd2:	q = q2;
        2'd3:	q = q3;
    endcase
    end
endmodule