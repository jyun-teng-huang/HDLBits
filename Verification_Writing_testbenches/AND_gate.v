module top_module();
    reg [1:0]in;
    reg out;
    
    initial begin
        #0  in=0;
        #10 in=1;
        #10 in=2;
        #10 in=3;
    end
    andgate dut1(in,out);
endmodule
