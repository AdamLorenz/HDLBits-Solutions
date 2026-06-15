module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin
        if(reset == 1) begin
            q <= '0;
        end else if(slowena == 1 && q == 9) begin
            q <= '0;
        end else if(slowena == 1 && q != 9) begin
            q <= q + 1'b1;
        end else
            q <= q;
    end
endmodule
