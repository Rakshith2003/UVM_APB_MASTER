interface nco_assert(clk,resetn,signal_out,wave_out);
input bit clk;
input bit resetn;
input logic [`SELECT_WIDTH-1:0] signal_out;
input logic [`WAVE_WIDTH-1:0] wave_out;



endinterface
