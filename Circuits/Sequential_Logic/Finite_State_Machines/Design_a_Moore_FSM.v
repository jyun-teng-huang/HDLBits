module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [2:0]state;
  
    always@(*)begin
        case(state)
            3'b000: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
            end
            3'b001:begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
            end
            3'b011:begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
            end
            3'b111:begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
            end
            default:begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
            end
        endcase
    end
    always@(posedge clk)begin
        if(reset)begin
            state <= 3'b000;
            dfr <= 1;
        end else begin
            state <= s;
            dfr <= (state<s)?1'b0:(state>s)?1'b1:dfr;
        end
        

    end
endmodule
