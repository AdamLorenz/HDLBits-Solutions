module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    genvar i;
    generate
        for(i = 0; i < 100; i++) begin : g_ripple
            if(i == 0) begin
                full_adder1 lsb(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end else if(0 < i < 99) begin
                full_adder1 ripple(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i - 1]),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end else begin
                full_adder1 msb(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i - 1]),
                    .cout(cout[i]),
                    .sum(sum[i])
                );
            end
        end
    endgenerate
endmodule
        
module full_adder1(
    input 	a,
    input 	b,
    input 	cin,
    output 	cout,
    output 	sum
);
    assign sum 	= a ^ b ^ cin;
    assign cout = (a & b) | (a ^ b) & cin;
endmodule