module top_module (input x, input y, output z);
    wire [3:0] temp;
    circuit_a inst1 (
        .x(x),
        .y(y),
        .z(temp[0])
    );
    circuit_b inst2 (
        .x(x),
        .y(y),
        .z(temp[1])
    );
    circuit_a inst3 (
        .x(x),
        .y(y),
        .z(temp[2])
    );
    circuit_b inst4 (
        .x(x),
        .y(y),
        .z(temp[3])
    );
    wire top;
    wire bot;
    assign top = temp[0] | temp[1];
    assign bot = temp[2] & temp[3];
    assign z = top ^ bot;
endmodule

module circuit_b (
    input 	x,
    input 	y,
    output 	z
);
    assign z = x ~^ y;
endmodule

module circuit_a (
    input 	x,
    input	y,
    output	z
);
    assign z = (x^y) & x;
endmodule