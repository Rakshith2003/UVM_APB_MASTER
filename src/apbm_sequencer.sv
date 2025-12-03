class apbm_sequencer extends uvm_sequencer#(apbm_sequence_item);
  `uvm_component_utils(apbm_sequencer)    // Register with the factory

  function new(string name = "apbm_sequencer",uvm_component parent = null);
    super.new(name,parent);
  endfunction:new
endclass
