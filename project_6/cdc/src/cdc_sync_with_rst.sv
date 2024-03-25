module cdc_sync_with_rst #(  
   // Configurable parameters   
   parameter STAGES = 2 // No. of flops in the chain, min. 2
)
(
   input  logic clk, // Clock @ destination clock domain
   input  logic rstn, // Sync Reset @ destination clock domain
   input  logic i_sig, // Input signal, asynchronous
   output logic o_sig_sync          // Output signal synchronized to clk
);

logic [STAGES-1: 0] sync_ff;

// Synchronizing logic
always @(posedge clk) begin
   if (!rstn) begin
      sync_ff <= 1'b0;
   end
   else begin
      sync_ff <= {sync_ff [STAGES-2 : 0], i_sig};     
   end  
end

// Synchronized signal
assign o_sig_sync = sync_ff [STAGES-1];

endmodule