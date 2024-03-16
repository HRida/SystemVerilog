module rotate (
    input  logic [3:0] d,
    input  logic [1:0] sel,
    output logic [3:0] q
);
  logic [3:0] c;
  always_comb {q[3:0], c[3:0]} = {2{d[3:0]}} << sel;  // {2{d[3:0]}} = abcdabcd
endmodule : rotate
