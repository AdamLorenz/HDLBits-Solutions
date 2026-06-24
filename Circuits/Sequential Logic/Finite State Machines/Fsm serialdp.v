module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output reg done
);
    parameter 	IDLE  	= 3'd0,
    			START 	= 3'd1,
    			DATA  	= 3'd2,
    			STOP  	= 3'd4,
    			WAIT  	= 3'd5;
    reg  [2:0] state;
    wire [2:0] next_state;
    reg  [3:0] count;
    
    always @(*) begin
        case(state)
            IDLE:	next_state = in ? IDLE : START;
            START: 	next_state = DATA;
            DATA:	begin
                if (count == 8) begin
                    if (in) next_state = STOP;
                    else 	next_state = WAIT;
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
        else begin
            case(next_state)
                DATA: begin
                    count <= count + 1'b1;
                    out_byte <= {in, out_byte[7:1]};
                end
        		STOP: begin
                    if (in) done <= 1'b1;
                    else 	done <= 1'b0;
                end
                default: begin
                    count <= '0;
                    done <= 1'b0;
                end
            endcase
        end
    end
endmodule
