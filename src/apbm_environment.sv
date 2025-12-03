class apbm_environment extends uvm_env;
  apbm_active_agent    active_agent;
  apbm_passive_agent   passive_agent;
  apbm_scoreboard 		scoreboard;
 // apbm_subscriber 		subscriber;
  
  `uvm_component_utils(apbm_environment)      
  
  function new(string name = "apbm_environment", uvm_component parent);
    	super.new(name, parent);
  endfunction:new

  function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
      uvm_config_db#(uvm_active_passive_enum)::set(this, "active_agent", "is_active", UVM_ACTIVE);
      uvm_config_db#(uvm_active_passive_enum)::set(this, "passive_agent", "is_active", UVM_PASSIVE);
      active_agent = apbm_active_agent::type_id::create("active_agent", this);  
    	passive_agent = apbm_passive_agent::type_id::create("passive_agent", this);
    	scoreboard = apbm_scoreboard::type_id::create("scoreboard", this);
    	//subscriber = apbm_subscriber::type_id::create("coverage", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);    								   
    active_agent.active_monitor.item_collected_port.connect(scoreboard.item_collected_export_active);  
    passive_agent.passive_monitor.item_collected_port.connect(scoreboard.item_collected_export_passive);
//     active_agent.active_monitor.item_collected_port.connect(subscriber.analysis_export);      
//     passive_agent.passive_monitor.item_collected_port.connect(subscriber.pass_mon);         
  endfunction
endclass
