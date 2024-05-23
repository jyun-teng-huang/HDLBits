module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [1:0]pht[127:0];
    //pattern history table
    wire [6:0]train_entry;
    assign train_entry = train_pc^train_history;
    wire [127:0]train_valid_n;
    // sel entry
    demux train_demux(.valid(train_valid),.entry(train_entry),.valid_n(train_valid_n));
	// 128 entry table
    genvar i;
    generate
        for(i=0;i<127;i=i+1) begin : block1
            saturating_counter duti(.clk(clk),.areset(areset),
                                    .train_valid(train_valid_n[i]),
                                    .train_taken(train_taken),
                                    .state(pht[i]));
        end
    endgenerate
    // read 128 entry table
    wire [6:0]predict_entry;
    assign predict_entry = predict_pc^predict_history;
    assign predict_taken = pht[predict_entry][1];
    //history_reg
    always@(posedge clk, posedge areset)begin
        if(areset) predict_history <= 7'b0;
        else begin
            if(train_valid)begin
            	if(train_mispredicted) predict_history <= {train_history[5:0],train_taken};
            	else if(predict_valid) predict_history <= {predict_history[5:0],predict_taken};
            	else predict_history <= predict_history;
            end else if(predict_valid) begin
                predict_history <= {predict_history[5:0],predict_taken};
            end else predict_history <= predict_history;
        end
    end
endmodule
module saturating_counter(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT=2'b00,WNT=2'b01,WT=2'b10,ST=2'b11;
    wire [1:0]next;
    always@(*)begin
        case(state)
            SNT: next = train_taken?WNT:SNT;
            WNT: next = train_taken?WT:SNT;
            WT : next = train_taken?ST:WNT;
            ST : next = train_taken?ST:WT;
            default: next = next;
        endcase
    end
    always@(posedge clk, posedge areset)begin
        if(areset) state <= WNT;
        else state <= train_valid?next:state;
    end
endmodule
module demux(
    input valid,
    input [6:0]entry,
    output [127:0]valid_n
);
    always@(*)begin
        for(int i=0;i<127;i=i+1)begin
            valid_n[i] = entry==i?valid:1'b0;
        end
    end
endmodule