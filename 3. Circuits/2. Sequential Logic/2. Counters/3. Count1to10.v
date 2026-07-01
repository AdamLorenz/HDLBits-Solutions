module top_module (
    input clk,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin
        if(reset == 1'b1 | q == 4'b1010) begin
            q <= 4'b0001;
        end else begin
            q <= q + 4'b0001;
        end
    end
endmodule
