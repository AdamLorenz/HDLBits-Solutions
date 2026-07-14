`timescale 1ps / 1ps
module top_module();
    reg [1:0] in;
    wire out;
    
    initial begin
        in = '0;
        #10 
        in[0] = 1'b1;
        #10;
        in[1] = 1'b1;
        in[0] = 1'b0;
        #10 
        in[0] = 1'b1;
    end
    
    andgate tb_andgate(
        .in(in),
        .out(out)
    );
endmodule