 /* memory.v
  *
  * This is the top-level design file for the telescope firmware
  */
`default_nettype none

module memory(
  input wire sys_clk,
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
  output wire                mem_we_n
);

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
endmodule
