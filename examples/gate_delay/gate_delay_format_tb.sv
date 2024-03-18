module gate_delay_format_tb;
  reg a, b;
  wire outl, out2;

  des_1 d1 (
    .out1(out1),
    .out2(out2),
    .a(a),
    .b(b)
  );

  initial begin
    {a, b} <= 0;

    $monitor("T=%0t a=%0b b=%0b and=%0b bufif®=%0b", $time, a, b, out1, out2);

    #10 a <= 1;
    #10 b <= 1;
    #10 a <= 0;
    #10 b <= 0;
  end
endmodule
