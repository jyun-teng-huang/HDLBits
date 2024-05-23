module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    wire [7:0]d1_in;
    wire [7:0]d2_in;
    always@(posedge clk)begin
		d1_in <= in;
    end
    always@(posedge clk)begin
		d2_in <= d1_in;
    end
	assign pedge = ~d2_in & d1_in;

endmodule
