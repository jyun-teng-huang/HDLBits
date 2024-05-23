module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [3:0]cout;
    fadd fadd0(.sum(sum[0]),.cout(cout[0]),.a(x[0]),.b(y[0]),.cin(1'b0));
    genvar i;
    generate
        for(i=1;i<4;i=i+1) begin: fadd4
            fadd faddi(.sum(sum[i]),.cout(cout[i]),.a(x[i]),.b(y[i]),.cin(cout[i-1]));
        end
    endgenerate
    assign sum[4] = cout[3];
    
endmodule
module fadd( 
    input a, b, cin,
    output cout, sum );
    assign sum = ~a&~b&cin | ~a&b&~cin | a&~b&~cin | a&b&cin;
    assign cout = ~a&b&cin | a&b&~cin | a&~b&cin | a&b&cin;
endmodule