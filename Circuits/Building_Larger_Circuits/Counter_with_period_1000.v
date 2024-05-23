module top_module (
    input clk,
    input reset,
    output [9:0] q);
    always@(posedge clk)begin
        if(reset) q<=10'b0;
        else if(q<999) q<=q+10'b1;
        else q<=10'b0;
    end
endmodule
