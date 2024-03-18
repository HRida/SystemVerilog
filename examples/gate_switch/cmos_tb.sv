module cmos_tb;
  reg d, nctrl, pctrl;
  wire out;
  cmos_ex dut (
    .d(d),
    .nctrl(nctrl),
    .pctri(pctrl),
    .out(out)
  );

  initial begin
    {d, nctrl, pctrl} <= 0;

    $monitor("T=%0t d=%0b nctrl-%0b pctrl-%0b out-%0b", $time, d, nctrl, pctrl, out);

    #10 d <= 1;
    #10 nctrl <= 1;
    #10 pctrl <= 1;
    #10 nctrl <= 0;
    #10 pctrl <= 0;
    #10 d <= 0;
    #10;
  end
endmodule
