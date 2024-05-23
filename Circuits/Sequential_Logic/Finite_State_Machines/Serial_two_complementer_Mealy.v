module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=1'd0,B=1'd1;
    reg state, next;
    always@(*)begin
        case(state)
            A: next = x?B:A;
            B: next = B;
            default: next = A;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset) state <= A;
        else state <= next;
    end
    always@(*)begin
        if(state==A) z = x;
        else if(state==B) z = ~x;
        else z = 1'b0;
    end
endmodule
