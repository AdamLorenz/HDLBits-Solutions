// Note the Verilog-1995 module declaration syntax here:
module top_module(
    input clk,
    input reset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A= 1'b0, B= 1'b1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case(in)
            1'b0:	next_state = ~state;
            default:next_state = state;
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (reset) state <= B;
        else state <= next_state;
    end
    // Output logic
	assign out = (state == B);  
 
endmodule
