module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] pre;
    always @(posedge clk) begin
        pre <= in;
        anyedge <= in ^ pre;
    end
endmodule
