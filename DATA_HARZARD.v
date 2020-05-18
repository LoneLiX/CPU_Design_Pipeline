module DATA_HARZARD(
input EX_MEM_RW,
input[2:0]EX_MEM_Reg1,
input[2:0]ID_EX_Reg1,
input[2:0]ID_EX_Reg2,
output reg S_D1_Result,
output reg S_D2_Result
);
always@(EX_MEM_RW,EX_MEM_Reg1,ID_EX_Reg1,ID_EX_Reg2)
begin
if(EX_MEM_RW)
begin
if(EX_MEM_Reg1==ID_EX_Reg1)
S_D1_Result=1;
else S_D1_Result=0;
if(EX_MEM_Reg1==ID_EX_Reg2)
S_D2_Result=1;
else S_D2_Result=0;
end
else
begin
S_D1_Result=0;
S_D2_Result=0;
end
end
endmodule
