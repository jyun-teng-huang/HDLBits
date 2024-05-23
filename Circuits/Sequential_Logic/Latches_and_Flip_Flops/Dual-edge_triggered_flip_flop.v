module top_module (
    input clk,
    input d,
    output q
);
    wire pd;
    wire nd;
    assign q = clk?pd:nd;
    always@(posedge clk)
        pd <= d;
    always@(negedge clk)
        nd <= d;
endmodule
