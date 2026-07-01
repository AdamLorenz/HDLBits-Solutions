module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);
    parameter 	START = 4'd0,
    			ONE 	= 4'd1, 
    			TWO 	= 4'd2,
    			THREE 	= 4'd3,
    			FOUR 	= 4'd4,
    			FIVE 	= 4'd5,
    			SIX 	= 4'd6,
    			DISC 	= 4'd7,
   		 		FLAG 	= 4'd8,
    			ERR 	= 4'd9;
    reg  [3:0] state;
    wire [3:0] next_state;
    
    always @(*) begin
        case(state)
            START:	next_state = in ? ONE 	: START;
            ONE:	next_state = in ? TWO 	: START;
            TWO:	next_state = in ? THREE : START;
            THREE:	next_state = in ? FOUR 	: START;
            FOUR:	next_state = in ? FIVE 	: START;
            FIVE:	next_state = in ? SIX 	: DISC;
            SIX:	next_state = in ? ERR 	: FLAG;
            DISC:	next_state = in ? ONE 	: START;
            FLAG:	next_state = in ? ONE 	: START;
            ERR:	next_state = in ? ERR 	: START;
            default:next_state = START;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)  state <= START;
        else		state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err  <= 1'b0;
        end
        else begin
            case(next_state)
                DISC: disc <= 1'b1;
                FLAG: flag <= 1'b1;
                ERR:  err  <= 1'b1;
                default: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err  <= 1'b0;
                end
            endcase
        end
    end
endmodule
