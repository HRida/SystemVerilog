typedef enum {
  STATE0,
  STATE1,
  STATE2
} State;

module moore_FSM (
  input logic clk,
  input logic reset,
  input logic [1:0] in,
  output logic [1:0] out
);

  State state, next_state;

  always_ff @(posedge clk) begin
    if (reset == 1'b1) begin
      state <= STATE0;
    end else begin
      state <= next_state;
    end
  end
  always_comb begin
    case (state)
      STATE0: begin
        out = 2'b00;
        next_state = (in==2'b01) ? STATE1 : STATE0;
      end
      STATE1: begin
        out = 2'b01;
        next_state = (in==2'b10) ? STATE2 : STATE0;
      end
      STATE2: begin
        out = 2'b10;
        next_state = (in==2'b11) ? STATE2 : STATE0;
      end
      default: begin
        out = 0;
        next_state = STATE0;
      end
    endcase
  end

endmodule
