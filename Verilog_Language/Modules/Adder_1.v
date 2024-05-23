module top_module(
    input [31:0] a,
    input [31:0] b,
    output wire [31:0] sum
);
    wire cout1,cout2;
    wire [15:0]sum1;
    wire [15:0]sum2;
    add16 dut1(.sum(sum1),.cout(cout1),.a(a[15:0]),.b(b[15:0]),.cin(1'b0));
    add16 dut2(.sum(sum2),.cout(cout2),.a(a[31:16]),.b(b[31:16]),.cin(cout1));
    assign sum = {sum2,sum1}; 
endmodule
