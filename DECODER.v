module DECODER(opcode,controls);
input[4:0] opcode;
output reg[7:0]controls;
/*
controls[7]:MemRead
controls[6]:MemWrite
controls[5]:Result_Memdata 1:result from ALU 0: Memory
controls[4]:JEQ
controls[3]:JMP
controls[2]Aluop
controls[1]Result_Imm 1:result from ALU 0:Immediate number
controls[0]RegWrite
*/
parameter NOP=5'b00000,ADD=5'b00001,SUB=5'b00010,MOVI=5'b00011;
parameter LODR=5'b00100,STOR=5'b00101,JMP=5'b00110,JEQ=5'b00111;
always@(opcode)
case(opcode)
NOP:controls=8'b00000010;
ADD:controls=8'b00100011;
SUB:controls=8'b00100111;
MOVI:controls=8'b00100001;
LODR:controls=8'b10000011;
STOR:controls=8'b01000010;
JMP:controls=8'b00101010;
JEQ:controls=8'b00110110;
default:controls=8'b00000010;
endcase
endmodule
