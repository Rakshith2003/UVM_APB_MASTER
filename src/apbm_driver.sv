class apbm_driver extends uvm_driver #(apbm_sequence_item);
  virtual apbm_inf vif;
  
  `uvm_component_utils(apbm_driver)

  function new (string name = "apbm_driver", uvm_component parent);
    super.new(name, parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apbm_inf)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    repeat(2)@(posedge vif.drv_cb);
    forever begin
      seq_item_port.get_next_item(req); 
      drive();
      seq_item_port.item_done();
    end
  endtask
  
virtual task drive();
  if(req.write_read)
    begin
      vif.drv_cb.transfer<=req.transfer;
      vif.drv_cb.addr_in<=req.addr_in;
      vif.drv_cb.write_read<=req.write_read;
      vif.drv_cb.wdata_in<=req.wdata_in;
      vif.drv_cb.strb_in<=req.strb_in;
      vif.drv_cb.PRDATA<=req.PRDATA;
     
//       val=$urandom_range(1,3);
//       repeat(val)@(posedge vif.drv_cb);
      repeat(2)@(posedge vif.drv_cb);
      vif.drv_cb.PREADY<=1;
      vif.drv_cb.PSLVERR<=req.PSLVERR;
      
    end
  else
    begin
      vif.drv_cb.transfer<=req.transfer;
      vif.drv_cb.addr_in<=req.addr_in;
      vif.drv_cb.write_read<=req.write_read;
      vif.drv_cb.wdata_in<=req.wdata_in;
      vif.drv_cb.strb_in<=req.strb_in;
      //vif.drv_cb.PRDATA<=req.PRDATA;
//       val=$urandom_range(1,3);
//       repeat(val)@(posedge vif.drv_cb);
      //repeat(2)@(posedge vif.drv_cb);
      vif.drv_cb.PREADY<=1;
      vif.drv_cb.PSLVERR<=req.PSLVERR;
    end
  repeat(1)@(posedge vif.drv_cb);
endtask
endclass
