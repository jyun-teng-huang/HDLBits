module top_module( 
    input a, b, cin,
    output cout, sum );
    assign sum = ~a&~b&cin | ~a&b&~cin | a&~b&~cin | a&b&cin;
    assign cout = ~a&b&cin | a&b&~cin | a&~b&cin | a&b&cin;

endmodule
