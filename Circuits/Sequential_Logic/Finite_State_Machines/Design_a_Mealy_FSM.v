module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
	parameter s0=2'd0,s1=2'd1,s2=2'd2;
    reg [1:0]state, next;
    // ?101
    always@(*)begin
        case(state)
            s0: next = x?s1:s0;
            s1: next = x?s1:s2;
            s2: next = x?s1:s0;
        endcase
    end
    always@(posedge clk, negedge aresetn)begin
        if(~aresetn) state <= s0;
        else state <=  next;
    end
    assign z = state==s2 & x;
endmodule
