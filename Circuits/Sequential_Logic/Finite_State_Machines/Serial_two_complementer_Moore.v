module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg x_reg;
    parameter carry=2'd0, plus1=2'd1, others=2'd2;
    reg [1:0]state, next;
    always@(*)begin
        case(state)
            carry : next = x?plus1:carry;
            plus1 : next = others;
            others: next = others;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset) state <= carry;
        else state <= next;
    end
    always@(posedge clk)
        x_reg <= x;
    always@(*)begin
        if(state==carry) z=1'b0;
        else if(state==plus1) z=1'b1;
        else z=~x_reg;
    end

endmodule
