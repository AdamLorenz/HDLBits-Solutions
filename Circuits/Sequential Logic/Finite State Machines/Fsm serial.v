module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter   IDLE = 2'd0,
    			DATA = 2'd1,
    			DONE = 2'd2; 
    reg  [1:0] state;
    wire [1:0] next_state;
    int count;
    
    always @(*) begin
        case(state)
            IDLE:	next_state = in ? IDLE : DATA;
            DATA: begin
                if 		(count < 8) 		next_state = DATA;
                else if (count == 8 && in)  next_state = DONE;
                else if (in) 				next_state = IDLE;
                else 						next_state = DATA;
            end
            DONE:	next_state = ~in ? DATA : IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
        end
        else if (state == DATA) begin
            count <=  count + 1;
            state <= next_state;
        end
        else begin
            state <= next_state;
            count <= 0;
        end
    end
    
    assign done = (state == DONE);
    
endmodule
