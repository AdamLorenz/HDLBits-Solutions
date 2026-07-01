module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
	wire [98:0]carry;
    genvar i;
    generate
        for(i = 0; i < 100; i++) begin : bcd_ripple_add
            if(i == 0) begin
                bcd_fadd lsb(
                    .a(a[4*i + 3:4*i]),
                    .b(b[4*i + 3:4*i]),
                    .cin(cin),
                    .cout(carry[i]),
                    .sum(sum[4*i + 3:4*i])
                );
            end else if(0 < i && i < 99) begin
                bcd_fadd ripple(
                    .a(a[4*i + 3:4*i]),
                    .b(b[4*i + 3:4*i]),
                    .cin(carry[i - 1]),
                    .cout(carry[i]),
                    .sum(sum[4*i + 3:4*i])
                );
            end else begin
                bcd_fadd msb(
                    .a(a[4*i + 3:4*i]),
                    .b(b[4*i + 3:4*i]),
                    .cin(carry[i - 1]),
                    .cout(cout),
                    .sum(sum[4*i + 3:4*i])
                ); 
            end
        end
    endgenerate
endmodule