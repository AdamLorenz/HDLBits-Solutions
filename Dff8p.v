module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    parameter RESET = 8'b110100; 
    genvar i;
    generate
        for(i = 0; i < 8; i++) begin : dff8p
            always @(negedge clk) begin
                if(reset == 1'b1) begin
                    q[i] = RESET[i];
                end else begin
                    q[i] <= d[i];
                end
            end
        end
    endgenerate
endmodule
