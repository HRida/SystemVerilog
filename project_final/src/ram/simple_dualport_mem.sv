module simple_dualport_mem #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 16,
  parameter DATA_AMOUNT = 16,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input logic clk,
  //PORT A (write port)
  input  logic [ADDR_WIDTH-1:0] addra, // write address
  input  int dina,                     // data input
  input  logic wea,                    // write enable
  //PORT B (read port)
  input  logic [ADDR_WIDTH-1:0] addrb, // read address
  output int doutb,                    // data output
  output logic read_ram_available      // flag to indicate that the last address has been read
);

  //declare an unpacked array signal for storing data
  //memory depth e.g: 16 different locations, data width : 32bit
  int mem[DATA_AMOUNT-1:0];

  always_ff @(posedge clk) begin
    if (wea) mem[addra] = dina;  //write operation (Port A)
  end

  // always_ff @(posedge clk) begin
  //   doutb = mem[addrb];  //read operation (Port B)
  // end

  assign doutb = mem[addrb];  //read operation (Port B)

  always_comb begin
    read_ram_available = addra == (DATA_AMOUNT-1) ;
  end
  
endmodule : simple_dualport_mem
