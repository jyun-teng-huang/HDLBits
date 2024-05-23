module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//
	wire q_tmp;
    //  00 01 10 11
    //00 1  0  0  1
    //01 0  1  1  0
    //10 0  1  1  0
    //11 1  0  0  1
    assign q = (a^b)&(c^d) | (~(a^b))&(~(c^d)); // Fix me

endmodule
