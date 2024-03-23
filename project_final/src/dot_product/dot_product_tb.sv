`timescale 1 ns / 1 ps
`define NUM_ELEMS 5
`define DATA_WIDTH 2

module dot_product_tb ();
  logic clock;
  logic reset;
  logic [(2*`DATA_WIDTH + $bits(`NUM_ELEMS)) - 1 : 0] outp;
  logic [(`NUM_ELEMS * `DATA_WIDTH) - 1 : 0] inps;

  //generate clock signal
  always #5ns clock = ~clock;

  int signed array1 = {{1, 2}, {3, 4}};
  int signed array2 = {{1, 2}, {3, 4}};

  int signed [15:0] sums;

  dot_product_2 #(
    .N(2),
    .DW(8)
  ) dot_product_2_dut (
    .clk(clk),
    .reset(0),
    .inp1(array1[0]),
    .inp2(array2[0]),
    .sums(sums)
  );

  //instantiate dot_product module
  // dot_product_test #(
  //   .num_elems(`NUM_ELEMS),
  //   .data_width(`DATA_WIDTH)
  // ) dot_product_dut (
  //   .clock(clock),
  //   .outp(outp),
  //   .outp_inps(inps)  // the count
  // );

  // display inputs and output on each clock cycle
  always @(posedge tb_clk) begin
    $display("inputs = ", inps, " => outputs = ", outp);
  end

endmodule
