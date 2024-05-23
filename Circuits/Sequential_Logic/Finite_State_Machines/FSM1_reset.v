// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;
	parameter B=1, A=0;
    // Fill in state name declarations

    reg present_state, next_state;
    always @(*)begin
        case (present_state)
            // Fill in state transition logic
            B: begin 
                next_state = in?B:A; 
            	out = 1;end
            A: begin 
                next_state = in?A:B;
            	out = 0; end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
            present_state <= B;
        end else begin
            

            // State flip-flops
            present_state <= next_state;   


        end
    end
    
    

endmodule
