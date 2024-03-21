module register_file #(
  parameter DATA_WIDTH = 32,
  parameter DEPTH = 32,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input logic clk,
  //write-back port
  input logic [ADDR_WIDTH-1:0] wr_addr,
  input logic [DATA_WIDTH-1:0] wr_data,
  input logic wr_enable,
  //read port 1
  input logic [ADDR_WIDTH-1:0] rd_addr1,
  output logic [DATA_WIDTH-1:0] rd_data1,
  //read port 2
  input logic [ADDR_WIDTH-1:0] rd_addr2,
  output logic [DATA_WIDTH-1:0] rd_data2
);
  logic [DATA_WIDTH-1:0] ram[DEPTH];

  //write-back port
  always_ff @(posedge clk) begin
    if (wr_enable == 1'b1) ram[wr_addr] <= wr_data;
  end

  //read port 1
  always_comb rd_data1 = ram[rd_addr1];

  //read port 2
  always_comb rd_data2 = ram[rd_addr2];

endmodule : register_file
