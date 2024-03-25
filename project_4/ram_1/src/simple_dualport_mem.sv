module simple_dualport_mem (
  input logic clk,
  //PORT A (write port)
  input logic [7:0] addra, //write address
  input logic [63:0] dina, //data input
  input logic wea, //write enable
  //PORT B (read port)
  input logic [7:0] addrb, //read address
  output logic [63:0] doutb //data output
);
  //declare an unpacked array signal for storing data
  //memory depth : 256 different locations, data width : 64bit
  logic [63:0] mem[255:0];

  always_ff @(posedge clk) begin
    if (wea) mem[addra] <= dina;  //write operation (Port A)
  end

  always_ff @(posedge clk) begin
    doutb <= mem[addrb];  //read operation (Port B)
  end
endmodule : simple_dualport_mem
