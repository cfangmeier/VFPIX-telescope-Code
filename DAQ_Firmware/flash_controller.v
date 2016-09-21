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
// Title       : flash_controller
// Author      : Caleb Fangmeier
// Description : This is the controller for the SPI flash memory that holds
// the program. The hardware flash memory is a Numonyx N25Q128A11B1240E or
// equivalent.
//
// On the user side, be sure to use no more than 512-word size blocks
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module flash_controller(
  input  wire        clk,
  input  wire        reset,
  //--------------------------------------------------------------------------
  //-----------CONTROL INTERFACE----------------------------------------------
  //--------------------------------------------------------------------------
  input  wire        read_req,
  input  wire [23:0] addr,
  output wire [31:0] data_o,
  output wire        data_valid,
  //--------------------------------------------------------------------------
  //-----------PROGRAMMING INTERFACE------------------------------------------
  //--------------------------------------------------------------------------
  input  wire         prog_clk,
  input  wire [31:0]  prog_data,
  input  wire [31:0]  prog_write,
  output wire [31:0]  prog_ready,

  //--------------------------------------------------------------------------
  //-----------HARDWARE INTERFACE---------------------------------------------
  //--------------------------------------------------------------------------
  output wire        flash_c,
  output wire        flash_sb,
  inout  wire [3:0]  flash_dq
);

wire [2:0] action = {read_req, writes_remaining == 0, data_available};
parameter PROGRAM_START = 3'bx11;
parameter READ_START = 3'b110;
parameter READ_START = 3'b110;

wire [9:0] words_available;
reg [15:0] writes_remaining;
always @(posedge clk or posedge reset) begin
  if ( reset ) begin
    writes_remaining <= 0;

  end
  else begin
    case ( action ) begin
      3'b000: begin

      end
      3'b001: begin

      end


    end  // end action case
  end

end

// 32 bit wide 1024 depth read-ahead fifo
// This fifo buffers the data coming from the BTPipeIn
fifo32_clock_crossing_with_usage  programming_buffer (
  .aclr ( reset ),
  .data ( prog_data ),
  .rdclk ( sys_clk ),
  .rdreq ( instr_ack ),
  .wrclk ( prog_clk ),
  .wrreq ( prog_write ),
  .q ( data ),
  .rdempty ( ~data_available ),
  .wrfull (  ),
  .wrusedw ( {~ready, 9'bx} ),
  .rdusedw ( words_available )
);
