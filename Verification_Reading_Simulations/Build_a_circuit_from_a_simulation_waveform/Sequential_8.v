module top_module (
    input clock,
    input a,
    output p,
    output q=0 );
    reg a_q;

    always@(negedge clock)begin
        a_q <= a;
        q <= a;
    end
    
    assign p = clock?a:a_q;
endmodule
