module DMEM(
input Clk,
input Read,
input Write,
input[15:0]Address,
input[15:0]DataIn,
output reg[15:0]DataOut 
);

reg[15:0] RAM[15:0];
  
always @(negedge Clk)
if (Read==1&&Write==0) DataOut=RAM[Address];
else if (Read==0&&Write==1) RAM[Address]=DataIn;
else DataOut=16'hzzzz;
endmodule
