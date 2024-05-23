module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:0]cout_middle;
    bcd_fadd bcd_fadd1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.cout(cout_middle[0]),.sum(sum[3:0]));

	genvar i;
    generate
        for(i=1;i<100;i=i+1)begin:BLOCK1
            bcd_fadd bcd_faddi(.a(a[4*i+3:4*i]),.b(b[4*i+3:4*i]),.cin(cout_middle[i-1]),.cout(cout_middle[i]),.sum(sum[4*i+3:4*i]));
        end
    endgenerate
    assign cout = cout_middle[99];
endmodule
