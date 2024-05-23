module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	parameter idle=3'd0, start=3'd1, data=3'd2, stop=3'd3, err= 3'd4;
    reg [2:0]state, next;
    reg [3:0]dnum;
    always@(posedge clk)begin
        dnum = (next==data)?dnum+1:0;
    end
    // Use FSM from Fsm_serial
    always@(*)begin
        case(state)
            idle  : next = in?idle:start;
            start : next = data;
            data  : next = dnum[3]?(in?stop:err):data;
            stop  : next = in?idle:start;
            err   : next = in?idle:err;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= idle;
        else state <= next;
    end
    // New: Datapath to latch input bits.
    assign done = state == stop;
    always@(posedge clk)begin
        out_byte = (next==data)?{in,out_byte[7:1]}:out_byte;
    end
endmodule
