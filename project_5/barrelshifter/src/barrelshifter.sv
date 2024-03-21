module BarrelShifter #(
  parameter WIDTH = 8
) (
  input logic [WIDTH-1:0] data_in,
  input logic [$clog2(WIDTH)-1:0] shift_amount,
  input logic shift_direction, // 0: right shift, 1: left shift
  output logic [WIDTH-1:0] data_out
);

  // Barrel shifter logic
  always_comb begin
    if (shift_direction == 1'b0)  // Right shift
      data_out = (data_in >> shift_amount);
    else  // Left shift
      data_out = (data_in << shift_amount);
  end

endmodule : BarrelShifter

