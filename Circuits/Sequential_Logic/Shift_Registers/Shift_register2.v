module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    parameter  int n = 4;
    wire [n:0]q;
    assign q[n] = KEY[3];
    assign LEDR = q[n-1:0];
	genvar i;
    generate 
        for(i=0;i<n;i=i+1) begin:BLOCK1
            MUXDFF muxdffi(.E(KEY[1]),.R(SW[i]),.L(KEY[2]),.clk(KEY[0]),.w(q[i+1]),.q(q[i]));
    	end
    endgenerate
endmodule

module MUXDFF (
	input E,
    input R,
    input L,
    input clk,
    input w,
    output reg q
);
    wire q_next;
    assign q_next = L?R:(E?w:q);
    always@(posedge clk)begin
        q <= q_next;
    end
endmodule
