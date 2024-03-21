module arbiter (
  input logic clk,
  input logic reset,
  input logic r0,
  input logic r1,
  input logic r2,
  output logic g0,
  output logic g1,
  output logic g2
);

  typedef enum logic [1:0] {
    IDLE,
    GRANT_DEVICE_0,
    GRANT_DEVICE_1,
    GRANT_DEVICE_2
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
        g0 <= 1'b0;
        g1<= 1'b0;
        g2<=1'b0;
        next_state = IDLE;
        if (r0) next_state = GRANT_DEVICE_0;
        else if (!r0 & r1) next_state = GRANT_DEVICE_1;
        else if (!r0 & !r1 & r2) next_state = GRANT_DEVICE_2;
      end
      GRANT_DEVICE_0: begin
        g0 <= 1;
        if (!r0) begin
          next_state = IDLE;
        end
      end
      GRANT_DEVICE_1: begin
        g1 <= 1;
        if (!r1) begin
          next_state = IDLE;
        end
      end
      GRANT_DEVICE_2: begin
        g2 <= 1;
        if (!r2) begin
          next_state = IDLE;
        end
      end
    endcase
  end
endmodule
