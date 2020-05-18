module EX_MEM(
input Clk,
input Reset,
input Flush,
input[4:0]ControlsIn,
input[15:0]ResultIn,
input ZeroIn,
input[15:0]DataIn,
input[15:0]MemAddrIn,
input[15:0]JEQAddrIn,
input[2:0]Reg1In,

output[4:0]ControlsOut,
output[15:0]ResultOut,
output ZeroOut,
output[15:0]DataOut,
output[15:0]MemAddrOut,
output[15:0]JEQAddrOut,
output[2:0]Reg1Out
);

reg[72:0]R;
assign ControlsOut=R[72:68];
assign ResultOut=R[67:52];
assign ZeroOut=R[51];
assign DataOut=R[50:35];
assign MemAddrOut=R[34:19];
assign JEQAddrOut=R[18:3];
assign Reg1Out=R[2:0];

always@(posedge Clk)
if(Reset)R<=0;
else if(Flush)R<=0;
else begin
R[72:68]<=ControlsIn;
R[67:52]<=ResultIn;
R[51]<=ZeroIn;
R[50:35]<=DataIn;
R[34:19]<=MemAddrIn;
R[18:3]<=JEQAddrIn;
R[2:0]<=Reg1In;
end
endmodule
