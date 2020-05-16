module ADD5_16(in5,in16,out);
input[4:0]in5;
input[15:0]in16;
output[15:0]out;

wire[15:0]temp;
assign temp={{(11){in5[4]}},in5};
assign out=temp+in16;
endmodule
