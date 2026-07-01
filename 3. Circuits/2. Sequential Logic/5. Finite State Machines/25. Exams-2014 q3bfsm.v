module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter 	A = 3'd0,
                B = 3'd1,
                C = 3'd2,
                D = 3'd3,
                E = 3'd4;
    reg  [2:0] state;
    wire [2:0] next_state;
    
    always @(*) begin
        case(state)
            A: 	next_state = x ? B : A;
            B: 	next_state = x ? E : B;
            C: 	next_state = x ? B : C;
            D: 	next_state = x ? C : B;
            E: 	next_state = x ? E : D;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) 	state <= A;
        else		state <= next_state;
    end
    
    assign z = (state == D) | (state == E);
    
endmodule
