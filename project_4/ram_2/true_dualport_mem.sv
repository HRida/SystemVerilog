module true_dualport_mem #(
  parameter DATA_WIDTH=16,
  parameter ADDR_WIDTH=8
) (
  input logic clk,
  //PORT A (read/write port)
  input logic [ADDR_WIDTH-1:0] addra, //write address
  input logic [DATA_WIDTH-1:0] dina, //data input
  input logic wea, //write enable
  output logic [DATA_WIDTH-1:0] douta, //data output
  //PORT B (read/write port)
  input logic [ADDR_WIDTH-1:0] addrb, //write address
  input logic [DATA_WIDTH-1:0] dinb, //data input
  input logic web, //write enable
  output logic [DATA_WIDTH-1:0] doutb //data
);

  // declare an unpacked array
  // signal for storing data
  logic [DATA_WIDTH-1:0] mem[0:(1<<ADDR_WIDTH)-1];

  //Port A can read or write data
  always_ff @(posedge clk) begin
    if (wea) mem[addra] <= dina;
    douta <= mem[addra];
  end

  //Port B can read or write data
  always_ff @(posedge clk) begin
    if (web) mem[addrb] <= dinb;
    doutb <= mem[addrb];
  end
endmodule : true_dualport_mem
