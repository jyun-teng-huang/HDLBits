module top_module (input x, input y, output z);
	wire a1z,a2z,b1z,b2z;
    q4a IA1(.x(x),.y(y),.z(a1z));
    q4b IB1(.x(x),.y(y),.z(b1z));
    q4a IA2(.x(x),.y(y),.z(a2z));
    q4b IB2(.x(x),.y(y),.z(b2z));
    assign z = (a1z|b1z)^(a2z&b2z);
    
endmodule
module q4a (input x, input y, output z);
    assign z = (x^y) & x;
endmodule
module q4b ( input x, input y, output z );
    assign z = ~(x^y);
endmodule

