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
endmodule : dot_product_test
