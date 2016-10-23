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

wire        output_buffer_rdreq;
wire [31:0] output_buffer_q;
wire [12:0] output_buffer_wrusedw;
wire [12:0] output_buffer_rdusedw;

wire [12:0] output_buffer_rdavailw;

reg  [9:0]  write_count;
reg         output_buffer_wrreq;
reg  [31:0] output_buffer_data;

always @( posedge clk ) begin
  output_buffer_wrreq <= 0;
  if ( reset ) begin
    write_count <= 0;
  end
  else if ( write_count == 0 ) begin
    if ( output_buffer_wrusedw <= (4096-512)) begin
      write_count <= 512;
    end
  end
  else if ( write_count == 1 ) begin
    output_buffer_data <= 32'hFFFF_FFFF;
    output_buffer_wrreq <= 1;
    write_count <= write_count - 1;
  end
  else begin
    output_buffer_data <= debug_wireout;
    output_buffer_wrreq <= 1;
    write_count <= write_count - 1;
  end
end

fifo32_clk_crossing_with_usage  output_buffer (
  .wrclk ( clk ),
  .rdclk ( okClk ),
  .aclr ( reset ),
  .data ( output_buffer_data ),
  .q ( output_buffer_q ),
  .wrreq ( output_buffer_wrreq ),
  .rdreq ( output_buffer_rdreq ),
  .wrusedw ( output_buffer_wrusedw ),
  .rdusedw ( output_buffer_rdusedw ),
);

okBTPipeOut pipeout_inst(
  .okHE ( okHE ),
  .okEH ( okEH ),
  .ep_addr ( 8'hB2 ),
  .ep_datain ( output_buffer_q ),
  .ep_read ( output_buffer_rdreq ),
  .ep_blockstrobe (  ),
  .ep_ready ( | output_buffer_rdusedw[12:9] )
);


endmodule
