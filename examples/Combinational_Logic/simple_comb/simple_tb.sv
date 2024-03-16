module tb;
  // Declare testbench variables
  reg a, b, c, d, e;
  wire z;
  integer i;

  // Instantiate the design and connect design inputs/outputs with
  // testbench variables
  combo ul (.a(a), .b(b), .c(c), .d(d), .e(e), .z(z));

  initial
  begin
    // At the beginning of time, initialize all inputs of the design
    // to a known value, in this case we have chosen it to be 0.
    a <= 0;
    b <= 0;
    c <= 0;
    d <= 0;
    e <= 0;

    // Use a Smonitor task to print any change in the signal to
    // simulation console
    Smonitor ("a=%0b b=%0b c=%0b d=%0b e=%0b z=%0b" , a, b, c, d, e, z);

    // Because there are 5 inputs, there can be 32 different input combinations
    // So use an iterator "i" to increment from 0 to 32 and assign the value
    // to testbench variables so that it drives the design inputs
    for (i = 0; i < 32; i = i + 1)
    begin
      (a, b, c, d, e) = i;
      #10;
    end
  end
endmodule
