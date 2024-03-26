module simple_dualport_mem #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 16,
  localparam ADDR_WIDTH = $clog2(DEPTH)
) (
  input logic clk,
  //PORT A (write port)
  input logic [ADDR_WIDTH-1:0] addra, //write address
  input logic [DATA_WIDTH-1:0] dina, //data input
  input logic wea, //write enable
  //PORT B (read port)
  input logic [ADDR_WIDTH-1:0] addrb, //read address
  output logic [DATA_WIDTH-1:0] doutb //data output
);

  //declare an unpacked array signal for storing data
  //memory depth : 16 different locations, data width : 8bit
  logic [DATA_WIDTH-1:0] mem[ADDR_WIDTH-1:0];

  always_ff @(posedge clk) begin
    if (wea) mem[addra] <= dina;  //write operation (Port A)
  end

  always_ff @(posedge clk) begin
    doutb <= mem[addrb];  //read operation (Port B)
  end
  
endmodule : simple_dualport_mem
