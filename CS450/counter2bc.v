module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT=2'b00,WNT=2'b01,WT=2'b10,ST=2'b11;
    wire [1:0]next;
    always@(*)begin
        case(state)
            SNT: next = train_taken?WNT:SNT;
            WNT: next = train_taken?WT:SNT;
            WT : next = train_taken?ST:WNT;
            ST : next = train_taken?ST:WT;
            default: next = next;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset) state <= WNT;
        else state <= train_valid?next:state;
    end
endmodule
