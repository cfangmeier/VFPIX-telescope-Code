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

  input  wire         sys_clk_ext,  // 50 MHz

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

  output wire sclk,
  inout  wire sdio,
  output wire supdac_csb,
  output wire rngdac_csb,
  output wire [7:0] adc_csb,

  output  wire        adc_clk,  // ?? MHz
  input   wire [7:0]  adc_fco,
  input   wire [7:0]  adc_dco,
  input   wire [7:0]  adc_dat_a,
  input   wire [7:0]  adc_dat_b,
  input   wire [7:0]  adc_dat_c,
  input   wire [7:0]  adc_dat_d,

  inout  wire  [3:0]         flash_dq,
  output wire                flash_dq0,
  output wire                rj45_led_lat,
  output wire                rj45_led_blk,
  output wire                rj45_led_sck,
  output wire                rj45_led_sin,
  output wire                rj45_led_lat,
  output wire                rj45_led_blk,
  );

//
// PARAMETERS
//
parameter DEBUG_SIZE = 8; // Number of 16-bit wireouts in debug_unit
parameter OK_SIZE = DEBUG_SIZE+3;

//
// WIRES
//
// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

// Circuit wires
wire [31:0] wirein;
wire [DEBUG_SIZE*16-1:0] debug_wireout;

wire reset;

wire [31:0] data_in;
wire [31:0] data_out;

wire readback_buffer_write;
wire [31:0] readback_buffer_data;
wire [31:0] readback_buffer_q;
wire readback_buffer_full;
wire readback_buffer_read;


wire dac_request_write;
wire [4:0] dac_address;
wire [11:0] dac_data;

wire adc_request_write;
wire adc_request_read;
wire [10:0] adc_address;
wire [7:0] adc_data;
wire [7:0] adc_data_readback;

wire spi_busy;

wire [31:0] instr;
wire instr_empty;
wire instr_ack;
wire instr_write;

wire sys_clk;
wire debug_enable;
wire single_step_enable;
wire [7:0] debug_clock_counter;
wire [7:0] rj45_led_data;

wire [2:0] cu_state;
wire [4:0] cu_instr;

//
// REGISTERS
//
reg [31:0] pipe_out_buf;

//
// ASSIGNMENTS
//
assign reset = wirein[0];
assign debug_enable = wirein[1];
assign single_step_enable = wirein[2];
assign led = ~wirein[4:3];
assign led_ext = wirein[6:5];

assign debug_wireout[0] = instr_empty;
assign debug_wireout[1] = instr_ack;
assign debug_wireout[4:2] = cu_state[2:0];
assign debug_wireout[9:5] = cu_instr[4:0];
assign debug_wireout[14:10] = dac_address;
assign debug_wireout[25:15] = dac_data[10:0];
assign debug_wireout[26] = dac_request_write;
assign debug_wireout[27] = spi_busy;
assign debug_wireout[31:28] = 4'h0;
assign debug_wireout[63:32] = instr;
assign debug_wireout[64] = sclk;
assign debug_wireout[65] = sdio;
assign debug_wireout[66] = supdac_csb;
assign debug_wireout[67] = rngdac_csb;
assign debug_wireout[75:68] = adc_csb;
/* assign debug_wireout[127:68] = 60'h_A0A0_A0A0_A0A0_A0A0; */

/* generate */
/* genvar i; */
/* for (i=0; i< 16; i=i+1) begin: loop_label */
/*   assign debug_wireout[(i+1)*8-1 -: 7] = i; */
/* end */
/* endgenerate */

always @(posedge okClk) begin
  pipe_out_buf <= readback_buffer_q;
end

//
// INSTANTIATIONS
//
// FrontPanel module instantiations
wire [65*OK_SIZE-1:0]  okEHx;
okHost okHI(
  .okUH(okUH),
  .okHU(okHU),
  .okUHU(okUHU),
  .okAA(okAA),
  .okClk(okClk),
  .okHE(okHE),
  .okEH(okEH)
);
okWireOR # (.N(OK_SIZE)) wireOR (okEH, okEHx);


okWireIn wire10(
  .okHE(okHE),
  .ep_addr(8'h10),
  .ep_dataout(wirein)
);

wire flashprog_write;
wire [31:0] flashprog_data;
wire flashprog_ready;
okBTPipeIn programming_input_btpipe(
  .okHE ( okHE ),
  .okEH ( okEHx[(DEBUG_SIZE + 0)*65 +: 65] ),
  .ep_addr ( 8'h81 ),
  .ep_write ( flashprog_write ),
  .ep_dataout ( flashprog_data )
  .ep_blockstrobe ( )
  .ep_ready ( flashprog_ready )
);

okPipeIn pipe80(
  .okHE(okHE),
  .okEH(okEHx[(DEBUG_SIZE + 1)*65 +: 65]),
  .ep_addr(8'h80),
  .ep_write(instr_write),
  .ep_dataout(data_in)
);

okPipeOut pipeA0(
  .okHE(okHE),
  .okEH(okEHx[(DEBUG_SIZE + 2)*65 +: 65]),
  .ep_addr(8'hA0),
  .ep_read( readback_buffer_read ),
  .ep_datain( pipe_out_buf )
);


// High-Level Control Unit
/* control_unit control_unit_inst ( */
/*   .clk ( sys_clk ), */
/*   .reset ( reset ), */

/*   .instr_ready ( ~instr_empty ), */
/*   .instr_ack ( instr_ack ), */
/*   .instr_in ( instr ), */

/*   .readback_ready ( ~readback_buffer_full ), */
/*   .readback_write ( readback_buffer_write ), */
/*   .readback_data ( readback_buffer_data ), */

/*   .dac_request_write ( dac_request_write ), */
/*   .dac_address ( dac_address ), */
/*   .dac_data ( dac_data ), */

/*   .adc_request_write ( adc_request_write ), */
/*   .adc_request_read ( adc_request_read ), */
/*   .adc_address ( adc_address ), */
/*   .adc_data ( adc_data ), */
/*   .adc_data_readback ( adc_data_readback ), */

/*   .spi_busy ( spi_busy ), */
/*   .cu_state ( cu_state ), */
/*   .cu_instr ( cu_instr ) */
/* ); */

debug_unit #(.DEBUG_SIZE(DEBUG_SIZE)) debug_unit_inst (
  .sys_clk_ext ( sys_clk_ext ),
  .reset ( reset ),
  .sys_clk ( sys_clk ),
  .debug_enable ( debug_enable ),
  .single_step ( single_step_enable ),
  .clock_counter ( debug_clock_counter ),
  .debug_wireout ( debug_wireout),
  .okHE ( okHE ),
  .okEHx ( okEHx[65*DEBUG_SIZE:0] )
);

// 32 bit wide 1024 depth read-ahead fifo
fifo32_clock_crossing  instructionbuffer (
  .aclr ( reset ),
  .data ( data_in ),
  .rdclk ( sys_clk ),
  .rdreq ( instr_ack ),
  .wrclk ( okClk ),
  .wrreq ( instr_write ),
  .q ( instr ),
  .rdempty ( instr_empty ),
  .wrfull (  )
);

// 32 bit wide 1024 depth read-ahead fifo
fifo32_clock_crossing  readback_buffer (
  .aclr ( reset ),
  .data ( readback_buffer_data ),
  .rdclk ( okClk ),
  .rdreq ( readback_buffer_read ),
  .wrclk ( sys_clk ),
  .wrreq ( readback_buffer_write ),
  .q ( readback_buffer_q ),
  .rdempty (  ),
  .wrfull ( readback_buffer_full )
);

endmodule
