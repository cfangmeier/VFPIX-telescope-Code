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

module debug_unit #(parameter SIZE=1)(
  input  wire               clk,
  input  wire               reset,
  input  wire [32*SIZE-1:0] debug_wireout,
  input  wire               okClk,
  input  wire [112:0]       okHE,
  output wire [64:0]        okEH
);

wire [SIZE-1:0]    output_buffer_rdreq;
wire [31:0]        output_buffer_q       [SIZE-1:0];
wire [12:0]        output_buffer_wrusedw [SIZE-1:0];
wire [12:0]        output_buffer_rdusedw [SIZE-1:0];

reg  [10:0]        write_count;
reg                output_buffer_wrreq;
reg  [32*SIZE-1:0] output_buffer_data;

wire [SIZE-1:0]    buffer_space_ok;
wire [SIZE*65-1:0] okEHx;

generate
  genvar i;
  for ( i=0; i<SIZE; i=i+1 ) begin: my_loop_1
    assign buffer_space_ok[i] = (output_buffer_wrusedw[i] <= 13'd3072);
  end
endgenerate


integer j;
always @( posedge clk ) begin
  output_buffer_wrreq <= 0;
  if ( reset ) begin
    write_count <= 0;
  end
  else begin
    if ( write_count == 0 ) begin
      if ( & buffer_space_ok ) begin
        write_count <= 11'd1024;
      end
    end
    else if ( write_count == 1 ) begin
      for ( j=0; j<SIZE; j=j+1 ) begin: my_loop_3
        output_buffer_data[32*j +: 32] <= 32'hFFFF_FFFF;
      end
      output_buffer_wrreq <= 1;
      write_count <= write_count - 11'd1;
    end
    else begin
      output_buffer_data <= debug_wireout;
      output_buffer_wrreq <= 1;
      write_count <= write_count - 11'd1;
    end
  end
end

okWireOR #( .N(SIZE) ) wireOR (
  .okEH ( okEH ),
  .okEHx ( okEHx )
);

generate
  for ( i=0; i<SIZE; i=i+1 ) begin: my_loop_2
    fifo32_clk_crossing_with_usage  output_buffer (
      .wrclk ( clk ),
      .rdclk ( okClk ),
      .aclr ( reset ),
      .data ( output_buffer_data[32*i +: 32] ),
      .q ( output_buffer_q[i] ),
      .wrreq ( output_buffer_wrreq ),
      .rdreq ( output_buffer_rdreq[i] ),
      .wrusedw ( output_buffer_wrusedw[i] ),
      .rdusedw ( output_buffer_rdusedw[i] )
    );

    okBTPipeOut pipeout_inst(
      .okHE ( okHE ),
      .okEH ( okEHx[65*i +: 65] ),
      .ep_addr ( 8'hB0+i ),
      .ep_datain ( output_buffer_q[i] ),
      .ep_read ( output_buffer_rdreq[i] ),
      .ep_blockstrobe (  ),
      .ep_ready ( output_buffer_rdusedw[i] >= 13'd1024 )
    );
  end
endgenerate

endmodule
