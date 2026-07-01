module top_module ( input [1:0] A, input [1:0] B, output z ); 
    wire [1:0] temp;
    assign temp = A ~^ B;
    assign z = &temp;
endmodule