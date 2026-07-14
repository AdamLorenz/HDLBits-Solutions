module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire w_mux_slct;
    wire [15:0] w_sum_crry_lo;
    wire [15:0] w_sum_crry_hi;
    add16 crry_slct (
        .a(a [15:0]),
        .b(b [15:0]),
        .cin(1'b0),
        .sum(sum[15:0]),
        .cout(w_mux_slct)
    );
    add16 crry_lo (
        .a(a [31:16]),
        .b(b [31:16]),
        .cin(1'b0),
        .sum(w_sum_crry_lo),
        .cout()
    );
    add16 crry_hi (
        .a(a [31:16]),
        .b(b [31:16]),
        .cin(1'b1),
        .sum(w_sum_crry_hi),
        .cout()
    );
    always @(*) begin
        case(w_mux_slct)
            1'b1:		sum[31:16] <= w_sum_crry_hi;
            1'b0:		sum[31:16] <= w_sum_crry_lo;
            default:	sum[31:16] <= 16'b0;
        endcase
    end

endmodule