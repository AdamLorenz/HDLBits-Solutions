module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	parameter 	START 	= 2'd0,
    			CARRY 	= 2'd1,
    			ZERO 	= 2'd2,
    			ONE	 	= 2'd3;
    reg [1:0] state;
    wire [1:0] next_state;
    
    always @(*) begin
        case(state)
            START: 	next_state = x ? ONE  : CARRY;
            CARRY:	next_state = x ? ONE  : CARRY;
            ZERO:	next_state = x ? ZERO : ONE;
            ONE:	next_state = x ? ZERO : ONE;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset)	state <= START;
        else		state <= next_state;
    end
    
    assign z = (state == ONE);
        
endmodule
