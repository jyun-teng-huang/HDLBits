module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire [3:0]coutv;
    bcd_fadd bcd0(.sum(sum[3:0]),.cout(coutv[0]),.a(a[3:0]),.b(b[3:0]),.cin(cin));
    genvar i;
    generate
        for(i=1;i<4;i=i+1) begin: bcd_fadd4
            bcd_fadd bcdi(.sum(sum[i*4+3:i*4]),.cout(coutv[i]),.a(a[i*4+3:i*4]),.b(b[i*4+3:i*4]),.cin(coutv[i-1]));
        end
    endgenerate
    assign cout = coutv[3];
    
endmodule
