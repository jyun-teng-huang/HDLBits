module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    // FSM
    parameter s0=4'd1,s1=4'd2,s2=4'd3,s3=4'd4,s4=4'd5,
    s5=4'd6,s6=4'd7,s_disc=4'd8,s_flag=4'd9,s_err=4'd10;
    reg [3:0]state, next;
    always@(*)begin
        case(state)
            s0    : next = in?s1:s0;
            s1    : next = in?s2:s0;
            s2    : next = in?s3:s0;
            s3    : next = in?s4:s0;
            s4    : next = in?s5:s0;
            s5    : next = in?s6:s_disc;
            s6    : next = in?s_err:s_flag;
            s_disc: next = in?s1:s0;
            s_flag: next = in?s1:s0;
            s_err : next = in?s_err:s0;
            default: next = s0;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= s0;
        else state <= next;
    end
    // output
    assign disc = state==s_disc;
    assign flag = state==s_flag;
    assign err = state==s_err;
endmodule
