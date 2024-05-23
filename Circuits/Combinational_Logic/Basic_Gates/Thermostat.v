module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    assign heater = (mode)?((too_cold)?1'b1:1'b0):1'b0;
    assign aircon = (mode)?1'b0:((too_hot)?1'b1:1'b0);
    assign fan = (fan_on)?1'b1:1'b0 | (mode)?((too_cold)?1'b1:1'b0):((too_hot)?1'b1:1'b0);
endmodule
