module PC(clk,reset,AddrIn,AddrOut);
  input clk;
  input reset;  
  input[15:0] AddrIn;
  output[15:0] AddrOut;

  reg[15:0] R;
  assign AddrOut=R;
  always @(posedge clk)
    if (reset) R<=0;
    else R<=AddrIn;
endmodule
