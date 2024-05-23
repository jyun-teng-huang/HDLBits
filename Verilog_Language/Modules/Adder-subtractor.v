module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0]b_inv;
    wire [15:0]sum_lsb16;
    wire [15:0]sum_msb16;
    wire cout;
    
    
    add16 lsb16(.sum(sum_lsb16),.cout(cout),.a(a[15:0]),.b(b_inv[15:0]),.cin(sub));
    add16 msb16(.sum(sum_msb16),.cout(),.a(a[31:16]),.b(b_inv[31:16]),.cin(cout));
    assign b_inv = b ^ {32{sub}};
    assign sum = {sum_msb16,sum_lsb16};
endmodule
