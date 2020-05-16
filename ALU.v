module ALU(
input[15:0] dataA,
input[15:0] dataB,
input op,
output reg[15:0] result,
output zero
);

assign zero=~|result;
always @(dataA,dataB,op)
case (op)
1'b0:result=dataA+dataB;
1'b1:result=dataA-dataB;
endcase
endmodule
