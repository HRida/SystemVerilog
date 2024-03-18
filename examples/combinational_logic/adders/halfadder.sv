module halfadder (
    input a, b,
    output sum, cout
  );

  always @(a or b)
  begin
    {cout, sum} = a + b;
  end
endmodule
