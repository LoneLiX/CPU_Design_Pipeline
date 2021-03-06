`timescale 1 ns/1 ns
module CPU();
reg clk;
reg reset;

wire[15:0]AddrFromAddrMUX2;
wire[15:0]AddrToPC;
assign AddrToPC=AddrFromAddrMUX2;
wire[15:0]AddrFromPC;
PC pc(clk,reset,AddrToPC,AddrFromPC);

wire[15:0]AddrToIMEM;
assign AddrToIMEM=AddrFromPC;
wire[15:0]InsFromIMEM;
IMEM imem(AddrToIMEM,InsFromIMEM);
wire[15:0]InsToIFID;
assign InsToIFID=InsFromIMEM;
wire[15:0]AddrToIFID;
assign AddrToIFID=AddrFromPC;
wire[15:0]InsFromIFID;
wire[15:0]AddrFromIFID;
wire FlushIFID;
IF_ID ifid(clk,reset,FlushIFID,InsToIFID,AddrToIFID,InsFromIFID,AddrFromIFID);
wire[4:0] OpcodeToDecoder;
assign OpcodeToDecoder=InsFromIFID[15:11];
wire[7:0]ControlsFromDecoder;
DECODER decoder(OpcodeToDecoder,ControlsFromDecoder);
wire RegWriteFromMEMWB;
wire RegWriteToRG;
assign RegWriteToRG=RegWriteFromMEMWB;
wire[2:0]Reg1ToRG;
assign Reg1ToRG=InsFromIFID[10:8];
wire[2:0]Reg2ToRG;
assign Reg2ToRG=InsFromIFID[7:5];
wire[2:0]Reg1FromMEMWB;
wire[2:0]Reg3ToRG;
assign Reg3ToRG=Reg1FromMEMWB;
wire[15:0]ResultFromMEMWB;
wire[15:0]Data3ToRG;
assign Data3ToRG=ResultFromMEMWB;
wire[15:0]Data1FromRG;
wire[15:0]Data2FromRG;
RG rg(clk,Reg1ToRG,Reg2ToRG,Reg3ToRG,Data1FromRG,Data2FromRG,Data3ToRG,RegWriteToRG);
wire[4:0]Offset5TOADDER5;
assign Offset5TOADDER5=InsFromIFID[4:0];
wire[15:0]AddrToADDER5;
assign AddrToADDER5=AddrFromIFID;
wire[15:0]JEQAddrFromADDER5;
ADD5_16 JEQADDR(Offset5TOADDER5,AddrToADDER5,JEQAddrFromADDER5);
wire[10:0]Offset11TOADDER11;
assign Offset11TOADDER11=InsFromIFID[10:0];
wire[15:0]AddrToADDER11;
assign AddrToADDER11=AddrFromIFID;
wire[15:0]JMPAddrFromADDER11;
ADD11_16 JMPaddr(Offset11TOADDER11,AddrToADDER11,JMPAddrFromADDER11);

wire[7:0]ControlsToIDEX;
assign ControlsToIDEX=ControlsFromDecoder;
wire[15:0]Data1ToIDEX;
assign Data1ToIDEX=Data1FromRG;
wire[15:0]Data2ToIDEX;
assign Data2ToIDEX=Data2FromRG;
wire[15:0]JEQAddrToIDEX;
assign JEQAddrToIDEX=JEQAddrFromADDER5;
wire[15:0]JMPAddrToIDEX;
assign JMPAddrToIDEX=JMPAddrFromADDER11;
wire[7:0]Imm8ToIDEX;
assign Imm8ToIDEX=InsFromIFID[7:0];
wire[2:0]Reg1ToIDEX;
wire[2:0]Reg2ToIDEX;
assign Reg1ToIDEX=InsFromIFID[10:8];
assign Reg2ToIDEX=InsFromIFID[7:5];
wire FlushIDEX;//flush signal

wire[7:0]ControlsFromIDEX;
wire[15:0]Data1FromIDEX;
wire[15:0]Data2FromIDEX;
wire[15:0]JEQAddrFromIDEX;
wire[15:0]JMPAddrFromIDEX;
wire[7:0]Imm8FromIDEX;
wire[2:0]Reg1FromIDEX;
wire[2:0]Reg2FromIDEX;

ID_EX idex(clk,reset,FlushIDEX,ControlsToIDEX,Data1ToIDEX,Data2ToIDEX,JEQAddrToIDEX,JMPAddrToIDEX,Imm8ToIDEX,Reg1ToIDEX,Reg2ToIDEX,ControlsFromIDEX,Data1FromIDEX,Data2FromIDEX,JEQAddrFromIDEX,JMPAddrFromIDEX,Imm8FromIDEX,Reg1FromIDEX,Reg2FromIDEX);
wire[15:0]Data1ToMux1;
wire[15:0]Data2ToMux2;
assign Data1ToMux1=Data1FromIDEX;
assign Data2ToMux2=Data2FromIDEX;
wire[15:0]ResultToMux1;   
wire[15:0]ResultToMux2;

wire SelectMux1;
wire SelectMux2;
wire[15:0]Mux1Data1ToALu;
wire[15:0]Mux2Data2ToALu;
MUX2_1 AluData1Mux(Data1ToMux1,ResultToMux1,SelectMux1,Mux1Data1ToALu);
MUX2_1 AluData2Mux(Data2ToMux2,ResultToMux2,SelectMux2,Mux2Data2ToALu);
wire AluopToAlu;
assign AluopToAlu=ControlsFromIDEX[2];
wire[15:0]ResultFromAlu;
wire ZeroFromAlu;
ALU alu(Mux1Data1ToALu,Mux2Data2ToALu,AluopToAlu,ResultFromAlu,ZeroFromAlu);
wire[7:0]Imm8ToSEXT8;
assign Imm8ToSEXT8=Imm8FromIDEX;
wire[15:0]Imm16FromSEXT8;
EXT8_16 imm8_16(Imm8ToSEXT8,Imm16FromSEXT8);

wire JMPFlag;
assign JMPFlag=ControlsFromIDEX[3];

wire opToMUXResultorImm;
assign opToMUXResultorImm=ControlsFromIDEX[1];//1 ALU result, 0 Imm
wire[15:0]Data1ToMUXResultorImm;
wire[15:0]Data0ToMUXResultorImm;
assign Data0ToMUXResultorImm=Imm16FromSEXT8;
assign Data1ToMUXResultorImm=ResultFromAlu;
wire[15:0]DataFromMUXResultorImm;
MUX2_1 MUXResultorImm(Data0ToMUXResultorImm,Data1ToMUXResultorImm,opToMUXResultorImm,DataFromMUXResultorImm);
//EX_MEM
wire[4:0]ControlsToEXMEM;
assign ControlsToEXMEM={ControlsFromIDEX[7],ControlsFromIDEX[6],ControlsFromIDEX[4],ControlsFromIDEX[5],ControlsFromIDEX[0]};
wire[15:0]ResultToEXMEM;
assign ResultToEXMEM=DataFromMUXResultorImm;
wire ZeroToEXMEM;
assign ZeroToEXMEM=ZeroFromAlu;
wire[15:0] MemAddrToEXMEM;
assign MemAddrToEXMEM=Data2FromIDEX;
wire[15:0]DataToEXMEM;
assign DataToEXMEM=Data1FromIDEX;
wire[15:0]JEQAddrToEXMEM;
assign JEQAddrToEXMEM=JEQAddrFromIDEX;
wire[2:0]Reg1ToEXMEM;
assign Reg1ToEXMEM=Reg1FromIDEX;
wire FlushEXMEM;

wire[4:0]ControlsFromEXMEM;
wire[15:0]ResultFromEXMEM;
wire ZeroFromEXMEM;
wire[15:0]MemAddrFromEXMEM;
wire[15:0]DataFromEXMEM;
wire[15:0]JEQAddrFromEXMEM;
wire[2:0]Reg1FromEXMEM;

EX_MEM exmem(clk,reset,FlushEXMEM,ControlsToEXMEM,ResultToEXMEM,ZeroToEXMEM,DataToEXMEM,MemAddrToEXMEM,JEQAddrToEXMEM,Reg1ToEXMEM,ControlsFromEXMEM,ResultFromEXMEM,ZeroFromEXMEM,DataFromEXMEM,MemAddrFromEXMEM,JEQAddrFromEXMEM,Reg1FromEXMEM);

assign ResultToMux1=ResultFromEXMEM;
assign ResultToMux2=ResultFromEXMEM;
//DMEM
wire ReadToDMEM;
assign ReadToDMEM=ControlsFromEXMEM[4];
wire WriteToDMEM;
assign WriteToDMEM=ControlsFromEXMEM[3];
wire[15:0]AddrToDMEM;
assign AddrToDMEM=MemAddrFromEXMEM;
wire[15:0]DataToDMEM;
assign DataToDMEM=DataFromEXMEM;
wire[15:0]DataFromDMEM;
DMEM dmem(clk,ReadToDMEM,WriteToDMEM,AddrToDMEM,DataToDMEM,DataFromDMEM);

wire JEQFlag;
wire JEQSignal;
assign JEQSignal=ControlsFromEXMEM[2];
AND JEQFLAG(ZeroFromEXMEM,JEQSignal,JEQFlag);

//CONTROL HAZARD
CONTROL_HAZARD controlhazard(JEQFlag,JMPFlag,FlushIFID,FlushIDEX,FlushEXMEM);

//DATA HAZARD
wire EXMEM_WB;
assign EXMEM_WB=ControlsFromEXMEM[0];
DATA_HARZARD datahazard(EXMEM_WB,Reg1FromEXMEM,Reg1FromIDEX,Reg2FromIDEX,SelectMux1,SelectMux2);

wire opToMUXResultorMem;
assign opToMUXResultorMem=ControlsFromEXMEM[1];//1-result 0-Mem
wire[15:0]Data0ToMUXResultorMem;
assign Data0ToMUXResultorMem=DataFromDMEM;
wire[15:0]Data1ToMUXResultorMem;
assign Data1ToMUXResultorMem=ResultFromEXMEM;
wire[15:0]DataFromMUXResultorMem;
MUX2_1 MUXResultorMem(Data0ToMUXResultorMem,Data1ToMUXResultorMem,opToMUXResultorMem,DataFromMUXResultorMem);

wire RegWriteToMEMWB;
assign RegWriteToMEMWB=ControlsFromEXMEM[0];
wire[15:0]ResultToMEMWB;
assign ResultToMEMWB=DataFromMUXResultorMem;
wire[2:0]Reg1ToMEMWB;
assign Reg1ToMEMWB=Reg1FromEXMEM;
MEM_WB memwb(clk,reset,RegWriteToMEMWB,ResultToMEMWB,Reg1ToMEMWB,RegWriteFromMEMWB,ResultFromMEMWB,Reg1FromMEMWB);

wire[15:0]AddrToPCPLUS;
assign AddrToPCPLUS=AddrFromPC;
wire[15:0]AddrFromPCPLUS;
PCPLUS pcplus(AddrToPCPLUS,AddrFromPCPLUS);

wire opToAddrMUX1;
assign opToAddrMUX1=JMPFlag;//JMP
wire[15:0]Addr0ToAddrMUX1;
assign Addr0ToAddrMUX1=AddrFromPCPLUS;
wire[15:0]Addr1ToAddrMUX1;
assign Addr1ToAddrMUX1=JMPAddrFromIDEX;
wire[15:0]AddrFromAddrMUX1;
MUX2_1 AddrMUX1(Addr0ToAddrMUX1,Addr1ToAddrMUX1,opToAddrMUX1,AddrFromAddrMUX1);

wire opToAddrMUX2;
assign opToAddrMUX2=JEQFlag;
wire[15:0]Addr0ToAddrMUX2;
assign Addr0ToAddrMUX2=AddrFromAddrMUX1;
wire[15:0]Addr1ToAddrMUX2;
assign Addr1ToAddrMUX2=JEQAddrFromEXMEM;
MUX2_1 AddrMUX2(Addr0ToAddrMUX2,Addr1ToAddrMUX2,opToAddrMUX2,AddrFromAddrMUX2);

initial clk=0;
always #5 clk=~clk;
initial begin reset=1;#10;reset=0;end
endmodule

