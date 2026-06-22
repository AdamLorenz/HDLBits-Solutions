module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
); 
    parameter 	LEFT 	= 3'd0, 
    			RIGHT 	= 3'd1,
    			FALL_R 	= 3'd2,
    			FALL_L  = 3'd3,
    			DIG_R	= 3'd4,
    			DIG_L	= 3'd5,
    			SPLAT	= 3'd6;
    reg  [2:0] state; 
    wire [2:0] next_state;
    integer count;
    
    always @(*) begin
        // State transition logic
        case(state)
            LEFT: begin
                if (!ground)			next_state = FALL_L;
                else if (dig) 			next_state = DIG_L;
                else if (bump_left)		next_state = RIGHT;
                else					next_state = LEFT;
            end
            RIGHT:	begin
                if      (!ground)		next_state = FALL_R;
                else if (dig) 			next_state = DIG_R;
                else if (bump_right)	next_state = LEFT;
                else					next_state = RIGHT;
            end
            FALL_L: begin
                if      (ground && count < 20) 	next_state = LEFT;
                else if (ground && count >= 20) next_state = SPLAT;
                else							next_state = FALL_L;
            end
            FALL_R:	begin
                if      (ground && count < 20) 	next_state = RIGHT;
                else if (ground && count >= 20) next_state = SPLAT;
                else							next_state = FALL_R;
            end
            DIG_L:	next_state = ground ? DIG_L	: FALL_L;
            DIG_R:	next_state = ground ? DIG_R	: FALL_R;
            SPLAT: 	next_state = SPLAT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= LEFT;
        end 
        else if (aaah) begin
            count++;
            state <= next_state;
        end 
        else begin
            count <= 0;
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left	= (state == LEFT);
    assign walk_right	= (state == RIGHT);
    assign aaah			= (state == FALL_L || state == FALL_R);
    assign digging 		= (state == DIG_R || state == DIG_L);
endmodule
