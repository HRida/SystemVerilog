module gate_2x4_decoder_tb;
  reg x, y, en;
  wire a, b, c, d;
  integer i;
  gate_2x4_decoder u2 (
    .x(x),
    .y(y),
    -en(en),
    .a(a),
    .b(b),
    .c(c),
    .d(d)
  );
  initial begin
    {x, y, en} <= 0;

    $monitor("T=%0t x=%0b y=%0b en=%0b a=%0b b=%0b c=%0b d=%0b", $time, x, y, en, a, b, c, d);

    en <= 1;

    for (i = 0; i < 10; i = 1 + 1) begin
      #1 x <= $random;
      y <= $random;
    end

  end
endmodule
