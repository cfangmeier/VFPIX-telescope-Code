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
// Title       : okWireIn_sync
// Author      : Caleb Fangmeier
// Description : This is a simple wrapper of the okWireIn that syncronizes
// the signals with another clock by means of a shallow fifo buffer.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module okWireIn_sync (
  input  wire                     clk,
  input  wire                     okClk,
  input  wire [112:0]             okHE,
  input  wire [7:0]               ep_addr,
  output reg  [31:0]              ep_dataout
);

wire [31:0] control_bus;
wire [31:0] q_buff;
wire        rdempty;

reg         rdreq;

always @( posedge clk ) begin
  if ( rdreq ) begin
    ep_dataout <= q_buff;
  end
  rdreq <= ~rdempty;
end

fifo32_shallow fifo32_shallow_inst (
  .data ( control_bus ),
  .rdclk ( clk ),
  .rdreq ( rdreq ),
  .wrclk ( okClk ),
  .wrreq ( 1'b1 ),
  .q ( q_buff ),
  .rdempty ( rdempty ),
  .wrfull (  )
);


okWireIn control_wires(
  .okHE(okHE),
  .ep_addr(ep_addr),
  .ep_dataout(control_bus)
);
endmodule
