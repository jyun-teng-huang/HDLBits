module top_module( 
    input [99:0] in,
    output [99:0] out
);
    int index;
    always@(*)begin
    	for(index=0;index<100;index=index+1)begin
            out[99-index] = in[index];
    	end
    end
endmodule
