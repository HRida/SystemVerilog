module register_file_tb;

  // Declare the signals
  logic clk;
  logic [4:0] wr_addr;
  logic [31:0] wr_data;
  logic wr_enable;
  logic [4:0] rd_addr1;
  logic [31:0] rd_data1;
  logic [4:0] rd_addr2;
  logic [31:0] rd_data2;

  // Instantiate the module under test (MUT)
  register_file #(
    .DATA_WIDTH(32),
    .DEPTH(32)
  ) register_file_dut (
    .clk(clk),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .wr_enable(wr_enable),
    .rd_addr1(rd_addr1),
    .rd_data1(rd_data1),
    .rd_addr2(rd_addr2),
    .rd_data2(rd_data2)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  // Stimulus
  initial begin
    // Initialize signals
    wr_enable = 0;
    wr_addr = 0;
    wr_data = 0;
    rd_addr1 = 0;
    rd_addr2 = 0;
    #20 wr_enable = 1;
    wr_addr = 5;
    wr_data = 32'hDEADBEEF; // Write to address 5
    #20 rd_addr1 = 5;  // Read from address 5
    #20 rd_addr2 = 5;  // Read from address 5
    #20 $finish;  // End simulation
  end

  // Monitor
  initial begin
    $monitor("At time %0d, wr_addr = %b, wr_data = %h, rd_data1 = %h, rd_data2 = %h", $time,
             wr_addr, wr_data, rd_data1, rd_data2);
  end

endmodule : register_file_tb
