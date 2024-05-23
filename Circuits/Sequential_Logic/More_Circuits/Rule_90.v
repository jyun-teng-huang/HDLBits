module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q );
    wire [513:0]q_bound;
    wire [513:0]q_bound_next;
    assign q = q_bound[512:1];
    
    genvar i;
    generate
        for (i=1;i<513;i=i+1) begin: block1
            assign q_bound_next[i] = q_bound[i+1]^q_bound[i-1];
        end
    endgenerate
    
    always@(posedge clk)begin
        
        if(load) begin
            q_bound[512:1] <= data;
        end else begin
            q_bound <= q_bound_next;
        end
    end
endmodule
