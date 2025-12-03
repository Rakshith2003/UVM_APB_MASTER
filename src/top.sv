`include "apbm_interface.sv"
`include "apbm_pkg.svh"
`include "apb_master.sv"
import uvm_pkg::*;
import apbm_pkg::*;

module top;
  bit PCLK = 0;

  // Clock generation : 10ns period (100 MHz)
  always #5 PCLK = ~PCLK;

  // Interface instantiation, connect PCLK into interface
  apbm_inf vif(PCLK);

  // DUT instantiation - CONNECT TO INTERFACE SIGNALS
  apb_master #(
    .ADDR_WIDTH(8),
    .DATA_WIDTH(32)
  ) u_apb_master (
    .PCLK         (vif.PCLK),       // or just PCLK, both okay
    .PRESETn      (vif.PRESETn),

    // APB signals (to slave)
    .PADDR        (vif.PADDR),
    .PSEL         (vif.PSEL),
    .PENABLE      (vif.PENABLE),
    .PWRITE       (vif.PWRITE),
    .PWDATA       (vif.PWDATA),
    .PSTRB        (vif.PSTRB),
    .PRDATA       (vif.PRDATA),
    .PREADY       (vif.PREADY),
    .PSLVERR      (vif.PSLVERR),

    // User-side signals (from driver)
    .transfer     (vif.transfer),
    .write_read   (vif.write_read),
    .addr_in      (vif.addr_in),
    .wdata_in     (vif.wdata_in),
    .strb_in      (vif.strb_in),

    // Outputs back to TB
    .rdata_out    (vif.rdata_out),
    .transfer_done(vif.transfer_done),
    .error        (vif.error)
  );

  initial begin
    uvm_config_db#(virtual apbm_inf)::set(null, "*", "vif", vif);
    $dumpfile("wave.vcd");
    $dumpvars(0);
  end

  // Proper reset
  initial begin
    vif.PRESETn = 0;
    repeat (2) @(posedge PCLK);
    vif.PRESETn = 1;
  end

  initial begin
    run_test("apbm_test1");
  end

endmodule : top

