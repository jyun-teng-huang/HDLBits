module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);
    //  00 01 11 10
    //0  0  1  1  0
    //1  1  1  0  1
    
    wire [513:0]q_tmp;
    wire [513:0]q_tmp_next;
    assign q = q_tmp[512:1];
    genvar i;
    generate
        for(i=1;i<513;i=i+1)begin: block
            assign q_tmp_next[i] = ~q_tmp[i] & q_tmp[i-1] |  ~q_tmp[i+1] & q_tmp[i] |  q_tmp[i] & ~q_tmp[i-1];
        end
    endgenerate
            
    
    always@(posedge clk)begin
        if(load)begin
            q_tmp[512:1] <= data;
        end else begin
            q_tmp <= q_tmp_next;
        end
    end
    
endmodule
