module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    wire [1:0] next;
    always @(*) begin
        case(state)
            2'b00:	next = train_taken ? 2'b01 : 2'b00;
            2'b01:	next = train_taken ? 2'b10 : 2'b00;
            2'b10:	next = train_taken ? 2'b11 : 2'b01;
            2'b11:	next = train_taken ? 2'b11 : 2'b10;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if 		(areset)		state <= 2'b01;
        else if (train_valid)	state <= next;
    end
endmodule
