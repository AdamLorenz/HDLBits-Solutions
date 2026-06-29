module top_module ();
	reg clk, reset, t;
    wire q;
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        t = 0;
        #10 
        reset = 0;
        t = 1;
    end
    
    tff tb_tff(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );
    
endmodule
