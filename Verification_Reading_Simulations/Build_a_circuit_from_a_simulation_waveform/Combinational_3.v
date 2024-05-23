module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//
	//  00 01 11 10
    //00 0  0  0  0
    //01 0  1  1  1
    //11 0  1  1  1
    //10 0  1  1  1
    assign q = ((a|b)&(c|d)); // Fix me

endmodule
