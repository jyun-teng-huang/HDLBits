module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    always@(posedge clk, posedge areset)begin
        if(areset)begin
            q <= 4'h0;
        end else begin
            if(load)begin
                q <= data;
            end else begin
                q <= ena?q>>1:q;
            end
        end
    end
endmodule
