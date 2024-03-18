module nmos_pmos_ex (
  input d,
  ctrl,
  output outn,
  outp
);

  nmos (outn, d, ctrl);
  pmos (outp, d, ctrl);
endmodule
