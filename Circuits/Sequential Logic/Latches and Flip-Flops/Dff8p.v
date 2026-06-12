module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    parameter RESET = 8'b110100; 
    always @(negedge clk) begin
        if(reset == 1'b1) begin
            q <= RESET;
        end else begin
            q <= d;
        end
    end
endmodule
