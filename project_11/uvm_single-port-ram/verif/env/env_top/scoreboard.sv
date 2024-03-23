class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
     
    uvm_analysis_imp #(transaction,scoreboard) mon2sb_export;
     
    logic [7:0] sb_arr[16] = '{default:0};
    bit error;
     
    function new(string name= "SB", uvm_component parent);
      super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon2sb_export = new("READ",this);
    endfunction

    virtual function void write(transaction data);
      `uvm_info(get_full_name(),"Data received from Monitor", UVM_NONE);
      data.print();
       
      if(data.wr == 1'b1) begin
        sb_arr[data.addr] = data.din;
        `uvm_info(get_full_name(), $sformatf("Data Write Operation din :%0h and sb_arr[data.addr] : %0h ", data.din, sb_arr[data.addr]), UVM_NONE);
      end
         
      if(data.wr == 1'b0) begin
	if(data.dout == sb_arr[data.addr]) begin
          `uvm_info(get_full_name(), "MATCH ", UVM_NONE)
	end else begin
          `uvm_error("SB", "MISMATCH");
           error=1;
        end
        `uvm_info(get_full_name(), $sformatf("Data Read Operation dout :%0h and sb_arr[data.addr] : %0h ", data.dout, sb_arr[data.addr]), UVM_NONE);
      end
    endfunction

   ///////////////////////////////////////////////////////////////////////////////
   // Method name : report
   // Description : Report the testcase status PASS/FAIL
   ///////////////////////////////////////////////////////////////////////////////
   function void report_phase(uvm_phase phase);
     if(error==0) begin
       $display("-------------------------------------------------");
       $display("------ INFO : TEST CASE PASSED ------------------");
       $display("-----------------------------------------");
     end else begin
       $display("---------------------------------------------------");
       $display("------ ERROR : TEST CASE FAILED ------------------");
       $display("---------------------------------------------------");
     end
   endfunction

endclass
