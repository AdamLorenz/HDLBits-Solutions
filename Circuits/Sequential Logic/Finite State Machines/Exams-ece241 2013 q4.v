module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter 	HHU = 3'd0, // High High going Up
          			HD 	= 3'd1, // High going Down
          			HU 	= 3'd2, // High going Up
          			LD 	= 3'd3, // Low going Down
          			LU 	= 3'd4, // Low going Up
          			LLD = 3'd5; // Low Low going Down
    reg [2:0] state;
    wire [2:0] next_state;
    
    always @(*) begin
        // State transition logic:
        case(state)
            HHU:	  next_state = s[3] ? HHU : HD;
            HD:		  next_state = s[3] ? HHU : s[2] ? HD : LD;
            HU:		  next_state = s[3] ? HHU	: s[2] ? HU : LD;
            LD:		  next_state = s[2] ? HU	: s[1] ? LD : LLD;
            LU:		  next_state = s[2] ? HU	: s[1] ? LU : LLD;
            LLD:	  next_state = s[1] ? LU	: LLD;
            default:next_state = 'x;
        endcase
        // State output logic:
        case(state) 
            HHU:    {fr1, fr2, fr3, dfr} = 4'b0000;
            HD:	    {fr1, fr2, fr3, dfr} = 4'b1001;
            HU:     {fr1, fr2, fr3, dfr} = 4'b1000;
            LD:		  {fr1, fr2, fr3, dfr} = 4'b1101;
            LU:		  {fr1, fr2, fr3, dfr} = 4'b1100;
            LLD:	  {fr1, fr2, fr3, dfr} = 4'b1111;
            default:{fr1, fr2, fr3, dfr} = 'x;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) state <= LLD;
        else state <= next_state;
    end
endmodule
