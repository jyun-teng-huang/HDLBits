module top_module (input a, input b, input c, output out);//
	wire o_and3;
    andgate inst1 (.a(a),.b(b),.c(c),.d(1'b1),.e(1'b1),.out(o_and3));
    assign out = ~o_and3;

endmodule
