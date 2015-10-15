  module DAQ_Firmware(
  // Frontpanel Hardware Interface Pins
  //input wire [7:0] hi_in,
  //input wire [7:0] hi_out,
  //input wire [15:0] hi_inout,

  // ok Interface (Check Directionality)
  input [4:0] okUH,
  input [2:0] okHU,
  input [31:0] okUHU,
  input okAA,
  input user_reset,
  input sys_clk,
  output [1:0] led,

  // ok FLASH interface (Check Directionality)
  output spi_dq0,
  output spi_dq1,
  output spi_c,
  output spi_s,
  output spi_w_dq2,
  output spi_hold_dq3,

  // RAM Interface
  output [12:0] mem_addr,
  output [2:0] mem_ba,
  output mem_cas_n,
  output [0:0] mem_cke,
  output [0:0] mem_clk,
  output [0:0] mem_clk_n,
  output [0:0] mem_cs_n,
  output [1:0] mem_dm,
  output [15:0] mem_dq,
  output [1:0] mem_dqs,
  output [0:0] mem_odt,
  output mem_ras_n,
  output mem_we_n,

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
endmodule
