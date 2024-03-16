module MUX2_0(
    input logic A1,A0,Sel,
    output logic Q
  );
  logic Sel_n;
  logic Y0, Y1;

  not #3ns U1 (Sel_n, Sel);
  and (weak0,strong1) (Y1, A1, Sel);
  and #(2ns,3ns) (Y0, A0, Sel_n);
  or (Q, Y0, Y1);
endmodule :
MUX2_0

  module MUX2_1(
      input logic A1,A0,Sel,
      output logic Q
    );
    logicSel_n;
    logicY0, Y1;
    not #3ns U1 (Sel_n, Sel);
    and (weak0,strong1) (Y1, A1, Sel);
    and #(2ns,3ns) (Y0, A0, Sel_n);
    or (Q, Y0, Y1);
  endmodule :
  MUX2_1
