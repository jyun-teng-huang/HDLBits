module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	parameter A=4'd0,B=4'd1,C=4'd2,D=4'd3,E=4'd4,F=4'd5,G=4'd6,H=4'd7,I=4'd8,J=4'd9;
    reg [3:0]state, next;
    always@(*)begin
        case(state)
            A: next = s?B:A;
            B: next = w?D:C;
            C: next = w?F:E;
            D: next = w?H:G;
            E: next = I;
            F: next = w?J:I;
            G: next = w?J:I;
            H: next = w?I:J;
            I: next = w?D:C;
            J: next = w?D:C;
            default: next = A;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= A;
        else state <= next;            
    end
    assign z = state==J;
endmodule
