module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    wire [6:0]load;
    wire [5:0]enable;
    wire [3:0]din[5:0];
    wire [3:0]rst_din[5:0];
    assign din[5] = 4'h0;
    assign din[4] = (hh[3:0]==4'h9)?4'h0:4'h1;
    assign din[3] = 4'h0;
    assign din[2] = 4'h0;
    assign din[1] = 4'h0;
    assign din[0] = 4'h0;
    assign rst_din[5] = 4'h1;
    assign rst_din[4] = 4'h2;
    assign rst_din[3] = 4'h0;
    assign rst_din[2] = 4'h0;
    assign rst_din[1] = 4'h0;
    assign rst_din[0] = 4'h0;
    bcd_SynIn ss0(clk,reset,rst_din[0],enable[0],load[0],din[0],ss[3:0]);
    bcd_SynIn ss1(clk,reset,rst_din[1],enable[1],load[1],din[1],ss[7:4]);
    bcd_SynIn mm0(clk,reset,rst_din[2],enable[2],load[2],din[2],mm[3:0]);
    bcd_SynIn mm1(clk,reset,rst_din[3],enable[3],load[3],din[3],mm[7:4]);
    bcd_SynIn hh0(clk,reset,rst_din[4],enable[4],load[4],din[4],hh[3:0]);
    bcd_SynIn hh1(clk,reset,rst_din[5],enable[5],load[5],din[5],hh[7:4]);
    // control signal
    assign enable[0] = ena;
    assign enable[1] = (ss[3:0]==4'h9)?enable[0]:1'b0;
    assign enable[2] = (ss[7:4]==4'h5)?enable[1]:1'b0;
    assign enable[3] = (mm[3:0]==4'h9)?enable[2]:1'b0;
    assign enable[4] = (mm[7:4]==4'h5)?enable[3]:1'b0;
    assign enable[5] = (hh[3:0]==4'h9)?enable[4]:1'b0;
    assign load[0] = (ss[3:0]==4'h9)?enable[0]:1'b0;
    assign load[1] = (ss[7:4]==4'h5)?enable[1]:1'b0;
    assign load[2] = (mm[3:0]==4'h9)?enable[2]:1'b0;
    assign load[3] = (mm[7:4]==4'h5)?enable[3]:1'b0;
    assign load[4] = (hh==8'h09)||(hh==8'h12)?enable[4]:1'b0;
    assign load[5] = (hh==8'h12)?enable[4]:1'b0;
    
    always@(posedge clk) begin
    	pm <= (hh==8'h11)&&(enable[4])?~pm:pm;
    end
endmodule
module bcd_SynIn(
	input clk,
    input reset,
    input [3:0]rst_din,
    input enable,
    input load,
    input [3:0]din,
    output [3:0]Q
);
    always@(posedge clk)begin
        if(reset)begin
            Q <= rst_din;
        end else begin
            if(load)begin
                Q <= din;
            end else begin
            	Q <= enable?Q+4'h1:Q;
            end
        end
    end
endmodule