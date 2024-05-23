module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    wire [3:0]q;
    wire [3:0]q_next;
    assign q_next = {in,q[3:1]};
    assign out = q[0];
    always@(posedge clk)begin
        if(~resetn)
        	q <= 4'b0;
        else begin
            q <= q_next;
        end
    end
endmodule
