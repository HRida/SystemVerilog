module power_ground_tb;
  wire vdd, gnd;

  power_ground dut (
    .vdd(vdd),
    .gnd(gnd)
  );

  initial begin
    #10;
    $display("T=%0t vdd=%0d gnd=%0d", $time, vdd, gnd);
  end
endmodule
