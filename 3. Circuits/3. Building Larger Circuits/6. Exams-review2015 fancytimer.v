module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
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
    reg  [2:0] i;
    reg  [9:0] j;
    reg  [3:0] q;
    
    always @(*) begin
        case(state)
            S:		next_state = data ? S1 	: S;
            S1:		next_state = data ? S11 : S;
            S11:	next_state = data ? S11 : S110;
            S110:	next_state = data ? B 	: S;
            B:		next_state = (i == 3'd3) ? COUNT : B;
            COUNT:	next_state = (q == '0 && j == 10'd999) ? WAIT : COUNT;
            WAIT:	next_state = ack ? S : WAIT;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)	state <= S;
        else		state <= next_state;
    end
    
    always @(posedge clk) begin
        if (state == B) begin
            q <= {q[2:0], data};
            i <= i + 1'b1;
        end 
        else if (state == COUNT) begin
            if (j == 10'd999) begin
                q <= q - 1'b1;
                j <= '0;
            end
            else j <= j + 1'b1;
        end
        else begin 
            i <= '0;
            j <= '0;
        end
    end
    
    assign count = q;
    assign counting  = (state == COUNT);
    assign done 	 = (state == WAIT);
    
endmodule
