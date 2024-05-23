module top_module ();
    reg clk,reset,t,q;
    tff dut1(clk,reset,t,q);
    always#5 clk=~clk;
    always@(*) reset <= t;
    always@(posedge clk) t = t+1;
    initial begin
        clk = 0;
        reset = 0;
        t = 0;
    end

endmodule
