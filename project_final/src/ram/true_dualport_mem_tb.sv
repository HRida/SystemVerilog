module true_dualport_mem_tb;
  localparam ADDRWIDTH = 8;
  localparam DATAWIDTH = 32;
  logic clk;
  //PORT A (read/write port)
  logic [ADDRWIDTH-1:0] addra;  //write address
  logic [DATAWIDTH-1:0] dina;  //data input
  logic wea;  //write enable
  logic [DATAWIDTH-1:0] douta;  //data output
  //PORT B (read/write port)
  logic [ADDRWIDTH-1:0] addrb;  //write address
  logic [DATAWIDTH-1:0] dinb;  //data input
  logic web;  //write enable
  logic [DATAWIDTH-1:0] doutb;  //data output

  true_dualport_mem #(
    .DATAWIDTH(DATAWIDTH),
    .ADDRWIDTH(ADDRWIDTH)
  ) DUT (
    .*
  );

  always #5 clk = ~clk;

  initial begin
    clk = 1;
    addra = 0;
    dina = 0;
    wea = 0;
    addrb = 0;
    dinb = 0;
    web = 0;
    #20;
    wea = 1;
    web = 1;
    for (int i = 0; i < 16; i++) begin
      dina = 2*i;
      dinb = 4*i;
      addra = 16+i;
      addrb = i;
      #10;
    end
    wea = 0;
    web = 0;
    for (int i = 0; i < 16; i++) begin
      addra = 16+i;
      addrb = i;
      #10;
      $display("[DISPLAY] time = %0t, \
 addra = %0d, douta = %0d", $time, addra, douta);
      assert (douta == 2 * i);
      $display("[DISPLAY] time = %0t, \
 addrb = %0d, doutb = %0d", $time, addrb, doutb);
      assert (doutb == 4 * i);
    end
    #10 $finish;
  end
endmodule
