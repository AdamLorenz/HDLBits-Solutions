module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);
    reg [2:0] i;
    
    always @(posedge clk) begin
        if      (reset)	i <= '0;
        else if (i < 4)	i <= i + 1'b1;
    end
    
    assign shift_ena = (i < 4);
            
endmodule
