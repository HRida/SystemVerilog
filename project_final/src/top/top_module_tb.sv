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
    logic top_start, top_done;
    
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
      .top_done(top_done)
    );
    
    //Generate the clock
    always #5ns clk1 = !clk1; // 200MHz
    always #10ns clk2 = !clk2; // 100MHz

    //Generate the stimulus
    initial begin
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
      #500ns; 
      $finish;
   end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars; //dump all variables
  end

endmodule


