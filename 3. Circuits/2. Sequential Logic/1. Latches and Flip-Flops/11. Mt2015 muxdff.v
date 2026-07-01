module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    wire w_d;
    always @(*) begin
        case(L)
            1'b0: w_d <= q_in;
            1'b1: w_d <= r_in;
        endcase
    end
    always @(posedge clk) begin
        Q <= w_d;
    end
endmodule
