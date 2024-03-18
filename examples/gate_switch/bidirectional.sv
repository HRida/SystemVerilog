module bidirectional_tran (
  input io1,
  ctrl,
  output io2
);
  tran (io1, io2);
endmodule

module bidirectional_tranif0 (
  input io1,
  ctrl,
  output io2
);
  tranif0 (io1, io2, ctrl);
endmodule

module bidirectional_tranif1 (
  input io1,
  ctrl,
  output io2
);
  tranif1 (io1, io2, ctrl);
endmodule
