module synchronizer (
  input  logic clk2,
  input  logic g,
  output logic g_sync
);

  logic g_sync1, g_sync2;

  // Synchronizing logic
  always @(posedge clk2) begin
    g_sync1 <= g;
    g_sync2 <= g_sync1;
  end

  // Synchronized reset
  assign g_sync = g_sync2;


endmodule : synchronizer