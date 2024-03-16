module tb;
  reg clk, rstn;
  reg [3:0] out;

  mod10_counter u0 (.clk(clk), .rstn(rstn), .out(out)) ;

  always #10 clk = ~clk;

  initial
  begin
    {clk, rstn} <= 0;
    #10 rstn <= 1;
    #450 $finish;
  end
endmodule
