`default_nettype none

module daq_firmware(
  input  wire [4:0]   okUH,
  output wire [2:0]   okHU,
  inout  wire [31:0]  okUHU,
  inout  wire         okAA,

  input  wire         sys_clk,

  output wire [1:0]   led,

	output wire [ 12: 0]       mem_addr,
	output wire [  2: 0]       mem_ba,
	output wire                mem_cas_n,
	output wire [  0: 0]       mem_cke,
	inout  wire [  0: 0]       mem_clk,
	inout  wire [  0: 0]       mem_clk_n,
	output wire [  0: 0]       mem_cs_n,
	output wire [  1: 0]       mem_dm,
	inout  wire [ 15: 0]       mem_dq,
	inout  wire [  1: 0]       mem_dqs,
	output wire [  0: 0]       mem_odt,
	output wire                mem_ras_n,
	output wire                mem_we_n,

  output wire                rj45_led_sck,
  output wire                rj45_led_sin,
  output wire                rj45_led_lat,
  output wire                rj45_led_blk
  );

// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;


// Circuit wires
wire fifowrite;
wire fiforead;
wire [15:0] datain;
wire [15:0] dataout;
wire [15:0] wireout;


// Memory Interface
wire mem_aux_full_rate_clk;
wire mem_aux_half_rate_clk;
wire global_reset_n;
wire local_init_done;
wire local_burstbegin;
wire mem_local_addr;
wire mem_local_be;
wire mem_local_rdata;
wire mem_local_rdata_valid;
wire mem_local_read_req;
wire mem_local_ready;
wire mem_local_size;
wire mem_local_wdata;
wire mem_local_write_req;
wire phy_clk;
wire reset_phy_clk_n;
wire local_pll_locked;

ram_controller ram_controller_inst (
	.aux_full_rate_clk        (mem_aux_full_rate_clk),
	.aux_half_rate_clk        (mem_aux_half_rate_clk),
	.global_reset_n           (global_reset_n),
	
	.local_init_done          (local_init_done),
	.local_burstbegin         (local_burstbegin),
	
	.local_address            (mem_local_addr),
	.local_be                 (mem_local_be),
	.local_rdata              (mem_local_rdata),
	.local_rdata_valid        (mem_local_rdata_valid),
	.local_read_req           (mem_local_read_req),
	.local_ready              (mem_local_ready),
	.local_size               (mem_local_size),
	.local_wdata              (mem_local_wdata),
	.local_write_req          (mem_local_write_req),
	
	.mem_addr                 (mem_addr[12 : 0]),
	.mem_ba                   (mem_ba),
	.mem_cas_n                (mem_cas_n),
	.mem_cke                  (mem_cke),
	.mem_clk                  (mem_clk),
	.mem_clk_n                (mem_clk_n),
	.mem_cs_n                 (mem_cs_n),
	.mem_dm                   (mem_dm[1 : 0]),
	.mem_dq                   (mem_dq),
	.mem_dqs                  (mem_dqs[1 : 0]),
	.mem_odt                  (mem_odt),
	.mem_ras_n                (mem_ras_n),
	.mem_we_n                 (mem_we_n),
	
	.phy_clk                  (phy_clk),
	.pll_ref_clk              (sys_clk),
	.reset_phy_clk_n          (reset_phy_clk_n),
	.reset_request_n          (local_pll_locked),
	.soft_reset_n             (1'b1)
);

wire request_write;
wire request_read;

wire [31:0] data_in;
wire [31:0] data_out;


// 32 bit wide 1024 depth fifo
fifo32  fifo32_inst (
  .clock ( okClk ),
  .data ( data_in ),
  .rdreq ( request_read ),
  .wrreq ( request_write ),
  .empty ( ),
  .full ( ),
  .q ( data_out ),
  .usedw ( )
);

reg [31:0] led_data;
wire regWrite;
wire [31:0] regDataOut;
always @(negedge okClk) begin
  if (regWrite) begin
    led_data <= regDataOut;
  end
end

rj45_led_controller led_controller(
  .sys_clk ( sys_clk ),
  .led_vals ( led_data[7:0] ),
  .write_request ( 1'b1 ),
  .rj45_led_sck ( rj45_led_sck ),
  .rj45_led_sin ( rj45_led_sin ),
  .rj45_led_lat ( rj45_led_lat ),
  .rj45_led_blk ( rj45_led_blk )
);

// FrontPanel module instantiations
wire [65*3-1:0]  okEHx;
okHost okHI(
  .okUH(okUH),
  .okHU(okHU),
  .okUHU(okUHU),
  .okAA(okAA),
  .okClk(okClk),
  .okHE(okHE),
  .okEH(okEH)
);
okWireOR # (.N(3)) wireOR (okEH, okEHx);


okWireIn wire10(
  .okHE(okHE),
  .ep_addr(8'h10),
  .ep_dataout(wireout)
);

okPipeIn pipe80(
  .okHE(okHE),
  .okEH(okEHx[0*65 +: 65]),
  .ep_addr(8'h80),
  .ep_write(request_write),
  .ep_dataout(data_in)
);

okPipeOut pipeA0(
  .okHE(okHE),
  .okEH(okEHx[1*65 +: 65]),
  .ep_addr(8'hA0),
  .ep_read(request_read),
  .ep_datain(data_out)
);

okRegisterBridge regBridge (
  .okHE(okHE),
  .okEH(okEHx[2*65 +: 65]),
  .ep_write(regWrite),
  .ep_read(),
  .ep_address(),
  .ep_dataout(regDataOut),
  .ep_datain()
);

endmodule
