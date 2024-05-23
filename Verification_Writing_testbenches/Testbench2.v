module top_module();
    reg clk,in;
    reg[2:0]s;
    reg out;
    always#5 clk=~clk;
    q7 dut1(clk,in,s,out);
    initial begin
        clk=0;
        in=0;
        s=2;
        #10 s=6;
        #10 s=2;
        in=1;
        #10 s=7;
        in=0;
        #10 s=0;
        in=1;
        #30 in=0;
    end
endmodule
