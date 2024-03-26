module rom_tb;
  //local parameters
  localparam DATA_WIDTH = 8;
  localparam DEPTH = 16;
  localparam ADDR_WIDTH = $clog2(DEPTH);
  localparam INIT_FILE = "rom_file.mem";

  //testbench signals to be connected to DUT
  logic clk;
  logic start_rom;
  logic [ADDR_WIDTH-1:0] rom_addr;
  logic [DATA_WIDTH-1:0] rom_data;

  //Instantiate the DUT
  rom #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .INIT_FILE(INIT_FILE)
  ) rom_dut (
    .clk(clk),
    .start_rom(start_rom),
    .rom_addr(rom_addr), 
    .rom_data(rom_data)
  );

  //Generate the clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  //Generate the stimulus
  initial begin
    //init signals
    rom_addr = 0;
    start_rom = 1;
    #10;
    for (int i = 0; i < DEPTH; i++) begin
      rom_addr = i;
      #10;
      assert (rom_data == i) 
      else $fatal(1, "Something went \
	      wrong at time %0t ! Expected = %0h, Got for rom: %0h", $time, i, rom_data);
    end

    //finish the simulation
    #10 $finish;
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars; //dump all variables
  end

endmodule


