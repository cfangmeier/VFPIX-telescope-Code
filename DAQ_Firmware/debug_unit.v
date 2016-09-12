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

module debug_unit(
  input  wire      sys_clk_ext,
  input  wire      reset,
  output wire      sys_clk,
  input  wire      debug_enable,
  input  wire      single_step,
  output reg [7:0] clock_counter
);

wire do_single_step;
reg single_step_p1;
reg single_step_p2;

assign do_single_step = single_step_p1 & ~single_step_p2;
/* assign sys_clk = sys_clk_ext & ( debug_enable == do_single_step ); */
assign sys_clk = (debug_enable) ? (do_single_step) : sys_clk_ext;

always @(posedge sys_clk_ext or posedge reset) begin
  if ( reset ) begin
    single_step_p1 <= 1'b0;
    single_step_p2 <= 1'b0;
  end
  else begin
    single_step_p1 <= single_step;
    single_step_p2 <= single_step_p1;
  end
end


always @(posedge sys_clk or posedge reset) begin
  if ( reset ) begin
    clock_counter = 8'h00;
  end
  else begin
    clock_counter = clock_counter + 1;
  end
end

/* always @(sys_clk_ext or do_single_step or debug_enable) begin */
/*   if (~debug_enable | do_single_step) begin */
/*     sys_clk = sys_clk_ext; */
/*   end */
/*   else begin */
/*     sys_clk = 1'b0; */
/*   end */
/* end */

endmodule
