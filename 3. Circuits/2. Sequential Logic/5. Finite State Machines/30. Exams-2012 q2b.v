module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    assign Y1 = w & y[0];
    assign Y3 = ~w & |{y[5:4], y[2:1]};
endmodule
