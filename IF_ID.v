module IF_ID(Clk,Reset,Flush,InsIn,PCIn,InsOut,PCOut);
input Clk;
input Reset;
input Flush;
input[15:0]InsIn;
input[15:0]PCIn;
output[15:0]InsOut;
output[15:0]PCOut;

reg[31:0]R;
assign InsOut=R[31:16];
assign PCOut=R[15:0];
always@(posedge Clk)
if(Reset)R<=0;
else if(Flush)R<=0;
else begin R[31:16]<=InsIn;R[15:0]<=PCIn;end
endmodule

