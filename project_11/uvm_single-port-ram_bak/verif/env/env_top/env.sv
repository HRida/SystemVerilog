`ifndef ENV
`define ENV

class env extends uvm_env;
    //register environment within factory
    `uvm_component_utils(env)

    //env constructor
    function new(string name = "ENV", uvm_component parent);
      super.new(name,parent);
    endfunction

    scoreboard s; //declare a scoreboard component
    agent a;  //declare an agent component
    
    // build phase function 
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a = agent::type_id::create("AGENT",this);
      s = scoreboard::type_id::create("SB",this);
    endfunction

    //connect phase function
    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      a.m.mon2sb_port.connect(s.mon2sb_export);
    endfunction
endclass


`endif

