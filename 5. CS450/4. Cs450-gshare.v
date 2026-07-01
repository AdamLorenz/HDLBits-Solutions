module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    parameter 	SNT = 2'b00,
                WNT = 2'b01,
                WT  = 2'b10,
                ST  = 2'b11;
    wire [1:0] state;
    wire [1:0] next;
    reg  [1:0] pht [0:127];
    
    assign predict_taken = pht[predict_pc ^ predict_history][1];
    
    assign state = pht[train_pc ^ train_history];
    always @(*) begin
        case(state)
            SNT:	next = train_taken ? WNT : SNT; 
            WNT:	next = train_taken ? WT  : SNT;
            WT:		next = train_taken ? ST  : WNT;
            ST:		next = train_taken ? ST  : WT;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            for(int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;
            end
            predict_history <= '0;
        end
        else if (train_valid) begin
            pht[train_pc ^ train_history][1:0] <= next;
            if (train_mispredicted) begin
                predict_history <= {train_history[5:0], train_taken};
            end
            else if (predict_valid)begin
                predict_history <= {predict_history[5:0], predict_taken};
            end
        end
        else if (predict_valid) begin
            predict_history <= {predict_history[5:0], predict_taken};
        end
    end
endmodule
