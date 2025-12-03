class apbm_active_monitor extends uvm_monitor;
  virtual apbm_inf vif;  // Virtual interface handle for apbm interface
  uvm_analysis_port #(apbm_sequence_item) item_collected_port;    // Analysis port
  apbm_sequence_item seq_item;

  // Register this component with UVM factory
  `uvm_component_utils(apbm_active_monitor)

  function new (string name, uvm_component parent);
    super.new(name, parent);
    seq_item = new();
    item_collected_port = new("item_collected_port", this);
  endfunction:new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apbm_inf)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    repeat(2)@(posedge vif.a_mon_cb);
    forever 
    begin
       repeat(1)@(posedge vif.a_mon_cb);  
      seq_item.transfer = vif.a_mon_cb.transfer;
      seq_item.addr_in = vif.a_mon_cb.addr_in;
      seq_item.write_read = vif.a_mon_cb.write_read;
      seq_item.wdata_in = vif.a_mon_cb.wdata_in;
      seq_item.strb_in = vif.a_mon_cb.strb_in;
      seq_item.PRDATA = vif.a_mon_cb.PRDATA;
      seq_item.PREADY = vif.a_mon_cb.PREADY;
		seq_item.PSLVERR = vif.a_mon_cb.PSLVERR;
      item_collected_port.write(seq_item); 
      repeat(1)@(posedge vif.a_mon_cb);
    end
  endtask
endclass
