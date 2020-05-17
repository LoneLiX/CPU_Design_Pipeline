module MEM_WB(
input clk,
input reset,
input controlsIn,
input[15:0] result2In,
input[2:0] Reg1In,
output controlsOut,
output[15:0] result2Out,
output[2:0] Reg1Out
);

reg[19:0] R;
assign controlsOut=R[19];
assign result2Out=R[18:3];
assign Reg1Out=R[2:0];

always@(posedge clk)
if (reset) R<=0;
else begin
R[19]<=controlsIn;
R[18:3]<=result2In;
R[2:0]<=Reg1In; 
end
endmodule

