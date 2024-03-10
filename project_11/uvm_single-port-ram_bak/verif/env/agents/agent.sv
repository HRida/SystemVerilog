`ifndef AGENT
`define AGENT

class agent extends uvm_agent;
    //register agent within the factory
    `uvm_component_utils(agent)

    //agent constructor
    function new(string name = "AGENT", uvm_component parent);
      super.new(name,parent);
    endfunction

    //declare a monitor component
    monitor   m; 
    //declare a driver component
    driver    d;
    //declare sequencer component
    sequencer seq;

    //build phase function to create
    //monitor, driver and sequencer instances
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m = monitor::type_id::create("MON",this);
      d = driver::type_id::create("DRV",this);
      seq = sequencer::type_id::create("SEQ",this);
    endfunction

    //connect phase function
    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      //connect the driver analysis port
      //to the sequencer analysis export
      d.seq_item_port.connect(seq.seq_item_export);
    endfunction

endclass
`endif

