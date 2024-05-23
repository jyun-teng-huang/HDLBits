module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    wire [31:0]d1;
    wire [31:0]d2;
    
    always@(posedge clk)begin
        d1 <= in;
        if(reset) begin
            out <= 32'h0000_0000;
        end else begin
            
            out <= d1&~in| out;
        end
    end
endmodule
