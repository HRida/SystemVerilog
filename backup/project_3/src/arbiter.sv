module Arbiter(
    input logic clk,
    input logic reset,
    input logic r0,
    input logic r1,
    input logic r2,
    output logic g0,
    output logic g1,
    output logic g2
);

typedef enum logic {
        IDLE,
        GRANT_DEVICE_0,
        GRANT_DEVICE_1,
        GRANT_DEVICE_2
    } arbiter_states_t;

arbiter_states_t state, next_state;

always_ff @(posedge reset) 
begin
    if (reset) begin
        state <= IDLE;
    end 
    else begin
        state <= next_state;
    end
end

always_comb 
begin
    // State transition logic
    case(state)
        IDLE:
            if (r0) begin
                g0 = 1'b1; g1= 1'b0; g2=1'b0;
                next_state = GRANT_DEVICE_0;
            end
            if (!r0 & r1) begin
                g0 = 1'b0; g1= 1'b1; g2=1'b0;
                next_state = GRANT_DEVICE_1;
            end
            if (!r0 & !r1 & r2) begin
                g0 = 1'b0; g1=1'b0; g2=1'b1;
                next_state = GRANT_DEVICE_2;
            end
        GRANT_DEVICE_0:
            if (!r0) begin
                g0 = 1'b0; g1= 1'b0; g2=1'b0;
                next_state = IDLE;
            end
        GRANT_DEVICE_1:
            if (!r1) begin
                g0 = 1'b0; g1= 1'b0; g2=1'b0;
                next_state = IDLE;
            end
        GRANT_DEVICE_2:
            if (!r2) begin
                g0 = 1'b0; g1= 1'b0; g2=1'b0;
                next_state = IDLE;
            end
    endcase
end
endmodule : arbiter