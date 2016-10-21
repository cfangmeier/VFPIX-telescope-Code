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
// Title       : debug_unit
// Author      : Caleb Fangmeier
// Description : This is a simple debugger to allow single stepping through
//               the execution of the firmware.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module debug_unit (
  input  wire                     clk,
  input  wire                     reset,
  input  wire [31:0]              debug_wireout,
  input  wire                     okClk,
  input  wire [112:0]             okHE,
  output wire [64:0]              okEH
);

wire        output_buffer_rd_req;
wire [31:0] output_buffer_data_out;
wire        output_buffer_full;
wire [9:0]  output_buffer_used_w;

fifo32_clk_crossing_with_usage  output_buffer (
  .aclr ( reset ),
  .data ( debug_wireout ),
  .rdclk ( okClk ),
  .rdreq ( output_buffer_rd_req ),
  .wrclk ( clk ),
  .wrreq ( ~output_buffer_full ),
  .q ( output_buffer_data_out ),
  .rdempty (  ),
  .rdusedw ( output_buffer_used_w ),
  .wrusedw (  ),
  .wrfull ( output_buffer_full )
);
  /* .ep_ready ( output_buffer_used_w >= 512 ) */

okBTPipeOut pipeout_inst(
  .okHE ( okHE ),
  .okEH ( okEH ),
  .ep_addr ( 8'hB2 ),
  .ep_datain ( output_buffer_data_out ),
  .ep_read ( output_buffer_rd_req ),
  .ep_blockstrobe (  ),
  .ep_ready ( 1'b1 )
);


endmodule
