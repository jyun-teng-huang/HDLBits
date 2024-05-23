module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
	parameter A=4'd1,B=4'd2,C=4'd3,D=4'd4,E=4'd5,F=4'd6,G=4'd7,H=4'd8,I=4'd9,J=4'd10;
    reg [3:0]state,next;
    always@(*)begin
        case(state)
            A: next=resetn?B:A;
            B: next=C;
            C: next=x?D:E;
            D: next=x?D:F;
            E: next=x?D:E;
            F: next=x?G:E;
            G: next=y?I:H;
            H: next=y?I:J;
            I: next=I;
            J: next=J;
            default: next = A;
        endcase
    end
    always@(posedge clk)begin
        if(~resetn) state<=A;
        else state<=next;
    end
    assign f = state==B;
    assign g = state==G | state==H | state==I;
endmodule
