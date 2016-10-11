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

module debug_unit #(parameter DEBUG_SIZE=4)(
  input  wire                     phy_clk,
  input  wire                     reset,
  output wire                     sys_clk,
  input  wire                     debug_enable,
  input  wire                     single_step,
  output reg  [7:0]               clock_counter,
  input  wire [DEBUG_SIZE*16-1:0] debug_wireout,
  input  wire [112:0]             okHE,
  output wire [DEBUG_SIZE*65-1:0] okEHx
);


wire do_single_step;
reg single_step_p1;
reg single_step_p2;

assign do_single_step = single_step_p1 & ~single_step_p2;
assign sys_clk = (debug_enable) ? (do_single_step) : phy_clk;

always @( posedge phy_clk ) begin
  if ( reset ) begin
    single_step_p1 <= 1'b0;
    single_step_p2 <= 1'b0;
  end
  else begin
    single_step_p1 <= single_step;
    single_step_p2 <= single_step_p1;
  end
end


always @( posedge sys_clk ) begin
  if ( reset ) begin
    clock_counter = 8'h00;
  end
  else begin
    clock_counter = clock_counter + 1;
  end
end

// Debug Wireouts
generate
  genvar i;
  for (i=0; i<DEBUG_SIZE; i=i+1) begin: blk_name
    okWireOut debug_wire_inst(
      .okHE(okHE),
      .okEH(okEHx[i*65 +: 65]),
      .ep_addr(8'h20+i),
      .ep_datain(debug_wireout[16*(i+1)-1 -: 16])
    );
  end
endgenerate

endmodule
