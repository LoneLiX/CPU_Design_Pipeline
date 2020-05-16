module RG(Clk, R1, R2, R3, D1, D2, D3, RegWrite);
input [2:0] R1,R2,R3;
input [15:0]D3;
input Clk;
input RegWrite;
output [15:0]D1,D2;

reg[15:0]RAM[7:0];

assign D1=RAM[R1];
assign D2=RAM[R2];

always@(posedge Clk)
if(RegWrite==1)RAM[R3]=D3;
initial
begin
RAM[0]=0;
RAM[1]=1;
RAM[2]=2;
RAM[3]=3;
RAM[4]=4;
RAM[5]=5;
RAM[6]=6;
RAM[7]=7;
end
endmodule
