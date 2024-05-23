module top_module (
    input clk,
    input a,
    output [3:0] q );
    always@(posedge clk)begin
        q <= a?4:(q<6?q+1:0);
    end
endmodule
