module cdc_rst_sync #(
   // Configurable parameters   
   parameter STAGES  = 2 // No. of flops in the chain, min. 2
)
(
   input  logic clk, // Clock @ destination clock domain   
   input  logic i_rst_async, // Asynchronous reset
   output logic o_rst_sync // Synchronized reset
);

logic [STAGES-1: 0] sync_ff;

// Synchronizing logic
always @(posedge clk) begin   
   sync_ff <= {sync_ff [STAGES-2 : 0], i_rst_async}; 
end

// Synchronized reset
assign o_rst_sync = sync_ff [STAGES-1];

endmodule