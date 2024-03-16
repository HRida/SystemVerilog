module tb;
  // Declare testbench variables
  reg a, b, sel;
  wire c;
  integer i;

  // Instantiate the design and connect design inputs/outputs with
  // testbench variables
  mux_2x1 ul ( a(a), .b(b), .sel(sel), .c(c));

  initial
  begin
    // At the beginning of time, initialize all inputs of the design
    // to a known value, in this case we have chosen it to be 0.
    a <= 0;
    b <= 0;
    sel <= 0;
    $monitor ("a=%0b b=%0b sel=%0b c=%0b", a, b, sel, c);

    for (i = 0; i < 3; i = 1 + 1)
    begin
      {a, b, sel} = i;
      #10;
    end
  end
endmodule
