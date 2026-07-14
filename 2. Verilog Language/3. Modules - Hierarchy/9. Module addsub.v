module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] w_b_sub;
    wire w_crry;
    add16 lo_16 (
        .a(a[15:0]),
        .b(w_b_sub[15:0]),
        .cin(sub),
        .sum(sum[15:0]),
        .cout(w_crry)
    );
     add16 hi_16 (
         .a(a[31:16]),
         .b(w_b_sub[31:16]),
         .cin(w_crry),
         .sum(sum[31:16]),
         .cout()
    );
    assign w_b_sub = b ^ {32{sub}};
   
endmodule