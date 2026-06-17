module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    muxdff zero(
        .clk(KEY[0]),
        .w(LEDR[1]),
        .R(SW[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[0])
    );
    muxdff one(
        .clk(KEY[0]),
        .w(LEDR[2]),
        .R(SW[1]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[1])
    );
    muxdff two(
        .clk(KEY[0]),
        .w(LEDR[3]),
        .R(SW[2]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[2])
    );
    muxdff three(
        .clk(KEY[0]),
        .w(KEY[3]),
        .R(SW[3]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[3])
    );
endmodule

module muxdff (
    input clk,
    input w, R, E, L,
    output Q
);
	wire w_mux0;
    wire w_mux1;
    always @(*) begin
        case(E)
            1'b0: w_mux0 <= Q;
            1'b1: w_mux0 <= w;
        endcase
        case(L)
            1'b0: w_mux1 <= w_mux0;
            1'b1: w_mux1 <= R;
        endcase
    end
    always @(posedge clk) begin
        Q <= w_mux1;
    end
endmodule
