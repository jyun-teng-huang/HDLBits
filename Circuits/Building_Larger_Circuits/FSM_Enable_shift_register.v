module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    parameter a=4'd0,b=4'd1,c=4'd2,d=4'd3,e=4'd4;
    reg [3:0]state,next;
    always@(*)begin
        case(state)
            a: next = b;
            b: next = c;
            c: next = d;
            d: next = e;
            e: next = e;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state<=a;
        else state<=next;
    end
    assign shift_ena = state==a | state==b | state==c | state==d;
endmodule
