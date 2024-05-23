module top_module (
    input clk,
    input in, 
    output out);
	wire dff_q;
    wire xor_o;
    assign xor_o = in^dff_q;
    assign out = dff_q;
    
    always@(posedge clk)begin
        dff_q <= xor_o;
    end
endmodule
