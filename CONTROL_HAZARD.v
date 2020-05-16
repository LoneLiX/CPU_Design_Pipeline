module CONTROL_HARZARD(JEQControl,JMPControl,IF_IDFLUSH,ID_EXFLUSH,EX_MAFLUSH);
input JEQControl,JMPControl;
output reg IF_IDFLUSH,ID_EXFLUSH,EX_MAFLUSH;
always@(JMPControl,JEQControl)
if(JMPControl)begin assign IF_IDFLUSH=1;assign ID_EXFLUSH=1;end
else if(JEQControl)begin assign IF_IDFLUSH=1;assign ID_EXFLUSH=1;assign EX_MAFLUSH=1;end
else begin assign IF_IDFLUSH=0;assign ID_EXFLUSH=0;assign EX_MAFLUSH=0;end
endmodule
