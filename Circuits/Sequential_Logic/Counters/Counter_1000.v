module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [3:0]q1;
    wire [3:0]q2;
    wire [3:0]q3;
    bcdcount counter0 (clk, reset, c_enable[0], q1);
    bcdcount counter1 (clk, reset, c_enable[1], q2);
    bcdcount counter2 (clk, reset, c_enable[2], q3);
    assign c_enable[0] = 1;
    assign c_enable[1] = (q1==9)?1:0;
    assign c_enable[2] = (q2==9)?((q1==9)?1:0):0;
    
    assign OneHertz =(q3==9)?((q2==9)?((q1==9)?1:0):0):0;

endmodule
