module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0]state, next;
    always@(*)begin
        case(state)
            A: next = r[1]?B:(r[1]|r[2]|r[3]?(~r[1]&r[2]?C:(~r[1]&~r[2]&r[3]?D:state)):A);
            B: next = r[1]?B:A;
            C: next = r[2]?C:A;
            D: next = r[3]?D:A;
            default: next = A;
        endcase
        
    end
    always@(posedge clk)begin
        if(~resetn) state <= A;
        else state <= next;
    end
    assign g = {state==D,state==C,state==B};

endmodule
