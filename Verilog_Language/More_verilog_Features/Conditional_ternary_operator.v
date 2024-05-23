module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0]rel_min_ab;
    wire [7:0]rel_min_cd;
    assign rel_min_ab = (a<b)? a:b;
    assign rel_min_cd = (c<d)? c:d;
    assign min = (rel_min_ab<rel_min_cd)?rel_min_ab:rel_min_cd;
    // assign intermediate_result1 = compare? true: false;
	
endmodule
