`ifndef ADDER_4_BIT_DRIVER
`define ADDER_4_BIT_DRIVER

class driver extends uvm_driver#(transaction);
    transaction t;
    virtual ram_if rif;

    `uvm_component_utils(driver)
    //uvm_analysis_port#(transaction) drv2rm_port;
     
    function new(string name = "DRV", uvm_component parent);
      super.new(name, parent);
    endfunction
     
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //t = transaction::type_id::create("TRANS");
      if(!uvm_config_db#(virtual ram_if)::get(this,"","rif",rif))
        `uvm_info(get_full_name(), "Unable to access Interface", UVM_NONE);
    endfunction

    virtual task run_phase(uvm_phase phase);
      forever begin
        seq_item_port.get_next_item(t);
        rif.addr = t.addr;
        rif.din  = t.din;
        rif.wr   = t.wr;
        `uvm_info(get_full_name(),$sformatf("TRANSACTION FROM DRIVER TO DUT INTERFACE"),UVM_LOW);
        t.print();
        @(posedge rif.clk);
     
        if(t.wr == 1'b0)
          @(posedge rif.clk);
        seq_item_port.item_done();
      end
    endtask
endclass

`endif

