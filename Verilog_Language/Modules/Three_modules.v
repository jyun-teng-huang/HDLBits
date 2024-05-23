module top_module ( input clk, input d, output q );
    wire q1,q2;
    my_dff dut1(.clk(clk),.d(d),.q(q1));
    my_dff dut2(.clk(clk),.d(q1),.q(q2));
    my_dff dut3(.clk(clk),.d(q2),.q(q));

endmodule