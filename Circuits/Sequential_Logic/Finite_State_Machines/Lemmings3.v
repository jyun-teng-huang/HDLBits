module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
	parameter left=0,right=1,fallleft=2,fallright=3,digleft=4,digright=5;
    reg [2:0]state;
    reg [2:0]next_state;
    always@(*)begin
        case(state)
            left	 : next_state = ground?(dig?digleft:(bump_left?right:left)):fallleft;
            right	 : next_state = ground?(dig?digright:(bump_right?left:right)):fallright;
            fallleft : next_state = ground?left:fallleft;
            fallright: next_state = ground?right:fallright;
            digleft	 : next_state = ground?digleft:fallleft;
            digright : next_state = ground?digright:fallright;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset) state <= left;
        else state <= next_state;
    end
    assign walk_left = state==left&state!=digleft&state!=digright;
    assign walk_right = state==right&state!=digleft&state!=digright;
    assign aaah = state==fallleft|state==fallright;
    assign digging = state==digleft|state==digright;
endmodule
