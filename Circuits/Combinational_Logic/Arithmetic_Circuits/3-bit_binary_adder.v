module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    fadd fadd1(.sum(sum[0]),.cout(cout[0]),.a(a[0]),.b(b[0]),.cin(cin));
	genvar i;
    generate
        for(i=1;i<3;i=i+1) begin:fadd3
            fadd faddi(.sum(sum[i]),.cout(cout[i]),.a(a[i]),.b(b[i]),.cin(cout[i-1]));
        end
    endgenerate

endmodule
module fadd( 
    input a, b, cin,
    output cout, sum );
    assign sum = ~a&~b&cin | ~a&b&~cin | a&~b&~cin | a&b&cin;
    assign cout = ~a&b&cin | a&b&~cin | a&~b&cin | a&b&cin;
endmodule