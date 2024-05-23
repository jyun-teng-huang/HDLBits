module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
    always@(*)begin
        for(int i=0;i<3;i=i+1)begin
            if(in[i]&in[i+1]==1'b1)
                out_both[i] = 1'b1;
            else
                out_both[i] = 1'b0;
        end
        for(int i=3;i>0;i=i-1)begin
            if(in[i]|in[i-1]==1'b1)
                out_any[i] = 1'b1;
            else
                out_any[i] = 1'b0;
        end
        for(int i=0;i<3;i=i+1)begin
            if(in[i]!=in[i+1])
                out_different[i] = 1'b1;
            else
                out_different[i] = 1'b0;
        end
        if(in[3]!=in[0]) begin
            out_different[3] = 1'b1;
        end else begin
            out_different[3] = 1'b0;
        end
    end

endmodule
