module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
	genvar i;
    generate
        for(i = 0; i < 8; i++) begin : dff8r
            always @(posedge clk) begin
                if(reset == 1'b1) begin
                    q[i] <= 1'b0;
                end	else begin
                    q[i] <= d[i];
                end
            end
        end
    endgenerate     
endmodule