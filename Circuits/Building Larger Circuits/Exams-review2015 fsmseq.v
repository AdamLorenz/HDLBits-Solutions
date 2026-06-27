module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
);
	parameter	A = 3'd0,
    			B = 3'd1,
                C = 3'd2,
                D = 3'd3,
                E = 3'd4;
    reg  [2:0] state;
    wire [2:0] next_state;
    
    always @(*) begin
        case(state)
            A:	next_state = data ? B : A;
            B:	next_state = data ? C : A;
            C:	next_state = data ? C : D;
            D:	next_state = data ? E : A;
            E:	next_state = E;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)	state <= A;
        else		state <= next_state;
    end
    
    assign start_shifting = (state == E);
    
endmodule
