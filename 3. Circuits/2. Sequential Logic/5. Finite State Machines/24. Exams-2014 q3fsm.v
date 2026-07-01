module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);
	parameter 	A = 1'd0,
    			B = 1'd1;
    reg state;
    wire next_state;
    reg [2:0] count;
    reg [2:0] i;
    
    always @(*) begin
        case(state)
            A:	next_state = s ? B : A;
            B: 	next_state = B;
        endcase
    end
	
    always @(posedge clk) begin
        if (reset) 	state <= A;
        else		state <= next_state;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            i <= '0;
            count <= '0;
            z <= '0;
        end
        else if (state == B) begin
            if (i == 2) begin 
                i <= '0;
                count <= '0;
                if 		(count == 1) z <= w;
                else if (count == 2) z <= ~w;
            end
            else begin
                z <= '0;
                count <= count + w;
                i <= i + 1'b1;
            end
        end
    end
endmodule
