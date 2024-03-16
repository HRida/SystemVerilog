module MUX4(
    input logic A,B,C,D,Sel0,Sel1,
    output logic Q
  );
  logic Sel0_n, Sel1_n;
  logicY0, Y1, Y2, Y3;
  not (Sel0_n, Sel0);
  not (Sel1_n, Sel1);
  and (Y0, A, Sel0_n, Sel1_n);
  and (Y1, B, Sel0_n, Sel1 );
  and (Y2, C, Sel0, Sel1_n);
  and (Y3, D, Sel0, Sel1 );
  or (Q, Y0, Y1, Y2, Y3);
endmodule :
MUX4
