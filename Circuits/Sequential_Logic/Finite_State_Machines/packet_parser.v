module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    parameter idle='b00,st=2'b01, nd=2'b10, rd=2'b11;
    reg [1:0]state;
    reg [1:0]state_next;
    // State transition logic (combinational)
    always@(*)begin
        case(state)
            idle: begin
                state_next = in[3]?st:idle;
            end
        	st: begin
                state_next = nd;
            end
            nd: begin
                state_next = rd;
            end
            rd: begin
                state_next = in[3]?st:idle;
            end
        endcase
    end
    // State flip-flops (sequential)
    always@(posedge clk)begin
        if(reset)
            state <= idle;
        else
            state <= state_next;
    end
    // Output logic
	assign done = state == rd;
endmodule
