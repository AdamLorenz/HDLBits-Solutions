module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state  
);
    wire next;
    always @(*) begin
        case(state)
            1'b0:	next = (a & b) ? 1'b1 : 1'b0;
            1'b1:	next = (a | b) ? 1'b1 : 1'b0;
            default:next = 1'b0;
        endcase
    end
    
    always @(posedge clk) begin
        state <= next;
    end
    
    always @(*) begin
        case(state)
            1'b0:	q = a ^ b;
            1'b1:	q = a ~^ b;
        endcase
    end
endmodule
