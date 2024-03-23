`ifndef MONITOR
`define MONITOR

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
     
    uvm_analysis_port #(transaction) mon2sb_port;
    virtual ram_if rif;
    transaction t;
     
    function new(string name = "MON", uvm_component parent);
      super.new(name,parent);
      mon2sb_port = new("WRITE",this);
    endfunction
     
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      t = transaction::type_id::create("TRANS_ITEM");
      if(!uvm_config_db#(virtual ram_if)::get(this,"","rif",rif))
        `uvm_info(get_full_name(), "Unable to access Interface", UVM_NONE);
    endfunction
     
    virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
	collect_trans();
        mon2sb_port.write(t);
      end
    endtask

    // Description : run task for collecting transactions
    task collect_trans();
      @(posedge rif.clk);
      t.wr = rif.wr;
      t.din = rif.din;
      t.addr = rif.addr;
       
      if(rif.wr == 1'b0) begin
        @(posedge rif.clk);
        t.dout = rif.dout;
      end
      `uvm_info(get_full_name(), $sformatf("Monitor found packet %s", t.convert2str()), UVM_LOW)       
      //t.print(uvm_default_table_printer);
      //t.print(uvm_default_tree_printer);
      //t.print(uvm_default_line_printer);
      t.print();
    endtask
endclass

`endif

