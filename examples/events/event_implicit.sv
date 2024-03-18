module event_implicit_0;
  reg a, b, c, d;
  reg x, y;

  // Event expr/sensitivity list is formed by all the
  // signals inside () after @ operator and in this case
  // it is a, b, c or d
  always @(a, b, c, d) begin
    x = a | b;
    y = c ^ d;
  end
  initial begin
    $monitor("T=%0t a=%0b b=%0b c=%0b d=%0b x=%0b y=%0b", $time, a, b, c, d, x, y);

    {a, b, c, d} <= 0;

    #10{a, b, c, d} <= $random;
    #10{a, b, c, d} <= $random;
    #10{a, b, c, d} <= $random;
  end
endmodule

module event_implicit_1;
  reg a, b, c, d, e;
  reg x, y, z;

  // Add "e" also into sensitivity list
  always @(a, b, c, d, e) begin
    x = a | b;
    y = c ^ d;
    z = ~e;
  end

  initial begin
    $monitor("T=%0t a=%0b b=%0b c=%0b d=%0b e=%0b x=%0b y=%0b z-%0b", $time, a, b, c, d, e, x, y,
             z);
    {a, b, c, d, e} <= 0;

    #10{a, b, c, d, e} <= $random;
    #10{a, b, c, d, e} <= $random;
    #10{a, b, c, d, e} <= $random;
  end
endmodule

module event_implicit_1;
  reg a, b, c, d, e;
  reg x, y, z;

  // Use @* or @(*)
  always @(*) begin
    x = a | b;
    y = c ^ d;
    z = ~e;
  end

  initial begin
    $monitor("T=%0t a=%0b b=%0b c=%0b d=%0b e=%0b x=%0b y=%0b z-%0b", $time, a, b, c, d, e, x, y,
             z);
    {a, b, c, d, e} <= 0;

    #10{a, b, c, d, e} <= $random;
    #10{a, b, c, d, e} <= $random;
    #10{a, b, c, d, e} <= $random;
  end
endmodule

