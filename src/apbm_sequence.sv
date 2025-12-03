class apbm_sequence extends uvm_sequence#(apbm_sequence_item);
  
  `uvm_object_utils(apbm_sequence)
  function new(string name = "apbm_sequence");
    super.new(name);
  endfunction


  virtual task body();
    repeat(2)
    begin
    req = apbm_sequence_item::type_id::create("req");
    wait_for_grant();
      req.randomize();
    send_request(req);
    wait_for_item_done();
	end
  endtask
endclass

class apbm_sequence1 extends uvm_sequence#(apbm_sequence_item);//            1
  
  `uvm_object_utils(apbm_sequence1)
   
  function new(string name = "apbm_sequence1");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.write_read==1;req.transfer==1;req.addr_in==1;req.wdata_in==10;req.strb_in==1;req.PRDATA==10;})
  endtask
endclass
