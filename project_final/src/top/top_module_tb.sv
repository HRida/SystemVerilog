module top_module_tb;
    //local parameters
    localparam DATA_WIDTH = 8;
    localparam DEPTH = 16;
    localparam DATA_AMOUNT = 16;
    localparam ADDR_WIDTH = $clog2(DEPTH);
    localparam INIT_FILE = "rom_file.mem";

    logic clk1, clk2;
    logic reset;
    logic r0, r1, r2;
    logic g0, g1, g2;
    logic top_start = 0, top_done = 0;
    int write_to_file, fd;
    
  // Instantiate the amazing arbiter
  top_module #(
    .INIT_FILE(INIT_FILE),
    .DATA_WIDTH(DATA_WIDTH),
    .DATA_AMOUNT(DATA_AMOUNT),
    .DEPTH(DEPTH)
    ) top_module_dut (
      .clk1(clk1),
      .clk2(clk2),
      .reset(reset),
      .top_start(top_start),
      .top_done(top_done),
      .write_to_file(write_to_file)
    );
    
    //Generating the clocks
    always #5ns clk1 = !clk1; // f=1/T, T=5ns => f= 1/5ns => (((1/5)/10^-9)/10^6) = 200MHz
    always #10ns clk2 = !clk2; // f=1/T, T=10ns => f= 1/10ns => (((1/10)/10^-9)/10^6) = 100MHz

    //Generate the stimulus
    initial begin
      fd = $fopen ("../test/output", "w"); 
      $fmonitor (fd, "%02X" , write_to_file);
      clk1  <= 0;
      clk2  <= 0; 
      reset <= 1; 
      r0    <= 0;
      r1    <= 0;
      r2    <= 0;
      #10ns 
      reset <= 0;
      #10ns 
      top_start <= 1;
      r0 <=1;
      r1 <=0;
      r2 <=0;
      #500ns 
      r0 <=0;
      r1 <=1;
      r2 <=0;
      #500ns;
      r0 <=0;
      r1 <=0;
      r2 <=1;
      #1000ns; 
      $fclose(fd);
      $finish;
   end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars; //dump all variables
  end

endmodule


