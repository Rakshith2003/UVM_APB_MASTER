class apbm_base extends uvm_test;
  apbm_environment env;
  `uvm_component_utils(apbm_base)
  
  function new(string name="apbm_base",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=apbm_environment::type_id::create("env",this);
//     uvm_config_db#(uvm_active_passive_enum)::set(this,"env.passive_agent" , "is_active" ,UVM_PASSIVE);      		  
//     uvm_config_db#(uvm_active_passive_enum)::set(this,"env.active_agent","is_active",UVM_ACTIVE);
  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_top.print_topology();
  endfunction
  
endclass

class apbm_test1 extends apbm_base; //1
  
  `uvm_component_utils(apbm_test1)
  function new(string name="apbm_test1",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    apbm_sequence1 seq;
    phase.raise_objection(this);
    seq = apbm_sequence1::type_id::create("seq");
    repeat(5)begin
      seq.start(env.active_agent.sequencer);
     end
    phase.drop_objection(this);
  endtask
endclass
