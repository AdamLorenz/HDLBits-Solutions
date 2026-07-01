module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);
    assign c_enable = enable;
    assign c_d = 4'b0001;
    assign c_load = (enable && Q == 12) || reset == 1;
    
    count4 the_counter (
        .clk(clk),
        .enable(c_enable),
        .load(c_load),
        .d(c_d),
        .Q(Q)
    );
endmodule
