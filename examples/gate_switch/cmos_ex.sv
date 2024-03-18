module cmos_ex (
  input d,
  nctrl,
  pctrl,
  output out
);
  cmos (out, d, nctrl, pctrl);
endmodule
