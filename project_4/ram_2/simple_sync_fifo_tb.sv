module simple_sync_fifo_tb;

  // Testbench inputs
  logic clk;
  logic reset;
  logic write_enable;
  logic read_enable;
  logic [31:0] data_in;  // DATA_WIDTH in sync_fifo

  // Testbench outputs
  logic [31:0] data_out;  // DATA_WIDTH in sync_fifo
  logic full;
  logic empty;

  // Instantiate the sync_fifo module
  simple_sync_fifo #(
    .DATA_WIDTH(32),  // replace with your desired data width
    .FIFO_DEPTH(16)  // replace with your desired FIFO depth
  ) dut (
    .clk(clk),
    .reset(reset),
    .push(write_enable),
    .wr_data(data_in),
    .pop(read_enable),
    .rd_data(data_out),
    .fifo_full(full),
    .fifo_empty(empty)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initialize signals
  initial begin
    clk = 0;
    reset = 1;
    write_enable = 0;
    read_enable = 0;
    data_in = 0;
    #10 reset = 0;  // disable reset after a 10 clock cycles

    ///////////////////////////// Test 1 /////////////////////////////
    // Write to FIFO
    #10 write_enable = 1;
    data_in = 32'hAA;  // Replace with the data you want to write
    #10 write_enable = 0;

    // Check that FIFO is not full after a write
    #10
    assert (!full)
    else $error("FIFO should not be full after a write");

    // Check that FIFO is not empty after a write
    #10
    assert (!empty)
    else $error("FIFO should not be empty after a write");

    // Read from FIFO
    #10 read_enable = 1;
    // Check that the read data matches the written data
    #10
    assert (data_out == 32'hAA)
    else $error("Read data does not match written data");
    #10 read_enable = 0;

    // Check that FIFO is empty after a read
    #10
    assert (empty)
    else $error("FIFO should be empty after a read");

    ///////////////////////////// Test 2 /////////////////////////////
    // Write to FIFO
    #10 write_enable = 1;
    data_in = 32'hBB;  // Replace with the data you want to write
    #10 write_enable = 0;

    // Check that FIFO is not full after a write
    #10
    assert (!full)
    else $error("FIFO should not be full after a write");

    // Check that FIFO is not empty after a write
    #10
    assert (!empty)
    else $error("FIFO should not be empty after a write");

    // Read from FIFO
    #10 read_enable = 1;
    // Check that the read data matches the written data
    #10
    assert (data_out == 32'hBB)
    else $error("Read data does not match written data");
    #10 read_enable = 0;

    // Check that FIFO is empty after a read
    #10
    assert (empty)
    else $error("FIFO should be empty after a read");

    ///////////////////////////// Test 3 /////////////////////////////
    // Write to FIFO
    #10 write_enable = 1;
    data_in = 32'hCC;  // Replace with the data you want to write
    #10 write_enable = 0;

    // Check that FIFO is not full after a write
    #10
    assert (!full)
    else $error("FIFO should not be full after a write");

    // Check that FIFO is not empty after a write
    #10
    assert (!empty)
    else $error("FIFO should not be empty after a write");

    // Read from FIFO
    #10 read_enable = 1;
    // Check that the read data matches the written data
    #10
    assert (data_out == 32'hBB)
    else $error("Read data does not match written data");
    #10 read_enable = 0;

    // Check that FIFO is empty after a read
    #10
    assert (empty)
    else $error("FIFO should be empty after a read");

    #100 $finish;  // End the simulation
  end

endmodule
