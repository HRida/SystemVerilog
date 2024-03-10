// testbench for the counter
module counter_tb;
   logic clock;
   logic reset;
   logic [3:0] count;

   //instantiate the amazing counter
   //(DUT: Design Under Test)
   counter DUT(.*);

   //generate clock signal
   always #5ns clock = !clock;

   initial begin
      clock <= 0; // clock initially at zero
      reset <= 1; // reset initially disabled
      #10ns reset <= 0; // disable reset after 20 ns
      #40ns $finish; // finish simu after 40 ns
   end

   initial begin
      $dumpfile("waveform.vcd");
      $dumpvars; //dump all variables
   end
endmodule : counter_tb
