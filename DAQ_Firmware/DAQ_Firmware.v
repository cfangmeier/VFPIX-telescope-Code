/* DAQ_Firmware.v
 * This is the top level design file for the DAQ Firmware.
 *
 *
 */

`timescale 1ps / 1ps

module DAQ_Firmware(

  // Opal Kelly *FrontPanel* Interface
  input  wire [4:0]  okUH,
  output wire [2:0]  okHU,
  inout  wire [31:0] okUHU,
  inout  wire        okAA,
  input  wire user_reset, // Part of Host interface
  input  wire sys_clk,  // 50 MHz
  output [1:0] led,

  // ok FLASH interface (Check Directionality)
  output spi_dq0,
  output spi_dq1,
  output spi_c,
  output spi_s,
  output spi_w_dq2,
  output spi_hold_dq3,

  // RAM Interface
  output wire [12:0] mem_addr,
  output wire [2 :0] mem_ba,
  output wire        mem_cas_n,
  output wire [0 :0] mem_cke,
  inout  wire [0 :0] mem_clk,
  inout  wire [0 :0] mem_clk_n,
  output wire [0 :0] mem_cs_n,
  output wire [1 :0] mem_dm,
  inout  wire [15:0] mem_dq,
  inout  wire [1 :0] mem_dqs,
  output wire [0 :0] mem_odt,
  output wire        mem_ras_n,
  output wire        mem_we_n,

  // ADC LVDS Inputs
  input wire adc_1a,
  input wire adc_1b,
  input wire adc_1c,
  input wire adc_1d,
  input wire adc_1dco,
  input wire adc_1fco,

  input wire adc_2a,
  input wire adc_2b,
  input wire adc_2c,
  input wire adc_2d,
  input wire adc_2dco,
  input wire adc_2fco,

  input wire adc_3a,
  input wire adc_3b,
  input wire adc_3c,
  input wire adc_3d,
  input wire adc_3dco,
  input wire adc_3fco,

  input wire adc_4a,
  input wire adc_4b,
  input wire adc_4c,
  input wire adc_4d,
  input wire adc_4dco,
  input wire adc_4fco,

  input wire adc_5a,
  input wire adc_5b,
  input wire adc_5c,
  input wire adc_5d,
  input wire adc_5dco,
  input wire adc_5fco,

  input wire adc_6a,
  input wire adc_6b,
  input wire adc_6c,
  input wire adc_6d,
  input wire adc_6dco,
  input wire adc_6fco,

  input wire adc_7a,
  input wire adc_7b,
  input wire adc_7c,
  input wire adc_7d,
  input wire adc_7dco,
  input wire adc_7fco,

  input wire adc_8a,
  input wire adc_8b,
  input wire adc_8c,
  input wire adc_8d,
  input wire adc_8dco,
  input wire adc_8fco,

  // PLL Clock for ADCs
  output wire adc_clk,

  // External SPI Interface
  output wire spi_sdio,
  output wire spi_sclk,

  // RJ45 LED Controller
  output wire rj45_led_clk,
  output wire rj45_led_sda,
  output wire rj45_led_latch,
  output wire rj45_led_blank
  );




// Wire Declarations
wire global_reset_n; // TODO: Hook this to an okWire(if needed)
assign global_reset_n = !user_reset;

wire             mem_aux_full_rate_clk;
wire             mem_aux_half_rate_clk;
wire    [ 24: 0] mem_local_addr;
wire    [  9: 0] mem_local_col_addr;
wire             mem_local_cs_addr;
wire    [  3: 0] mem_local_be;
wire             local_burstbegin_sig;
wire    [ 31: 0] mem_local_rdata;
wire             mem_local_rdata_valid;
wire             mem_local_read_req;
wire             mem_local_ready;
wire    [  2: 0] mem_local_size;
wire    [ 31: 0] mem_local_wdata;
wire             mem_local_write_req;

wire             phy_clk;
wire             reset_phy_clk_n;

wire             tie_high;
wire             tie_low;
assign tie_high = 1'b1;
assign tie_low = 1'b0;


// TODO: Figure out what these wires need to do
wire             pnf;
wire    [  3: 0] pnf_per_byte;
wire             test_complete;
wire    [  7: 0] test_status;

wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;
// Opal Kelly Frontpanel Declarations
okHost okHI(
	.okUH(okUH),
	.okHU(okHU),
	.okUHU(okUHU),
	.okAA(okAA),
	.okClk(okClk),
	.okHE(okHE),
	.okEH(okEH)
);



ADC_Deserializer Deser1 (
  .reset(),
  .data_a( adc_1a ),
  .data_b( adc_1b ),
  .data_c( adc_1c ),
  .data_d( adc_1d ),
  .data_clk( adc_8dco ),
  .frame_clk( adc_8fco ),
  .deser_a(),
  .deser_b(),
  .deser_c(),
  .deser_d()
);


// Instantiate the DDR2 Controller
DDR2_Controller DDR2_Controller_inst
  (
    .aux_full_rate_clk (mem_aux_full_rate_clk), // Unused
    .aux_half_rate_clk (mem_aux_half_rate_clk), // Unused
    .global_reset_n (global_reset_n),           // Global Reset(From okWire)
    .local_address (mem_local_addr),            // Driver IN
    .local_be (mem_local_be),                   // Driver IN
    .local_burstbegin (local_burstbegin_sig),   // Driver IN
    .local_init_done (),                        // Unused OUT
    .local_rdata (mem_local_rdata),             // Driver OUT
    .local_rdata_valid (mem_local_rdata_valid), // Driver OUT
    .local_read_req (mem_local_read_req),       // Driver IN
    .local_ready (mem_local_ready),             // Driver OUT  (Implies command fifo not empty)
    .local_refresh_ack (),                      // Unused OUT
    .local_size (mem_local_size),               // Driver IN
    .local_wdata (mem_local_wdata),             // Driver IN
    .local_write_req (mem_local_write_req),     // Driver IN
    .mem_addr (mem_addr[12 : 0]),               // PHY
    .mem_ba (mem_ba),                           // PHY
    .mem_cas_n (mem_cas_n),                     // PHY
    .mem_cke (mem_cke),                         // PHY
    .mem_clk (mem_clk),                         // PHY
    .mem_clk_n (mem_clk_n),                     // PHY
    .mem_cs_n (mem_cs_n),                       // PHY
    .mem_dm (mem_dm[1 : 0]),                    // PHY
    .mem_dq (mem_dq),                           // PHY
    .mem_dqs (mem_dqs[1 : 0]),                  // PHY
    .mem_odt (mem_odt),                         // PHY
    .mem_ras_n (mem_ras_n),                     // PHY
    .mem_we_n (mem_we_n),                       // PHY
    .phy_clk (phy_clk),                         // ???
    .pll_ref_clk (sys_clk),                     // IN Clock source(50 MHz)
    .reset_phy_clk_n (reset_phy_clk_n),         // ???
    .reset_request_n (),                        // ???
    .soft_reset_n (tie_high)                    // ???
  );
assign mem_local_addr[8 : 0] = mem_local_col_addr[9 : 1];

// Instantiate the DDR2 Driver, This one performs a series of tests on the memory
DDR2_Controller_example_driver driver
  (
    .clk (phy_clk),
    .local_bank_addr (mem_local_addr[24 : 22]),
    .local_be (mem_local_be),
    .local_burstbegin (local_burstbegin_sig),
    .local_col_addr (mem_local_col_addr),
    .local_cs_addr (mem_local_cs_addr),
    .local_rdata (mem_local_rdata),
    .local_rdata_valid (mem_local_rdata_valid),
    .local_read_req (mem_local_read_req),
    .local_ready (mem_local_ready),
    .local_row_addr (mem_local_addr[21 : 9]),
    .local_size (mem_local_size),
    .local_wdata (mem_local_wdata),
    .local_write_req (mem_local_write_req),
    .pnf_per_byte (pnf_per_byte[3 : 0]),
    .pnf_persist (pnf),
    .reset_n (reset_phy_clk_n),
    .test_complete (test_complete),
    .test_status (test_status)
  );
endmodule
