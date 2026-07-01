module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack
);
	parameter	S 		= 3'd0,
    			S1 		= 3'd1,
                S11 	= 3'd2,
                S110 	= 3'd3,
                B 		= 3'd4,
    			COUNT 	= 3'd5,
    			WAIT	= 3'd6;
    reg  [2:0] state;
    wire [2:0] next_state;
    reg  [2:0] count;
    reg  [3:0] q;
    
    always @(*) begin
        case(state)
            S:		next_state = data ? S1 	: S;
            S1:		next_state = data ? S11 : S;
            S11:	next_state = data ? S11 : S110;
            S110:	next_state = data ? B 	: S;
            B:		next_state = (count == 3) ? COUNT : B;
            COUNT:	next_state = done_counting ? WAIT : COUNT;
            WAIT:	next_state = ack ? S : WAIT;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)	state <= S;
        else		state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) begin
        	count <= '0;
        end
        else if (state == B) begin 
            count <= count + 1'b1; 
            q <= {q[2:0], data};
		end
        else count <= '0;
    end
    
    assign shift_ena = (state == B);
    assign counting  = (state == COUNT);
    assign done 	 = (state == WAIT);
    
endmodule
