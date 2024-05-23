module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    parameter A=3'b000, B=3'b001, C=3'b010, D=3'b011, E=3'b100;
    assign z = y==3'b011 | y==3'b100;
    assign Y0 = ~x&(y==3'b001|y==3'b011|y==3'b100) | x&(y==3'b000|y==3'b010);
endmodule
