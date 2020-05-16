module IMEM(Addr,Ins);
input[15:0]Addr;
output[15:0]Ins;

wire[15:0]ROM[32:0];
assign Ins=ROM[Addr];
endmodule
//uninitialize