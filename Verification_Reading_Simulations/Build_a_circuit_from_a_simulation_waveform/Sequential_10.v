module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    always@(posedge clk)begin
        case({a,b})
            2'b11: state <= 1'b1;
            2'b00: state <= 1'b0;
            default: state <= state;
        endcase
    end
    assign q = state?~a^b:a^b;
endmodule
