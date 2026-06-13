module top_module (
    input clk,
    input d,
    output q
);
	reg pos, neg;
    always @(posedge clk) begin
        pos <= d ^ neg;
    end
    always @(negedge clk) begin
    	neg <= d ^ pos;
    end
    assign q = neg ^ pos;
endmodule

// Alternatively, the below code will synthesize and simulate sucessfully,
// but in practice will cause glitches due to the metastability of the "pre" register's output
/*
module top_module (
    input clk,
    input d,
    output q
);
    reg pre;
    always @(posedge (pre ^ clk)) begin
        pre <= clk;
        q <= d;
    end
endmodule
*/
