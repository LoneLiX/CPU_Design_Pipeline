module EXT11_16(
  input[10:0] in,
  output[15:0] out
);

  assign out={{(5){in[10]}},in};
endmodule
