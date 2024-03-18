// This module has 1 time unit gate delay
module des_1 (
  input a,
  b,
  output out1,
  out2
);

  // AND gate has 2 time unit gate delay
  and #(2) o1 (out1, a, b);
  // BUFIF0 gate has 3 time unit gate delay
  bufif0 #(3) b1 (out2, a, b);

endmodule

// This module has 2 time unit gate delay
module des_2 (
  input a,
  b,
  output out1,
  out2
);

  and #(2, 3) o1 (out1, a, b);
  bufif0 #(4, 5) b1 (out2, a, b);

endmodule

// This module has 3 time unit gate delay
module des_3 (
  input a,
  b,
  output out1,
  out2
);

  and #(2, 3) o1 (out1, a, b);
  bufif0 #(5, 6, 7) b1 (out2, a, b);

endmodule

// This module has min/typ/max time unit gate delay
module des_4 (
  input a,
  b,
  output out1,
  out2
);

  and #(2: 3: 4, 3: 4: 5) o1 (out1, a, b);
  bufif0 #(5: 6: 7, 6: 7: 8, 7: 8: 9) b1 (out2, a, b);

endmodule
