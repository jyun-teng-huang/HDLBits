module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
	//  ab
    //cd  00 01 11 10
    //  00 0  0  d  d
    //  01 0  0  0  0
    //  11 d  1  1  d
    //  10 1  0  0  0
    assign out_sop = (c&d) | (~a&~b&c);
    assign out_pos = (c)&(~a|d)&(~b|d);
endmodule
