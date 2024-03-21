module Arbiter (
  input logic clk,
  input logic reset,
  input logic r0,
  input logic r1,
  input logic r2,
  input logic r3,
  input logic r4,
  output logic g0,
  output logic g1,
  output logic g2,
  output logic g3,
  output logic g4
);

  typedef enum logic [2:0] {
    IDLE,
    GRANT_ROM_WRITE,
    GRANT_ROM_READ,
    GRANT_RAM_WRITE,
    GRANT_RAM_READ,
    GRANT_ALU
  } arbiter_states_t;

  arbiter_states_t state, next_state;

  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin
    // State transition logic
    case (state)
      IDLE: begin
        {g0, g1, g2, g3, g4} <= 1'b0;
        next_state = IDLE;

        if (r0) next_state = GRANT_ROM_WRITE;
        else if (!r0 & r1) next_state = GRANT_ROM_READ;
        else if (!r0 & !r1 & r2) next_state = GRANT_RAM_WRITE;
        else if (!r0 & !r1 & !r2 & r3) next_state = GRANT_RAM_READ;
        else if (!r0 & !r1 & !r2 & !r3 & r4) next_state = GRANT_ALU;
      end
      GRANT_ROM_WRITE: begin
        g0 <= 1;
        if (!r0) begin
          next_state = IDLE;
        end
      end
      GRANT_ROM_READ: begin
        g1 <= 1;
        if (!r1) begin
          next_state = IDLE;
        end
      end
      GRANT_RAM_WRITE: begin
        g2 <= 1;
        if (!r2) begin
          next_state = IDLE;
        end
      end
      GRANT_RAM_READ: begin
        g3 <= 1;
        if (!r3) begin
          next_state = IDLE;
        end
      end
      GRANT_ALU: begin
        g4 <= 1;
        if (!r4) begin
          next_state = IDLE;
        end
      end
    endcase
  end
endmodule
