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
	parameter left=0,right=1,fallleft=3'd2,fallright=3'd3,digleft=4,digright=5,splatter=6;
    reg [2:0]state;
    reg [2:0]next_state;
    reg [8:0]fall_counter;
    always@(*)begin
        case(state)
            left	 : next_state = ground?(dig?digleft:(bump_left?right:left)):fallleft;
            right	 : next_state = ground?(dig?digright:(bump_right?left:right)):fallright;
            fallleft : next_state = ground?(fall_counter>19?splatter:left):fallleft;
            fallright: next_state = ground?(fall_counter>19?splatter:right):fallright;
            digleft	 : next_state = ground?digleft:fallleft;
            digright : next_state = ground?digright:fallright;
            splatter : next_state = splatter;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset) state <= left;
        else state <= next_state;
    end
    always@(posedge clk)begin
        if(state == fallleft | state == fallright)
        	fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end
    assign walk_left = state==left&state!=digleft&state!=digright&state!=splatter;
    assign walk_right = state==right&state!=digleft&state!=digright&state!=splatter;
    assign aaah = state==fallleft|state==fallright&state!=splatter;
    assign digging = state==digleft|state==digright&state!=splatter;
endmodule
