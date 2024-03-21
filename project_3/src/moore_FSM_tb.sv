
module moore_FSM_tb;
  logic clk, reset;
  logic [1:0] in, out;

  //instantiate the amazing counter
  //(DUT: Design Under Test)
  moore_FSM DUT (
    .clk(clk),
    .reset(reset),
    .in(in),
    .out(out)
  );

  //generate clock signal
  always #5ns clk = !clk;

  initial begin
    clk   <= 1'b0; // clock initially at zero
    reset <= 1'b1; // reset initially disabled
    {in, out} <= 2'b00;  // reset

    #10ns reset <= 1'b0;  // disable reset after 20 ns

    #20ns in <= 2'b01;
    #20ns in <= 2'b10;
    #20ns in <= 2'b11;
    #10ns in <= 2'b00;
    #20ns;

    #20ns in <= 2'b01;
    #10ns in <= 2'b00;
    #20ns in <= 2'b10;
    #10ns in <= 2'b00;
    #20ns in <= 2'b11;
    #10ns in <= 2'b00;
    #20ns;
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars;  //dump all variables
  end



endmodule
