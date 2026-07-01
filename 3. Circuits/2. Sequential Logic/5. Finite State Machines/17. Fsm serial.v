module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done
); 
    parameter 	IDLE  = 3'd0,
    			START = 3'd1,
    			DATA  = 3'd2,
    			STOP  = 3'd3,
    			WAIT  = 3'd4;
    reg  [3:0] state;
    wire [3:0] next_state;
    reg  [3:0] count;

    always @(*) begin
        case(state)
            IDLE:	next_state = in ? IDLE : START;
            START: 	next_state = DATA;
            DATA:	begin
                if (count == 8) begin
                    if (in) next_state = STOP;
                    else	next_state = WAIT;
                end 
                else next_state = DATA;
            end
            STOP:	next_state = in ? IDLE : START;
            WAIT: 	next_state = in ? IDLE : WAIT;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)	state <= IDLE;
        else 		state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) begin 
            count <= '0;
            done <= 1'b0;
        end
        else if (next_state == DATA) begin
            count <= count + 1'b1;
            done <= 0;
        end
        else if (next_state == STOP) begin
            count <= '0;
            done <= 1'b1;
        end
        else begin
            count <= '0;
            done <= 1'b0;
        end
    end
endmodule
