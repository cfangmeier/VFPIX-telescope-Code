//-------------------------------------------------------------------------
//  COPYRIGHT (C) 2016  Univ. of Nebraska - Lincoln
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//-------------------------------------------------------------------------
// Title       : daq_firmware
// Author      : Caleb Fangmeier
// Description : This is the top-level design file for the telescope
//               firmware
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module daq_firmware(
  input  wire [4:0]   okUH,
  output wire [2:0]   okHU,
  inout  wire [31:0]  okUHU,
  inout  wire         okAA,

  input  wire         sys_clk,  // 50 MHz

  output wire [1:0]   led,
  output wire [1:0]   led_ext,

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
  output wire                rj45_led_blk,

  output wire                sclk,
  inout  wire                sdio,
  output wire                supdac_csb,
  output wire                rngdac_csb,
  output wire  [7:0]         adc_csb,

  output  wire               adc_clk,  // 10 MHz
  input   wire [7:0]         adc_fco,
  input   wire [7:0]         adc_dco,
  input   wire [7:0]         adc_dat_a,
  input   wire [7:0]         adc_dat_b,
  input   wire [7:0]         adc_dat_c,
  input   wire [7:0]         adc_dat_d,

  inout  wire  [3:0]         flash_dq,
  output wire                flash_c,
  output wire                flash_sb
  );

wire clk;
wire reset;
wire hal_init_finished;

wire        memory_read_req;
wire        memory_write_req;
wire [25:0] memory_addr;
wire [31:0] memory_data_write;
wire [31:0] memory_data_read;
wire        memory_busy;

// High-Level Control Unit
control_unit control_unit_inst (
  .clk ( clk ),
  .reset ( reset ),

  .memory_read_req ( memory_read_req ),
  .memory_write_req ( memory_write_req ),
  .memory_addr ( memory_addr ),
  .memory_data_write ( memory_data_write ),
  .memory_data_read ( memory_data_read ),
  .memory_busy ( memory_busy )
);

hal hal_inst(
  .sys_clk ( sys_clk ),
  .clk ( clk ),
  .reset ( reset ),
  .hal_init_finished ( hal_init_finished ),

  // Processor Interface
  .memory_read_req ( memory_read_req ),
  .memory_write_req ( memory_write_req ),
  .memory_addr ( memory_addr ),
  .memory_data_write ( memory_data_write ),
  .memory_data_read ( memory_data_read ),
  .memory_busy ( memory_busy ),


  // Hardware Interface
  .led ( led ),
  .led_ext ( led_ext ),

  .mem_addr ( mem_addr ),
  .mem_ba ( mem_ba ),
  .mem_cas_n ( mem_cas_n ),
  .mem_cke ( mem_cke ),
  .mem_clk ( mem_clk ),
  .mem_clk_n ( mem_clk_n ),
  .mem_cs_n ( mem_cs_n ),
  .mem_dm ( mem_dm ),
  .mem_dq ( mem_dq ),
  .mem_dqs ( mem_dqs ),
  .mem_odt ( mem_odt ),
  .mem_ras_n ( mem_ras_n ),
  .mem_we_n ( mem_we_n ),

  .rj45_led_sck ( rj45_led_sck ),
  .rj45_led_sin ( rj45_led_sin ),
  .rj45_led_lat ( rj45_led_lat ),
  .rj45_led_blk ( rj45_led_blk ),

  .sclk ( sclk ),
  .sdio ( sdio ),
  .supdac_csb ( supdac_csb ),
  .rngdac_csb ( rngdac_csb ),
  .adc_csb ( adc_csb ),

  .adc_clk ( adc_clk ),  // ?? MHz
  .adc_fco ( adc_fco ),
  .adc_dco ( adc_dco ),
  .adc_dat_a ( adc_dat_a ),
  .adc_dat_b ( adc_dat_b ),
  .adc_dat_c ( adc_dat_c ),
  .adc_dat_d ( adc_dat_d ),

  .flash_dq ( flash_dq ),
  .flash_c ( flash_c ),
  .flash_sb ( flash_sb ),

  // FrontPanel Interface
  .okUH ( okUH ),
  .okHU ( okHU ),
  .okUHU ( okUHU ),
  .okAA ( okAA )
  );


endmodule
