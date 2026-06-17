module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end else begin
            // A better way is to use vector part select and concatenation in a single operation:
            q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0} ;
            /*
            q[0] <= 1'b0 ^ q[1];
            for (int i = 1; i < 511; i++) begin
                q[i] <= q[i - 1] ^ q[i + 1];
            end
            q[511] <= 1'b0 ^ q[510];
            */
        end
    end
endmodule
