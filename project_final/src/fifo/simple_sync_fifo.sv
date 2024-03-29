module simple_sync_fifo #(
  parameter DATA_WIDTH  = 32, //parametrizable width of data
  parameter FIFO_DEPTH  = 16, //parameterizable depth of fifo ram
  parameter DATA_AMOUNT = 16,
  localparam ADDR_WIDTH = $clog2(FIFO_DEPTH) //fifo address width 
) (
  input  logic clk,   //clock input signal
  input  logic reset, //reset input signal
  //write port
  input  logic push,  //write enable to issue a write operation
  input  int wr_data, // input data to be written 
  // read port
  input  logic pop,   //read enable to issue a read operation
  output int rd_data, //the read output data
  // control flags
  output logic fifo_full, //flag showing the fifo is full
  output logic fifo_empty //flag showing the fifo is empty
);

  logic [ADDR_WIDTH-1:0] wr_ptr;     //write operation pointer 
  logic [ADDR_WIDTH-1:0] rd_ptr;     //read operation pointer
  logic [ADDR_WIDTH-1:0] wr_ptr_nxt; //next state write pointer 
  logic [ADDR_WIDTH-1:0] rd_ptr_nxt; //next state read pointer
  logic read_ram_available;          //flag to indicate that the last address has been read
  int   read_ram_data;               //data read from the ram
  int   write_ram_data;              //data written to the ram

  //define a simple "RAM" module to act as internal storage for the memory
  simple_dualport_mem #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(FIFO_DEPTH),
    .DATA_AMOUNT(DATA_AMOUNT)
  ) simple_dualport_mem_dut (
    .clk(clk),
    .addra(wr_ptr),
    .dina(write_ram_data),
    .wea(~fifo_full & push),
    .addrb(rd_ptr),
    .doutb(read_ram_data),
    .read_ram_available(read_ram_available)
  );

  //WRITE operation logic
  //----------------------
  always_comb wr_ptr_nxt = wr_ptr + 1;

  always_ff @(posedge clk) begin
    if (reset) begin
      wr_ptr <= 0;
    end 
    else begin
      //here a write is requested while fifo is not full
      if (~fifo_full & push) begin
        wr_data <= write_ram_data;
        wr_ptr <= wr_ptr_nxt;  //increment wr pointer
      end
    end
  end

  //READ operation logic
  //----------------------
  always_comb rd_ptr_nxt = rd_ptr + 1;

  always_ff @(posedge clk) begin
    if (reset) begin
      rd_ptr <= 0;
      rd_data <= {DATA_WIDTH{1'b0}};
    end 
    else begin
      //here a read is requested while fifo is not empty
      if (~fifo_empty & pop) begin
        rd_data <= read_ram_data;
        rd_ptr <= rd_ptr_nxt;  //increment wr pointer
      end
    end
  end

  //control flags logic
  //----------------------
  always_comb fifo_full = (wr_ptr_nxt == rd_ptr);

  always_comb fifo_empty = (rd_ptr == wr_ptr);

endmodule : simple_sync_fifo
