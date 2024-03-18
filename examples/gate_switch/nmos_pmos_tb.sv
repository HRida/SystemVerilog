module nmos_pmos_tb;
  reg d, ctrl;
  wire outn, outp;

  nmos_pmos_ex dut (
    .d(d),
    .ctrl(ctrl),
    .outn(outn),
    .outp(outp)
  );

  initial begin
    {d, ctrl} <= 0;

    $monitor("T=%0t d=%b ctrl=%b outn=%b outp=%b", $time, d, ctrl, outn, outp);

    #10 d <= 1;
    #10 ctrl <= 1;
    #10 ctrl <= 0;
    #10 d <= 0;
  end
endmodule
