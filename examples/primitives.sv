primitive MUX2_pre (output Q, input Sel, A, B);
  table
    // Sel A B : Q
    0 0 ? : 0;
    0 1 ? : 1;
    1 ? 0 : 0;
    1 ? 1 : 1;
    x ? ? : x;
  endtable
endprimitive

primitive TFF (output reg Q, input Clk, Clr);
  initial
    Q = 0;
  table
    // Clk Clr : Q : Q+
    ? 1 : ? : 0;
    r 0 : 0 : 1;
    r 0 : 1 : 0;
    f 0 : ? : -;
  endtable
endprimitive
