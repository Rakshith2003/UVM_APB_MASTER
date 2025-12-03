class apbm_active_agent extends uvm_agent;
  apbm_driver    driver;
  apbm_sequencer sequencer;
  apbm_active_monitor   active_monitor;
  
  `uvm_component_utils(apbm_active_agent)

  function new (string name = "apbm_active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(uvm_active_passive_enum)::get(this,"","is_active",is_active))
      `uvm_fatal("NO vif","IS_ACTIVE is not defined")
   
    if(get_is_active() == UVM_ACTIVE)begin
      driver = apbm_driver::type_id::create("driver", this);
      sequencer = apbm_sequencer::type_id::create("sequencer", this);
    end
    
    active_monitor = apbm_active_monitor::type_id::create("monitor", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
    begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction

endclass
