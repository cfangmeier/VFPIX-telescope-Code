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
// Title       : internal_registers
// Author      : Caleb Fangmeier
// Created     : Aug. 24, 2016
// Description : This is the module to manage the internal registers of the
//               daq firmware.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module internal_registers(
  input  wire        clk,
  inout  wire [15:0] data,
  input  wire [4:0]  addr,
  input  wire        write,
  input  wire        reset
  );

`include "register_space.vh";

reg [15:0] r0;
reg [15:0] r1;
reg [15:0] r2;
reg [15:0] r3;
reg [15:0] r4;
reg [15:0] r5;
reg [15:0] r6;
reg [15:0] r7;
reg [15:0] r8;
reg [15:0] r9;
reg [15:0] ra;
reg [15:0] rb;
reg [15:0] rc;
reg [15:0] rd;
reg [15:0] re;
reg [15:0] rf;

always @(negedge clk) begin
  if ( reset ) begin
    r0 <= 16'h0000;
    r1 <= 16'h0000;
    r2 <= 16'h0000;
    r3 <= 16'h0000;
    r4 <= 16'h0000;
    r5 <= 16'h0000;
    r6 <= 16'h0000;
    r7 <= 16'h0000;
    r8 <= 16'h0000;
    r9 <= 16'h0000;
    ra <= 16'h0000;
    rb <= 16'h0000;
    rc <= 16'h0000;
    rd <= 16'h0000;
    re <= 16'h0000;
    rf <= 16'h0000;
  end
  else if (write) begin
    case (addr)
      R0: r0 <= data;
      R1: r1 <= data;
      R2: r2 <= data;
      R3: r3 <= data;
      R4: r4 <= data;
      R5: r5 <= data;
      R6: r6 <= data;
      R7: r7 <= data;
      R8: r8 <= data;
      R9: r9 <= data;
      RA: ra <= data;
      RB: rb <= data;
      RC: rc <= data;
      RD: rd <= data;
      RE: re <= data;
      RF: rf <= data;
    endcase
  end

end


always @(addr or reset or write) begin
  if ( reset | write ) begin
    data = 16'bzzzzzzzzzzzzzzzz;
  end
  else begin
    case (addr)
      R0: data = r0;
      R1: data = r1;
      R2: data = r2;
      R3: data = r3;
      R4: data = r4;
      R5: data = r5;
      R6: data = r6;
      R7: data = r7;
      R8: data = r8;
      R9: data = r9;
      RA: data = ra;
      RB: data = rb;
      RC: data = rc;
      RD: data = rd;
      RE: data = re;
      RF: data = rf;
      default: data = 16'h0000;
    endcase
  end
end
