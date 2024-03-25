package data_types;
  typedef enum logic [1:0] {
    ADD = 2'b00,
    SUB = 2'b01,
    MUL = 2'b10
  } sel_t;

  typedef enum logic {
    WITH_CARRY = 1'b1,
    NO_CARRY   = 1'b0
  } mode_t;
endpackage
