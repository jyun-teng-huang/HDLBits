module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    always@(*)begin
        if (vibrate_mode == 1'b1) begin
            motor = ring;
            ringer = 1'b0;
        end else begin
            motor = 1'b0;
            ringer = ring;
        end
    end

endmodule
