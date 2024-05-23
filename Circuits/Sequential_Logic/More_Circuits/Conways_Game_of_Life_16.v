module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    wire [255:0]q_next;
    wire [287:0]q_tmp;
    wire [3:0]nb_sum;
    assign q_tmp = {q[15:0],q,q[255:240]};
    // 15-0
    // 271-16
    // 287-272
    always@(*)begin
        for(int i=16;i<272;i=i+1)begin
            // control signal
            if(i%16 == 0)begin
                nb_sum = q_tmp[i-1]+q_tmp[i-16]+q_tmp[i-15]
                +q_tmp[i+1]+q_tmp[i+15]
                +q_tmp[i+31]+q_tmp[i+16]+q_tmp[i+17];
            end else if(i%16 == 15)begin
                nb_sum = q_tmp[i-17]+q_tmp[i-16]+q_tmp[i-31]
                +q_tmp[i-15]+q_tmp[i-1]
            	+q_tmp[i+15]+q_tmp[i+16]+q_tmp[i+1];
            end else begin
                nb_sum = q_tmp[i-17]+q_tmp[i-16]+q_tmp[i-15]
            	+q_tmp[i+1]+q_tmp[i-1]
            	+q_tmp[i+15]+q_tmp[i+16]+q_tmp[i+17];
            end
            if(nb_sum <= 1) begin
                q_next[i-16] = 0;
            end else if(nb_sum == 2) begin
                q_next[i-16] = q[i-16];
            end else if(nb_sum == 3) begin
                q_next[i-16] = 1;
            end else begin
                q_next[i-16] = 0;
            end
        end
    end
    always@(posedge clk)begin
        if(load)
            q <= data;
        else
            q <= q_next;
    end
endmodule
/*0000 0000 0000 0000
0000 0000 0000 0111
0000 0000 0000 0000
0000 0000 0000 0010
110
2000000000000000000000000000000000000000000000000000000000006
2000000000000000000000000000000000000000000000000000000020002*/