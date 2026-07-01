module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg [23:0] out_bytes,
    output done
);
    // FSM from fsm_ps2
    parameter	BYTE1 = 2'd0,
    			BYTE2 = 2'd1,
    			BYTE3 = 2'd2,
    			DONE  = 2'd3;
    reg  [1:0]	state;
    wire [1:0]	next_state;
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            BYTE1:	next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2:	next_state = BYTE3;
            BYTE3:	next_state = DONE;
            DONE:	next_state = in[3] ? BYTE2 : BYTE1;
        endcase
    end
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) 	state <= BYTE1;
        else		state <= next_state;
    end
    // Output logic
    assign done = (state == DONE);
    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if(in[3] && (state == BYTE1 | state == DONE)) begin
            out_bytes[23:16] <= in;
        end
        else if (state == BYTE2) begin
            out_bytes[15:8] <= in;
        end
        else begin
            out_bytes[7:0] <= in;
        end
    end
endmodule
