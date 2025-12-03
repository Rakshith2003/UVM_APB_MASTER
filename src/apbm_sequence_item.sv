
class apbm_sequence_item extends uvm_sequence_item;
	rand logic [31:0] PRDATA;
    rand logic PREADY;
    rand logic PSLVERR;
    rand logic transfer;
    rand logic write_read;
    rand logic [7:0] addr_in;
    rand logic [31:0] wdata_in;
    rand logic [3:0] strb_in;
    logic [31:0] rdata_out;
    logic transfer_done;
    logic error;
    logic [7:0] PADDR;
    logic PSEL;
    logic PENABLE;
    logic PWRITE;
    logic [31:0] PWDATA;
    logic [3:0] PSTRB;
    
  // Factory registration
  `uvm_object_utils_begin(apbm_sequence_item)
    `uvm_field_int(PRDATA,UVM_ALL_ON)
    `uvm_field_int(PREADY,UVM_ALL_ON)
    `uvm_field_int(PSLVERR,UVM_ALL_ON)
    `uvm_field_int(transfer,UVM_ALL_ON)
    `uvm_field_int(write_read,UVM_ALL_ON)
    `uvm_field_int(addr_in,UVM_ALL_ON)
    `uvm_field_int(wdata_in,UVM_ALL_ON)
    `uvm_field_int(strb_in,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "apbm_sequence_item");
    super.new(name);
 	endfunction:new
  
endclass
