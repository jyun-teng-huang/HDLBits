module top_module( 
    input [2:0] in,
    output [1:0] out );
    wire [1:0]counter;
    always@(*)begin
        counter = 2'b00;
        for(int i=0;i<3;i=i+1)begin
            if( in[i] == 1'b1 )begin counter = counter + 1; end
            else begin counter = counter; end
        end
        out = counter;
    end
endmodule
