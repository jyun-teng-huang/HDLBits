module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
	parameter idle=3'd0, start=3'd1, data=3'd2, ppass=3'd3, perr=3'd4, stop=3'd5, error=3'd6;
    reg [2:0]state, next;
    reg [3:0]dnum;
    reg odd;
    wire pareset;
    wire pdone;
    // Modify FSM and datapath from Fsm_serialdata
    always@(posedge clk)begin
        dnum <= next==data?dnum+1'b1:4'd0;
    end
    always@(*)begin
        case(state)
            idle  : next = in?idle:start;
            start : next = data;
            data  : next = dnum[3]?(in^odd?ppass:perr):data;
            ppass : next = (in?stop:error);
            perr  : next = (in?stop:error);
            stop  : next = in?idle:start;
            error : next = in?idle:error;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= idle;
        else state <= next;
    end
    // output
    always@(posedge clk)begin
        out_byte = next==data?{in,out_byte[7:1]}:out_byte;
    end
    assign pdone = state==ppass?1'b1:(state==perr?1'b0:pdone);
    assign done = state == stop && pdone;
    // New: Add parity checking.
    assign pareset = reset | next!=data;
    parity pa1(.clk(clk),.reset(pareset),.in(in),.odd(odd));

endmodule
