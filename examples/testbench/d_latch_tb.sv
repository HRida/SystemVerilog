module d_latch_tb;
  logic d;  // To drive input "d" of d_latch
  logic en;  // To drive input "en" of d_latch
  logic rstn;  // To drive input "rstn" of d_latch
  logic prev_q;  // To ensure q has not changed when en=0
  logic q;  // To tap output from d_latch

  d_latch dut (
    .d(d),
    .en(en),
    .rstn(rstn),
    .q(q)
  );

  function void init();
    d <= 0;
    en <= 0;
    rstn <= 0;
  endfunction

  task reset_release();
    #10 rstn <= 1;
  endtask

  function checker_f(input d, en, rstn, q);
    #1;
    if (!rstn) begin
      if (q !== 0) begin
        $error("Q is not 0 during reset");
      end
    end else begin
      if (en) begin
        if (q != d) $error("Q does not follow D when EN is high");
      end else begin
        if (q != prev_q) $error("Q does not get latched");
      end
    end
  endfunction

  task test_1();
    // Randomly change d and enable
    for (integer i = 0; i < 5; i = i + 1) begin
      #($random) en <= ~en;
      #($random) d <= i;

      // Check output value for given inputs
      checker_f(d, en, rstn, q);
      prev_q <= q;
    end
  endtask

  initial begin
    init();
    reset_release();
    test_1();
  end
endmodule


