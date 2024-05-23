module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    wire [4:1]c;
    bcd_counter bcd0(clk,reset,1'b1,c[1],q[3:0]);
    bcd_counter bcd1(clk,reset,ena[1],c[2],q[7:4]);
    bcd_counter bcd2(clk,reset,ena[2],c[3],q[11:8]);
    bcd_counter bcd3(clk,reset,ena[3],c[4],q[15:12]);
    assign ena[1] = c[1];
    assign ena[2] = c[1]&c[2];
    assign ena[3] = c[1]&c[2]&c[3];
endmodule
module bcd_counter(
	input clk,
	input reset,
    input ena_in,
	output ena,
    output [3:0]q
);
    always@(posedge clk)begin
        if(reset)begin
            q <= 0;
            ena<=0;
        end else begin
            if(ena_in) begin
                if(q<9) begin
                    q <= q+1;
                end else begin
                    q <= 0;
                end
                if(q==8)begin
                    ena <= 1;
                end else begin
                    ena <= 0;
                end
            end else begin
                q <= q;
                ena <= ena;
            end            
        end
    end
endmodule
