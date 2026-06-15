module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    always @(posedge clk) begin
        if(reset == 1 | q == 4'b1001) begin
            q <= 4'b0000;
        end else begin
            q <= q + 4'b0001;
        end
    end
endmodule
