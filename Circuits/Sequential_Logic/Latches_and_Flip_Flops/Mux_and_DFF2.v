module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire Q_buf;
	wire mux1_o;
    wire mux2_o;
    assign Q = Q_buf;
    assign mux1_o = E?w:Q_buf;
    assign mux2_o = L?R:mux1_o;
    always@(posedge clk)begin
        Q_buf <= mux2_o;
    end
endmodule
