module top_module( 
    input [254:0] in,
    output [7:0] out );
    wire [7:0]counter; 
    always@(*)begin
        counter = 8'b0000_0000;
        for(int i=0;i<255;i=i+1)begin
            if(in[i] == 1'b1) begin counter = counter + 1'b1; end
            else begin counter = counter; end
        end
        out = counter;
    end
endmodule
