module dma_tb;
  // Parameters
  localparam DATA_WIDTH = 8;
  localparam ADDR_WIDTH = 4;

  // Signals
  logic clk;
  logic reset;
  logic start_dma;
  logic [ADDR_WIDTH-1:0] data_amt;
  logic [ADDR_WIDTH-1:0] starting_rom;
  logic [ADDR_WIDTH-1:0] starting_ram;
  logic [DATA_WIDTH-1:0] rom_data;
  logic [ADDR_WIDTH-1:0] rom_addr;
  logic [ADDR_WIDTH-1:0] ram_addr;
  logic [DATA_WIDTH-1:0] ram_data;
  logic done;
  logic ram_wea;

  // Instantiate the DMA module
  dma #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) dma_dut (
    .clk(clk),
    .reset(reset),
    .start_dma(start_dma),
    .data_amt(data_amt),
    .starting_rom(starting_rom),
    .starting_ram(starting_ram),
    .rom_data(rom_data),
    .rom_addr(rom_addr),
    .ram_addr(ram_addr),
    .ram_data(ram_data),
    .done(done),
    .ram_wea(ram_wea)
  );

  // Clock process
  always begin
    #5 clk = ~clk;  // Toggle clock every 5 time units
  end

  // Test process
  initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    start_dma = 0;
    data_amt = 0;
    starting_rom = 0;
    starting_ram = 0;
    rom_data = 0;

    // Apply reset
    #10 reset = 0;
    #10 reset = 1;
    #10 reset = 0;

    // Start DMA transfer
    #10 start_dma = 1;
    data_amt = 8'd10;  // Transfer 10 elements
    starting_rom = 4'd1;  // Start from ROM address 1
    starting_ram = 4'd5;  // Start from RAM address 5
    rom_data = 8'd123;  // Set ROM data to 123

    // Monitor the ROM and RAM addresses
    #1 $display("ROM address: %d, RAM address: %d", rom_addr, ram_addr);
    
    #100;  // Wait for the transfer to complete

    // Stop DMA transfer
    #10 start_dma = 0;

    // Finish the simulation
    #10 $finish;
  end
endmodule