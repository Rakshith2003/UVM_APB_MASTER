class apbm_passive_monitor extends uvm_monitor;
  virtual apbm_inf vif;
  uvm_analysis_port #(apbm_sequence_item) item_collected_port;
  apbm_sequence_item seq_item;

  `uvm_component_utils(apbm_passive_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    seq_item = new();
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apbm_inf)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    repeat(2)@(posedge vif.p_mon_cb);
   forever begin
     repeat(1)@(posedge vif.p_mon_cb);
     
      seq_item.PADDR = vif.p_mon_cb.PADDR;
      seq_item.PSEL = vif.p_mon_cb.PSEL;
      seq_item.PENABLE = vif.p_mon_cb.PENABLE;
      seq_item.PWRITE = vif.p_mon_cb.PWRITE;
      seq_item.PWDATA = vif.p_mon_cb.PWDATA;
      seq_item.PSTRB = vif.p_mon_cb.PSTRB;
      seq_item.rdata_out = vif.p_mon_cb.rdata_out;
	  seq_item.transfer_done = vif.p_mon_cb.transfer_done;
	  seq_item.error = vif.p_mon_cb.error;
     //repeat(1)@(posedge vif.p_mon_cb);
      item_collected_port.write(seq_item); 
   end
  endtask
endclass
