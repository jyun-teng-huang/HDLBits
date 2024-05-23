module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    count4 the_counter (clk, c_enable, c_load, c_d ,Q);
    // control signal
    assign c_enable = enable&~reset;
    assign c_load = reset?1:(Q==12?enable:0);
    assign c_d = 1;

endmodule
