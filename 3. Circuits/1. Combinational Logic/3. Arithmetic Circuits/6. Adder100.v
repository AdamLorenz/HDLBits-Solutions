module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    wire [100:0]sum_temp;
    assign sum_temp = a + b + cin;
    assign cout = sum_temp[100];
    assign sum = sum_temp[99:0];
endmodule