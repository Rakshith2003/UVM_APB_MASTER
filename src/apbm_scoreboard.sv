`uvm_analysis_imp_decl(_active)
`uvm_analysis_imp_decl(_passive)

class apbm_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apbm_scoreboard)
  uvm_analysis_imp_active #(apbm_sequence_item, apbm_scoreboard) item_collected_export_active;
  uvm_analysis_imp_passive #(apbm_sequence_item, apbm_scoreboard) item_collected_export_passive;
  int match = 0;
  int mismatch = 0;
  int total_transactions = 0;
 apbm_sequence_item act_in;
apbm_sequence_item  pass_in;
  apbm_sequence_item a_mon_queue[$];
  apbm_sequence_item p_mon_queue[$];
  
  function new(string name = "apbm_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export_active  = new("item_collected_export_active",  this);
    item_collected_export_passive = new("item_collected_export_passive", this);
  endfunction


  virtual function void write_active(apbm_sequence_item a_transaction);
   apbm_sequence_item a_tr=a_transaction;
    a_mon_queue.push_back(a_tr);
  endfunction:write_active

  virtual function void write_passive(apbm_sequence_item p_trans);
    apbm_sequence_item p_tr=p_trans;
    p_mon_queue.push_back(p_tr);
  endfunction:write_passive

  

  virtual task run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin
    // Wait until both queues have at least one element
    wait(a_mon_queue.size() > 0 && p_mon_queue.size() > 0);
    act_in  = a_mon_queue.pop_front();
    pass_in = p_mon_queue.pop_front();
    total_transactions++;
    $display("[time=%t]Active monitor item : transfer= %d, addr_in=%d,write_read= %d,wdata_in= %d, strb_in=%d,PRDATA= %d, PREADY=%d, PSLVERR=%d",$time,act_in.transfer, act_in.addr_in, act_in.write_read,
         act_in.wdata_in, act_in.strb_in, act_in.PRDATA,
         act_in.PREADY, act_in.PSLVERR);

   $display("[time=%t] Passive monitor item :  PADDR=%d,PSEL= %d, PENABLE=%d,PWRITE= %d,PWDATA= %d,PSTRB= %d,rdata_out= %d,transfer_done= %d, error=%d",$time,
         
         pass_in.PADDR, pass_in.PSEL, pass_in.PENABLE, pass_in.PWRITE,
         pass_in.PWDATA, pass_in.PSTRB, pass_in.rdata_out,
         pass_in.transfer_done, pass_in.error);

  end
endtask
endclass





