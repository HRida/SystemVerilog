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
    ROM2RAM,
    DOT_PRODUCT,
    FIFO_TRANSFER
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
        {g0, g1, g2} <= 2'b00;
        next_state = IDLE;

        if (r0) next_state = ROM2RAM;
        if (!r0 & r1) next_state = DOT_PRODUCT;
        if (!r0 & !r1 & r2) next_state = FIFO_TRANSFER;
      end
      ROM2RAM: begin
        g0 <= 1;
        if (!r0) begin
          next_state = IDLE;
        end
      end
      DOT_PRODUCT: begin
        g1 <= 1;
        if (!r1) begin
          next_state = IDLE;
        end
      end
      FIFO_TRANSFER: begin
        g2 <= 1;
        if (!r2) begin
          next_state = IDLE;
        end
      end
    endcase
  end
endmodule
