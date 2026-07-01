module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    genvar i;
    generate
        for(i = 0; i < 8; i++) begin : dff8
            always @(posedge clk) begin
                q[i] <= d[i];
            end
        end
    endgenerate
endmodule