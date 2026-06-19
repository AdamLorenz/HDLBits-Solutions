module top_module(
	    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q 
); 
    wire q2d[17:0][17:0];
    reg [255:0] q_next;
    always_comb begin
        for(int r = 0; r < 16; r++) begin
            for(int c = 0; c < 16; c++) begin
                q2d[r][c] = q[16*r + c];
            end
        end
        
        for(int r = 0; r < 16; r++) begin
            for(int c = 0; c < 16; c++) begin
            	int count;
                count =	  q2d[posmod(r - 1,16)][posmod(c - 1,16)] + q2d[posmod(r - 1,16)][c] + q2d[posmod(r - 1,16)][posmod(c + 1,16)]
                		+ q2d[r][posmod(c - 1,16)] 											 + q2d[r][posmod(c - 1,16)]
                		+ q2d[posmod(r + 1,16)][posmod(c - 1,16)] + q2d[posmod(r + 1,16)][c] + q2d[posmod(r + 1,16)][posmod(c + 1,16)];
                if		(count < 2 || count > 3)	q_next[16*r + c] = 1'b0;
                else if	(count == 3)				q_next[16*r + c] = 1'b1;
                else								q_next[16*r + c] = q[16*r + c];
            end
        end
    end
    
    	/*    
    	for(int r = 0; r < 16; r++) begin
            for(int c = 0; c < 16; c++) begin
            	int count;
                count =   q[16*((r - 1) % 16 + 16) + ((c - 1) % 16 + 16)] 	+ q[16*((r - 1) % 16 + 16) + c] + q[16*((r - 1) % 16 + 16) + ((c + 1) % 16 + 16)]
                		+ q[16*r + ((c - 1) % 16 + 16)] 													+ q[16*r + ((c - 1) % 16 + 16)]
                		+ q[16*((r + 1) % 16 + 16) + ((c - 1) % 16 + 16)] 	+ q[16*((r + 1) % 16 + 16) + c] + q[16*((r + 1) % 16 + 16) + ((c + 1) % 16 + 16)]
                if		(count < 2 || count > 3)	q_next[16*r + c] = 1'b0;
                else if	(count == 3)				q_next[16*r + c] = 1'b1;
                else								q_next[16*r + c] = q[16*r + c];
            end
        end
       */
    
        /* ((index % size) + size) % size
        q2d[0][0] = q[0];
        for(int j = 1; j < 17; j++) begin
            q2d[0][j] = q[16*1 - j];
        end
        q2d[0][17] = q[15];
        for(int i = 1; i < 17; i++) begin
            q2d[i][0] = q[16*(16 - i)];
            for(int j = 1; j < 17; j++) begin
                q2d[i][j] = q[16*(16 - (i - 1)) - j];
            end
            q2d[i][17] = q[16*(16 - (i - 1)) - 1];
        end
        q2d[17][0] = q[240];
        for(int j = 1; j < 17; j++) begin
            q2d[17][j] = q[16*16 - j];
        end
        q2d[17][17] = q[255];
        
        for(int i = 1; i < 17; i++) begin
            for(int j = 1; j < 17; j++) begin
                int count;
                count =   q2d[i - 1][j - 1] + q2d[i - 1][j] + q2d[i - 1][j + 1] 
                		+ q2d[i][j - 1] 					+ q2d[i][j + 1]
                		+ q2d[i + 1][j - 1] + q2d[i + 1][j] + q2d[i + 1][j + 1];
                if		(count < 2 || count > 3)	q_next[16*(16 - (i - 1)) - j] = 1'b0;
                else if	(count == 3)				q_next[16*(16 - (i - 1)) - j] = 1'b1;
                else								q_next[16*(16 - (i - 1)) - j] = q2d[i][j];
            end
        end
    end
    */
    always @(posedge clk) begin
        if (load) 	q <= data;
        else 		q <= q_next;
    end
endmodule

function int posmod(
    input int a,
    input int b
);
    return (a % b) < 0 ? (a % b) + b : (a % b);
endfunction
