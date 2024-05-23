module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    parameter idle=2'b00, p1=2'b01, p2=2'b10, p3=2'b11;
    reg [1:0]state, next;
    // FSM from fsm_ps2
    always@(*)begin
        case(state)
            idle: next = in[3]?p1:idle;
            p1: next = p2; 
            p2: next = p3;
            p3: next = in[3]?p1:idle;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= idle;
        else state <= next;
        case(next)
            idle: out_bytes = 24'b0;
            p1: out_bytes[23:16] = in;
            p2: out_bytes[15:8] = in;
            p3: out_bytes[7:0] = in;
        endcase
    end
    // New: Datapath to store incoming bytes.
    assign done = state==p3;

endmodule
