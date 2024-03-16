module MUX (
    input  logic A,
    B,
    C,
    D,
    S0,
    S1,
    output logic Q
  );
  always_comb Q = (~S0 & ~S1 & A) | (~S0 & S1 & B) | (S0 & ~S1 & C) | (S0 & S1 & D);
endmodule :
MUX
