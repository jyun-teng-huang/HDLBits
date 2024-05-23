module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    wire [7:0]d1;
    wire [7:0]d2;
    always@(posedge clk)
        d1 <= in;
    always@(posedge clk)
        d2 <= d1;
    assign anyedge = d1^d2;
endmodule
