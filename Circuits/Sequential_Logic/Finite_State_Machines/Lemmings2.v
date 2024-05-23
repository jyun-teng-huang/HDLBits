module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    // state
	parameter LEFT=2'd0, RIGHT=2'd1, LEFTFALL=2'd2, RIGHTFALL=2'd3;
    reg [1:0]state;
    reg [1:0]next_state;
    always@(*)begin
        case(state)
            LEFT: next_state = ground?(bump_left?RIGHT:LEFT):LEFTFALL;
            RIGHT: next_state = ground?(bump_right?LEFT:RIGHT):RIGHTFALL;
            LEFTFALL: next_state = ground?(LEFT):LEFTFALL;
            RIGHTFALL: next_state = ground?(RIGHT):RIGHTFALL;
            default: next_state = ground?(bump_left?RIGHT:LEFT):LEFTFALL;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    assign walk_left = state==LEFT;
    assign walk_right = state==RIGHT;
    assign aaah = state==LEFTFALL|state==RIGHTFALL;
endmodule