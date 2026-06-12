module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
	genvar i;
    generate
        for(i = 0; i < 8; i++) begin : dff8ar
            always @(posedge clk, posedge areset) begin
                if(areset == 1'b1) begin
                    q[i] <= 1'b0;
                end else begin
                    q[i] <= d[i];
            	end
            end
        end
    endgenerate     
endmodule
