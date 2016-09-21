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
// Title       : memory
// Author      : Caleb Fangmeier
// Description : Memory interface
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module memory(

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire sys_clk,
  input  wire reset,
  input  wire [31:0] data_i,
  output wire [31:0] data_o,
  input  wire [19:0] addr,
  input  wire write_req,
  input  wire read_req,
  output reg  busy

  //--------------------------------------------------------------------------
  //---------------------------HW INTERFACE-----------------------------------
  //--------------------------------------------------------------------------
  //===RAM===
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
  //===RJ-45 LEDs===
  //===SPI-Interface===
  );



always @( posedge sys_clk  or posedge reset ) begin



end

rj45_led_controller rj45_led_controller_inst(
  .clk ( sys_clk ),
  .led_vals_i ( rj45_led_data[7:0] ),
  .led_vals_o (  ),
  .rj45_led_sck ( rj45_led_sck ),
  .rj45_led_sin ( rj45_led_sin ),
  .rj45_led_lat ( rj45_led_lat ),
  .rj45_led_blk ( rj45_led_blk )
);

spi_controller spi_controller_inst(
  .sys_clk ( sys_clk ),
  .reset ( reset ),
  .dac_request_write ( dac_request_write ),
  .dac_address ( dac_address ),
  .dac_data ( dac_data ),
  .adc_request_write ( adc_request_write ),
  .adc_request_read ( adc_request_read ),
  .adc_address ( adc_address ),
  .adc_data ( adc_data ),
  .adc_data_readback ( adc_data_readback ),
  .busy ( spi_busy ),
  .sclk ( sclk ),
  .sdio ( sdio ),
  .adc_csb ( adc_csb ),
  .dac_csb ( {supdac_csb, rngdac_csb} )
);

memory memory_inst(
  .sys_clk (  ),
  .mem_addr (  ),
  .mem_ba (  ),
  .mem_cas_n (  ),
  .mem_cke (  ),
  .mem_clk (  ),
  .mem_clk_n (  ),
  .mem_cs_n (  ),
  .mem_dm (  ),
  .mem_dq (  ),
  .mem_dqs (  ),
  .mem_odt (  ),
  .mem_ras_n (  ),
  .mem_we_n (  )
);
