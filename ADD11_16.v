module ADD11_16(in11,in16,out);
input[11:0]in11;
input[15:0]in16;
output[15:0]out;

wire[15:0]temp;
assign temp={{(5){in11[10]}},in11};
assign out=temp+in16;
endmodule

