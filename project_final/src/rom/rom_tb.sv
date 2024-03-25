module rom_tb;
  //local parameters
  localparam DATA_WIDTH = 8;
  localparam DEPTH = 16;
  localparam ADDR_WIDTH = $clog2(DEPTH);
  localparam ROM_FILE_1 = "rom_file_1.mem";
  localparam ROM_FILE_2 = "rom_file_2.mem";

  //testbench signals to be connected to DUT
  logic clk;
  logic [ADDR_WIDTH-1:0] rd_addr;
  logic [DATA_WIDTH-1:0] rd_data_1;
  logic [DATA_WIDTH-1:0] rd_data_2;

  //Instantiate the DUT
  rom #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ROM_FILE(ROM_FILE_1)
  ) rom_1_dut (
    .clk(clk),
    .rd_addr(rd_addr),
    .rd_data(rd_data_1)
  );

  rom #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ROM_FILE(ROM_FILE_2)
  ) rom_2_dut (
    .clk(clk),
    .rd_addr(rd_addr), 
    .rd_data(rd_data_2)
  );

  //Generate the clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  //Generate the stimulus
  initial begin
    //init signals
    rd_addr = 0;
    #10;
    for (int i = 0; i < DEPTH; i++) begin
      rd_addr = i;
      #10;
      // assert (rd_data_1 == i && rd_data_2 == i)
      // else $fatal(1, "Something went \
	  //	wrong at time %0t ! Expected = %0h, Got for rom-1: %0h / rom-2: %0h", $time, i, rd_data_1, rd_data_2);
    end

    //finish the simulation
    #100 $finish;
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars; //dump all variables
  end

endmodule


