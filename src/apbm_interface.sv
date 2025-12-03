interface apbm_inf(input logic PCLK);
    logic PRESETn;
    logic [7:0] PADDR;
    logic PSEL;
    logic PENABLE;
    logic PWRITE;
    logic [31:0] PWDATA;
    logic [3:0] PSTRB;
    logic [31:0] PRDATA;
    logic PREADY;
    logic PSLVERR;
    logic transfer;
    logic write_read;
    logic [7:0] addr_in;
    logic [31:0] wdata_in;
    logic [3:0] strb_in;
    logic [31:0] rdata_out;
    logic transfer_done;
    logic error;
  
  clocking drv_cb@(posedge PCLK);
    output transfer,write_read,addr_in,wdata_in,strb_in,PRDATA,PREADY,PSLVERR;
  endclocking
  
  clocking a_mon_cb@(posedge PCLK);
    input transfer,write_read,addr_in,wdata_in,strb_in,PRDATA,PREADY,PSLVERR;
  endclocking
  
  clocking p_mon_cb@(posedge PCLK);
    input PADDR,PSEL,PENABLE,PWRITE,PWDATA,PSTRB,rdata_out,transfer_done,error;
  endclocking
endinterface
    
