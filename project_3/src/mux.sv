module multiplexer (
  input logic a,
  input logic b,
  input logic select,
  output logic y
);

  always_comb begin
    if (select) y = b;
    else y = a;
  end

endmodule : multiplexer
