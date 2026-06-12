module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] pre;
    always @(posedge clk) begin
        pre <= in;
        if(reset == 1) begin
            out <= '0;
        end else begin
            out <= (pre & ~in) | out;
        end
    end
endmodule
