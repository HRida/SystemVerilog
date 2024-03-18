module gate_full_adder_tb;
  reg a, b, cin;
  wire sum, cout;
  integer i;

  gate_full_adder u1 (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  initial begin
    {a, b, cin} <= 0;

    $monitor("T=%0t a=%0b b=%0b cin=%0b cout=%0b sum=%0b", $time, a, b, cin, cout, sum);

    for (i = 0; i < 10; i = i + 1) begin
      #1 a <= $random;
      b <= $random;
      cin <= $random;
    end
  end
endmodule
