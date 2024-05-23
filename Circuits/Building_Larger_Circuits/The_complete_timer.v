module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    //FSM
    parameter s=4'd0,s1=4'd1,s11=4'd2,s110=4'd3,d0=4'd4,d1=4'd5,d2=4'd6,d3=4'd7,c=4'd8,wait_ack=4'd9;
    reg [3:0]state,next;
    always@(*)begin
        case(state)
            s   : next = data?s1:s;
            s1  : next = data?s11:s;
            s11 : next = data?s11:s110;
            s110: next = data?d0:s;
            d0: next = d1;
            d1: next = d2;
            d2: next = d3;
            d3: next = c;
            c: next = (c1000&count==0)?wait_ack:c;
            wait_ack: next = ack?s:wait_ack;
            default: next = s;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state <= s;
        else state <= next;
    end
    // counter
    wire [9:0]q;
    reg c1000;
    always@(posedge clk)begin
        if(state!=c) begin 
            q<=10'b0;
        end else if(q<999) begin 
            q<=q+10'b1;
        end else begin 
            q<=10'b0;
        end
        if(q==998) c1000<=1'b1;
        else c1000<=1'b0;
    end
    //output
    always@(posedge clk)begin
        if(state==d0) count[3] <= data;
        else if(state==d1) count[2] <= data;
        else if(state==d2) count[1] <= data;
        else if(state==d3) count[0] <= data;
        else if(state==c) begin
            if(c1000 & count!=0) count <= count -1;
            else count <= count;
        end
    end
    assign counting = state==c;
    assign done = state==wait_ack;
endmodule
