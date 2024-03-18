// TESTBENCH with different clock frequencies
module clock_gen_tb_1;
  wire clkl;
  wire clk2;
  wire c1k3;
  wire c1k4;
  reg enable;
  reg [7:0] dly;

  clock_gen u0 (enable, clk1);
  clock_gen #(.FREQ(200000)) u1 (enable,clk2);
  clock_gen #(.FREQ(400000)) u2 (enable,clk3);
  clock_gen #(.FREQ(800000)) u3 (enable,clk4);
  
  initial begin
    enable <= 0;

    for (int i = 0; i < 10; i = i + 1) begin
      dly = $random;
      #(dly) enable <= ~enable;
      $display("i=%0d dly=%0d", i, dly);
      #50;
    end

    #50 $finish;
  end
endmodule

// TESTBENCH with different clock pahses
module clock_gen_tb_2;
  wire clkl;
  wire clk2;
  reg enable;
  reg [7:0] dly;

  clock_gen u0 (enable, clk1);
  clock_gen #(.FREQ(200000), .PAHSE(90)) u1 (enable,clk2);
  
  initial begin
    enable <= 0;

    for (int i = 0; i < 10; i = i + 1) begin
      dly = $random;
      #(dly) enable <= ~enable;
      $display("i=%0d dly=%0d", i, dly);
      #50;
    end

    #50 $finish;
  end
endmodule

// TESTBENCH with different duty cycles
module clock_gen_tb_3;
  wire clkl;
  wire clk2;
  wire c1k3;
  wire c1k4;
  reg enable;
  reg [7:0] dly;

  clock_gen u0 (enable, clk1);
  clock_gen #(.DUTY(25)) u1 (enable,clk2);
  clock_gen #(.DUTY(75)) u2 (enable,clk3);
  clock_gen #(.DUTY(90)) u3 (enable,clk4);
  
  initial begin
    enable <= 0;

    for (int i = 0; i < 10; i = i + 1) begin
      dly = $random;
      #(dly) enable <= ~enable;
      $display("i=%0d dly=%0d", i, dly);
      #50;
    end

    #50 $finish;
  end
endmodule