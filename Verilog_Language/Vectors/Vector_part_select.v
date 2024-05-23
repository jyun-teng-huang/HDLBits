module top_module( 
    input [31:0] in,
    output [31:0] out );//
    wire [7:0] bytes [3:0];
    assign bytes[3] = in[31:24];
    assign bytes[2] = in[23:16];
    assign bytes[1] = in[15:8];
    assign bytes[0] = in[7:0];
    assign out = {bytes[0],bytes[1],bytes[2],bytes[3]};

    // assign out[31:24] = ...;

endmodule
