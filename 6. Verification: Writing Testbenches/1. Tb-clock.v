`timescale 1ps / 1ps 
module top_module ();
	reg clk;
    initial clk = 0;
    always #5 clk = ~clk;
    dut test(.clk(clk));
endmodule
