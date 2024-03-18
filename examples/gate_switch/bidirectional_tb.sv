module bidirectional_tb;

  reg io1, ctrl;
  wire io2;

  bidirectional_tran dut1 (
    .io1(io1),
    .ctrl(ctrl),
    .io2(io2)
  );

  bidirectional_tranif0 dut2 (
    .io1(io1),
    .ctrl(ctrl),
    .io2(io2)
  );

  bidirectional_tranif1 dut3 (
    .io1(io1),
    .ctrl(ctrl),
    .io2(io2)
  );
  initial begin
    {io1, ctrl} <= 0;

    $monitor("T=%0t io1=%0b ctr1=%0b io2=%0b", $time, io1, ctrl, io2);

    #10 io1 <= 1;
    #10 ctrl <= 1;
    #10 ctrl <= 0;
    #10 io1 <= 0;
  end
endmodule
