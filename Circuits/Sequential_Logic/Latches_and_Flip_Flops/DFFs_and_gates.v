module top_module (
    input clk,
    input x,
    output z
); 
	wire xor_o;
    wire and_o;
    wire or_o;
    
    reg dff1_q = 1'b0;
    reg dff1_q_inv = 1'b1;
    reg dff2_q = 1'b0;
    reg dff2_q_inv = 1'b1;
    reg dff3_q = 1'b0;
    reg dff3_q_inv = 1'b1;
    
    assign xor_o = x^dff1_q;
    assign and_o = x&dff2_q_inv;
    assign or_o = x|dff3_q_inv;
    always@(posedge clk)begin
    	dff1_q <= xor_o;
        dff2_q <= and_o;
        dff3_q <= or_o;
        dff1_q_inv <= ~xor_o;
        dff2_q_inv <= ~and_o;
        dff3_q_inv <= ~or_o;
    end

    assign z = ~(dff1_q|dff1_q|dff3_q);
endmodule
