module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    parameter a=8'd0,b=8'd1,c=8'd2,d=8'd3,e=8'd4;
    reg [7:0]state,next;
    always@(*)begin
        case(state)
        	a: next = data?b:a;
            b: next = data?c:a;
            c: next = data?c:d;
            d: next = data?e:a;
            e: next = e;
            default: next = a;
        endcase
    end
    always@(posedge clk)begin
        if(reset) state<=a;
        else state<=next;
    end
    assign start_shifting = (state==e);

endmodule
