module gate_4x2_encoder (
  input a,
  b,
  c,
  d,
  output x,
  y
);
  or (x, b, d);
  or (y, c, d);
endmodule
