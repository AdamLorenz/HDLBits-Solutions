module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [2:0] carry;
    fadd lsb(
        .x(x[0]),
        .y(y[0]),
        .cin(),
        .cout(carry[0]),
        .sum(sum[0])
    );
    fadd ripple_1(
        .x(x[1]),
        .y(y[1]),
        .cin(carry[0]),
        .cout(carry[1]),
        .sum(sum[1])
    );
    fadd ripple_2(
        .x(x[2]),
        .y(y[2]),
        .cin(carry[1]),
        .cout(carry[2]),
        .sum(sum[2])
    );
    fadd msb(
        .x(x[3]),
        .y(y[3]),
        .cin(carry[2]),
        .cout(sum[4]),
        .sum(sum[3])
    );
endmodule

module fadd (
    input 	x,
    input 	y,
    input 	cin,
    output 	cout,
    output 	sum
);
    assign sum 	= x ^ y ^ cin;
    assign cout = x & y | (x ^ y) & cin;
endmodule