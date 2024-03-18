module pattern_detector_tb;

  reg clk, in, rstn;
  wire out;
  integer l_dly;

  always #10 clk = ~clk;

  pattern_detector u0 (
    .clk(clk),
    .rstn(rstn),
    .in(in),
    .out(out)
  );

  initial begin
    clk <= 0;
    rstn <= 0;
    in <= 0;

    repeat (5) @(posedge clk);

    rstn <= 1;

    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;

    #100 $finish;
  end
endmodule
