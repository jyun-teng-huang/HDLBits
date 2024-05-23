module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter sbit = 3;
    parameter [14:0]S = {3'b000,3'b001,3'b010,3'b011,3'b100};
    reg [2:0]state,next;
    always@(*)begin
        case(state)
            S[0*sbit+2:0*sbit]: next=x?S[1*sbit+2:1*sbit]:S[0*sbit+2:0*sbit];
            S[1*sbit+2:1*sbit]: next=x?S[4*sbit+2:4*sbit]:S[1*sbit+2:1*sbit];
            S[2*sbit+2:2*sbit]: next=x?S[1*sbit+2:1*sbit]:S[2*sbit+2:2*sbit];
            S[3*sbit+2:3*sbit]: next=x?S[2*sbit+2:2*sbit]:S[1*sbit+2:1*sbit];
            S[4*sbit+2:4*sbit]: next=x?S[4*sbit+2:4*sbit]:S[3*sbit+2:3*sbit];
            default: next=S[0*sbit+2:0*sbit];
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= S[0*sbit+2:0*sbit];
        else state <= next;
    end
    assign z = state==S[3*sbit+2:3*sbit] | state==S[4*sbit+2:4*sbit];
endmodule
