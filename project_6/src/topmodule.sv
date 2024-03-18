module TopModule_1 (
  input clk,
  input reset,
  input [31:0] rom_address,
  input [31:0] ram_address,
  input [31:0] num_elements,
  output reg done
);
  wire [7:0] rom_data;
  wire [7:0] ram_data;

  ROM rom_inst (
    .address(rom_address),
    .data(rom_data)
  );

  RAM ram_inst (
    .address(ram_address),
    .write_data(rom_data),
    .write_enable(1'b1),
    .read_data(ram_data)
  );

  DMA dma_inst (
    .clk(clk),
    .reset(reset),
    .rom_address(rom_address),
    .ram_address(ram_address),
    .num_elements(num_elements),
    .done(done)
  );
endmodule

module TopModule_2 (
  input clk,
  input reset,
  input [31:0] rom_address,
  input [31:0] ram_address,
  input [31:0] num_elements,
  output reg done
);

  logic [7:0] rom_data;
  logic [7:0] ram_data;

  ROM rom_inst (
    .clk(clk),
    .rd_addr(rd_addr),
    .rd_data(rd_data)
  );

  RAM ram_inst (
    .clk(clk),
    .addra(addra),
    .dina(dina),
    .wea(1'b1),
    .douta(douta),
    .addra(addrb),
    .dina(dinb),
    .web(1'b1),
    .douta(doutb),
  );

  DMA dma_inst (
    .clk(clk),
    .rst(rst),
    .start(start),
    .done(done),
    .srcAddr(srcAddr),
    .destAddr(destAddr),
    .data_amt(data_amt),
  );
endmodule
