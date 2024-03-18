module gate_2x1_mux (
  input a,
  b,
  sel,
  output out
);

  wire  sel_n;
  wire  out_0;
  logic out_1;

  not (sel_n, sel);
  and (out_0, a, sel);
  and (out_1, b, sel_n);
  or (out, out_0, out_1);
endmodule
