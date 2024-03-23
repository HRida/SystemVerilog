module dot_product_test #(
  parameter num_elems = 4,
  parameter data_width = 8
) (
  input logic clock,
  output logic [(2*data_width + $bits(num_elems)) - 1  : 0] outp,
  output logic [num_elems * data_width - 1 : 0] outp_inps
);

  localparam num_bits = data_width * num_elems;

  //counter 
  logic [num_bits - 1 : 0] count;
  initial begin
    count = 0;
  end

  always @(posedge clock) count <= count + 1;
  assign outp_inps = count;

  // instantiate 
  dot_product #(
    .N(num_elems),
    .DW(data_width)
  ) dot_product_dut (
    .inp1(count),
    .inp2(count),
    .outp(outp)
  );

  //locals
  // genvar i;
  // logic [(2*data_width + $bits(num_elems)) - 1 : 0] sums[0 : num_elems - 1];  // intermediate product sums
// 
  // ///compute
  // assign sums[0] = count[data_width-1 : 0] * count[data_width-1 : 0];
// 
  // generate
  //   for (i = 1; i < num_elems; i = i + 1) begin : sum_loop
  //     assign sums[i] = sums[i-1] + count[(i+1)*data_width-1 : i*data_width] * count[(i+1)*data_width-1 : i*data_width];
  //   end
  // endgenerate
// 
  // assign outp = sums[num_elems - 1];

endmodule : dot_product_test
