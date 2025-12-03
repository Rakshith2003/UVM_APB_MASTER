class apbm_passive_agent extends uvm_agent;
  apbm_passive_monitor  passive_monitor;    // Passive monitor instance declaration

  // Registering the component with the factory
  `uvm_component_utils(apbm_passive_agent)

  function new (string name = "apbm_passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    passive_monitor = apbm_passive_monitor::type_id::create("passive_monitor", this);
  endfunction:build_phase
endclass
