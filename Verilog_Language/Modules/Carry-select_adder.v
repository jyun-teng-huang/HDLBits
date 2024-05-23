module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0]sum1,sum2,sum3;
    wire cout1,cout2,cout3;
    
    add16 dut1(.sum(sum1),.cout(cout1),.a(a[15:0]),.b(b[15:0]),.cin(1'b0));
    add16 dut2(.sum(sum2),.cout(),.a(a[31:16]),.b(b[31:16]),.cin(1'b0));
    add16 dut3(.sum(sum3),.cout(),.a(a[31:16]),.b(b[31:16]),.cin(1'b1));
    always@(*)
        begin
            case (cout1)
                1'b0: sum <= {sum2,sum1};
                1'b1: sum <= {sum3,sum1};
            endcase
        end
endmodule
