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
// Title       : flash_interface
// Author      : Caleb Fangmeier
// Description : Flash Interface.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module flash_interface(
  input  wire        clk,  // 150 MHz
  input  wire        reset,

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire        write_req,
  input  wire        read_req,
  input  wire [31:0] data_write,
  output reg  [31:0] data_read,
  input  wire [25:0] addr,
  output reg         busy,

  //--------------------------------------------------------------------------
  //-----------HARDWARE INTERFACE---------------------------------------------
  //--------------------------------------------------------------------------
  output wire        flash_c,
  output wire        flash_sb,
  inout  wire [3:0]  flash_dq
);

//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
localparam IDLE = 3'd0,
//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------


/* on_chip_rom  on_chip_rom_inst ( */
/*   .address ( memory_addr ), */
/*   .clock ( clock_sig ), */
/*   .q ( memory_data_read ) */
/* ); */
