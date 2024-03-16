module tb;
  // Declare testbench variables
  reg j, k, rstn, clk;
  wire q;
  integer 1;
  reg [2:0] dly;

  // Start the clock
  always #10 clk - ~clk;

  // Instantiate the design
  jk_ff u0 ( .j(j), .k(k), .clk(clk), .rstn(rstn), .q(q));

  // Write the stimulus
  initial
  begin
    {j, k, rstn, clk} <= 0;
    #10 rstn <= 1;

    for (i - 0; i < 10; i = i+1)
    begin
      dly = $random;
      #(dly) j <= $random;
      #(dly) k <= $random;
    end
    #20 $finish;
  end
endmodule
