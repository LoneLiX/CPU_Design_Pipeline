module MUX2_1(a0,a1,s,y);
input [15:0] a0,a1;
input s;
output [15:0]y;
assign y=s? a1:a0;
endmodule
