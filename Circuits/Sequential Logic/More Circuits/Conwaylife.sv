function int posmod(
    input int a,
    input int b
);
    return (a % b) < 0 ? (a % b) + b : (a % b);
endfunction

module top_module(
	input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q 
); 
	wire [15:0][15:0] 	q2d;
    wire [255:0] 		q_next;
    always_comb begin
		// Convert q into 2D wire array:
        for(int r = 0; r < 16; r++) begin
            for(int c = 0; c < 16; c++) begin
                q2d[r][c] = q[16*r + c];
            end
        end

		// Calculate number of neighbors for each index:
        for(int r = 0; r < 16; r++) begin
            for(int c = 0; c < 16; c++) begin
            	int count;
				/* count = 	  q2d[up][left] 	+ q2d[up][mid] 		+ q2d[up][right]
							+ q2d[mid][left] 						+ q2d[mid][right]
							+ qd2[down][left] 	+ q2d[down][mid] 	+ q2d[down][right];
				*/
				// Use modulo arithmetic to wrap indices:
                count =	  q2d[posmod(r - 1,16)][posmod(c - 1,16)] + q2d[posmod(r - 1,16)][c] + q2d[posmod(r - 1,16)][posmod(c + 1,16)]
						+ q2d[r][posmod(c - 1,16)] 											 + q2d[r][posmod(c + 1,16)]
                		+ q2d[posmod(r + 1,16)][posmod(c - 1,16)] + q2d[posmod(r + 1,16)][c] + q2d[posmod(r + 1,16)][posmod(c + 1,16)];
				
				if		(count <= 1 || 4 <= count)	q_next[16*r + c] = 1'b0;
                else if	(count == 3)				q_next[16*r + c] = 1'b1;
				else 								q_next[16*r + c] = q[16*r + c];
            end
        end
	end
	
    always @(posedge clk) begin
        if (load) 	q <= data;
        else 		q <= q_next;
    end
endmodule
