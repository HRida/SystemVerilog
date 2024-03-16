module barrelshift4 (
    input  logic [3:0] d,
    input  logic [1:0] sel,
    output logic [3:0] q
);
  logic [3:0] c;
  always_comb c = sel[0] ? {d[2:0], 1'b0} : d;
  always_comb q = sel[1] ? {c[1:0], 2'b0} : c;
  // always_comb q = d << sel; // Alternative!
endmodule
