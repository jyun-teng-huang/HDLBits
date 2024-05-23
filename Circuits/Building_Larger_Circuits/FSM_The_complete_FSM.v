module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
	parameter s=4'd0,s1=4'd1,s11=4'd2,s110=4'd3,b0=4'd4,b1=4'd5,b2=4'd6,b3=4'd7,count=4'd8,wait_ack=4'd9;
    reg [3:0]state,next;
    always@(*)begin
        case(state)
            s    : next = data?s1:s;
            s1   : next = data?s11:s;
            s11  : next = data?s11:s110;
            s110 : next = data?b0:s;
            b0   : next = b1;
            b1   : next = b2;
            b2   : next = b3;
            b3   : next = count;
            count: next = done_counting?wait_ack:count;
            wait_ack : next = ack?s:wait_ack;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= s;
        else state <= next;
    end
    assign shift_ena = state==b0 | state==b1 | state==b2 | state==b3;
    assign counting = state==count;
    assign done = state==wait_ack;
endmodule
