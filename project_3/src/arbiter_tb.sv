// testbench for the counter
module arbiter_tb;
   logic clk;
   logic reset;
   logic r0, r1, r2;
   logic g0, g1, g2;

   //instantiate the amazing counter
   //(DUT: Design Under Test)
   Arbiter DUT(.clk(clk),
               .reset(reset),
               .r0(r0),
               .r1(r1),
               .r2(r2),
               .g0(g0),
               .g1(g1),
               .g2(g2)); // using dots
   // arbiter DUT(clk, reset, r0, r1, r2, g0 , g1, g2); // no dots


   //generate clock signal
   always #5ns clk = !clk;

   initial begin
      clk   <= 0; // clock initially at zero
      reset <= 1; // reset initially disabled
      r0    <= 0;
      r1    <= 0;
      r2    <= 0;
      #10ns reset <= 0; // disable reset after 20 ns
      #20ns r0 <=1;
      #10ns r0 <=0;
      #20ns r1 <=1;
      #10ns r1 <=0;
      #20ns r2 <=1;
      #10ns r2 <=0;
      #10ns;
      r0 <=1;
      r1 <=1;
      r2 <=1;
      #10ns r0 <=0;
      #20ns r1 <=0;
      #20ns r2 <=0;

    //   #40ns;  // finish simu after 400 ns
    //   $finish;
   end

   initial begin
      $dumpfile("waveform.vcd");
      $dumpvars; //dump all variables
   end
endmodule 
