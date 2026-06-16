module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
); 
    bcdcount2d_hours hour(
        .clk(clk),
        .enable(ena && ss[7:0] == {4'd5, 4'd9} && mm[7:0] == {4'd5, 4'd9}),
        .reset(reset),
        .count(hh[7:0]),
        .pm(pm)
    );
    bcdcount2d_minsec min(
        .clk(clk),
        .enable(ena && ss[7:0] == {4'd5, 4'd9}),
        .reset(reset || (ena && mm[7:0] == {4'd5, 4'd9} && ss[7:0] == {4'd5, 4'd9})),
        .count(mm[7:0])
    );
    bcdcount2d_minsec sec(
        .clk(clk),
        .enable(ena),
        .reset(reset || ss[7:0] == {4'd5, 4'd9}),
        .count(ss[7:0])
    );
endmodule

module bcdcount2d_hours(
    input clk,
    input enable,
    input reset,
    output reg [7:0] count,
    output reg pm
);
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            count[7:0] <= {4'd1, 4'd2};
            pm <= 1'b0;
        end else if (enable == 1 && count[7:0] == {4'd1, 4'd2}) begin
        	count <= 8'b1;
            
        end else if (enable == 1 && count[3:0] == {4'd9}) begin
            count[3:0] <= 4'b0;
            count[7:4] <= count[7:4] + 1'b1;
        end else if (enable == 1) begin
            count[3:0] <= count[3:0] + 1'b1;
            if (count[7:0] == {4'd1, 4'd1}) begin
                pm <= ~pm;
            end
        end
    end
endmodule

module bcdcount2d_minsec(
    input clk,
    input enable,
    input reset,
    output [7:0] count
);
    bcdcount digit0(
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .count(count[3:0])
    );
    bcdcount digit1(
        .clk(clk),
        .enable(enable && count[3:0] == {4'd9}),
        .reset(reset),
        .count(count[7:4])
    );
endmodule
    
module bcdcount(
    input clk,
    input enable,
    input reset,
    output reg [3:0] count
);
    always @(posedge clk) begin
        if (reset == 1'b1 || (enable && count[3:0] == 4'd9)) begin
            count[3:0] <= 4'b0;
        end else if (enable == 1) begin
            count[3:0] <= count[3:0] + 1'b1;
        end
    end
endmodule
