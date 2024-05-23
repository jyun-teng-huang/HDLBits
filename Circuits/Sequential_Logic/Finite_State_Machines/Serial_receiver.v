module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter idle=3'd0, start=3'd1, data=3'd2, stop=3'd3,stoperr=3'd4;
    reg [2:0]state, next;
    reg [2:0]data8;
    always@(*)begin
        case(state)
            idle: next = in?idle:start;
            start: next = data;
            data: next = (&data8)?(in?stop:stoperr):data;
            stop: next = in?idle:start;
            stoperr: next = in?idle:stoperr;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= idle;
        else state <= next;
    end
    always@(posedge clk)begin
        if(state==data) data8 <= data8 + 1;
        else data8 <= 0;
    end
    assign done = state==stop;
endmodule