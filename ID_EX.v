module ID_EX(Clk,Reset,Flush,ControlsIn,Data1In,Data2In,JEQAddrIn,JMPAddrIn,Imm8In,Reg1In,Reg2In,ControlsOut,Data1Out,Data2Out,JEQAddrOut,JMPAddrOut,Imm8Out,Reg1Out,Reg2Out);
input Clk,Reset,Flush;
input[7:0]ControlsIn;
input[15:0]Data1In;
input[15:0]Data2In;
input[15:0]JEQAddrIn;
input[15:0]JMPAddrIn;
input[7:0]Imm8In;
input[2:0]Reg1In;
input[2:0]Reg2In;
output[7:0]ControlsOut;
output[15:0]Data1Out;
output[15:0]Data2Out;
output[15:0]JEQAddrOut;
output[15:0]JMPAddrOut;
output[7:0]Imm8Out;
output[2:0]Reg1Out;
output[2:0]Reg2Out;

reg[85:0]R;
assign ControlsOut=R[85:78];
assign Data1Out=R[77:62];
assign Data2Out=R[61:46];
assign JEQAddrOut=R[45:30];
assign JMPAddrOut=R[29:14];
assign Imm8Out=R[13:6];
assign Reg1Out=R[5:3];
assign Reg2Out=R[2:0];

always@(posedge Clk)
if(Reset)R<=0;
else if(Flush)R<=0;
else begin R[85:78]<=ControlsIn;R[77:62]<=Data1In;R[61:46]<=Data2In;R[45:30]<=JEQAddrIn;R[29:14]<=JMPAddrIn;R[13:6]<=Imm8In;R[5:3]<=Reg1In;R[2:0]<=Reg2In;end
endmodule

