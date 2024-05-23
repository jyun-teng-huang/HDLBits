module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    wire [8:0]sumc = (a+b);
    assign s = {a+b};
    assign overflow = ~a[7]&~b[7]&sumc[7] | a[7]&b[7]&~sumc[7];

endmodule
