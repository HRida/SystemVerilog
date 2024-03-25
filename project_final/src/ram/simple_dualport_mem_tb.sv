module simple_dualport_mem_tb;
  logic clk;
  //PORT A (write port)
  logic [7:0] addra;  //write address
  logic [63:0] dina;  //data input
  logic wea;  //write enable
  //PORT B (read port)
  logic [7:0] addrb;  //read address
  logic [63:0] doutb;  //data output

  //define a simple "RAM" module to act as internal storage for the memory
  simple_dualport_mem #(
    .DATA_WIDTH(8),
    .DEPTH(64)
  ) simple_dualport_mem_dut (
    .clk(clk),
    .addra(addra),
    .dina(dina),
    .wea(wea),
    .addrb(addrb),
    .doutb(doutb)
  );

  always #5 clk = ~clk;
  initial begin
    clk = 1;
    addra = 0;
    dina = 0;
    wea = 0;
    addrb = 0;
    #20;
    wea = 1;
    for (int i = 0; i < 16; i = i + 1) begin
      dina = 2*i;
      addra = i;
      #10;
    end
    wea = 0;
    for (int i = 0; i < 16; i++) begin
      addrb = i;
      #10;
      $display("[DISPLAY] time = %0t, \
  addrb = %0h, doutb = %d", $time, addrb, doutb);
      assert (doutb == 2 * i);
    end
    #100 $finish;
  end
endmodule
