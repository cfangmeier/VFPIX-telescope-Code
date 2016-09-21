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
  input  wire        clk,
  input  wire        reset,

  input  wire [7:0]  instruction,

  //--------------------------------------------------------------------------
  //-----------HARDWARE INTERFACE---------------------------------------------
  //--------------------------------------------------------------------------
  output wire        flash_c,
  output wire        flash_sb,
  inout  wire [3:0]  flash_dq
);
