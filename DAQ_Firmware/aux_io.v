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
// Title       : aux_io
// Author      : Caleb Fangmeier
// Description : Auxillary data input/output for bi-directional communication
// between CalPC and the Host Computer.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module aux_io(
  input  wire        clk,
  input  wire        reset,

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire        write_req,
  input  wire        read_req,
  input  wire [31:0] data_write,
  output reg  [31:0] data_read,
  input  wire [25:0] address,
  output wire        busy,

  //--------------------------------------------------------------------------
  //---------------------------FP INTERFACE-----------------------------------
  //--------------------------------------------------------------------------
  input  wire         okClk,
  input  wire [112:0] okHE,
  output wire [64:0]  okEH
);


//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
localparam IDLE = 3'd0,
           RD_1 = 3'd1,
           RD_2 = 3'd2,
           WR_1 = 3'd3;

localparam WR_BLOCK_SIZE = 10'd512,
           RD_BLOCK_SIZE = 10'd4;

//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire [31:0] input_buffer_data;
wire [31:0] input_buffer_q;
reg  [31:0] output_buffer_data;
wire [31:0] output_buffer_q;

reg  input_buffer_rdreq;
wire input_buffer_wrreq;
wire input_buffer_empty;
wire output_buffer_rdreq;
reg  output_buffer_wrreq;
wire output_buffer_full;

wire [12:0] input_buffer_rdusedw;
wire [12:0] input_buffer_wrusedw;
wire [12:0] output_buffer_rdusedw;
wire [12:0] output_buffer_wrusedw;

wire [65*2-1:0] okEHx;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
reg [2:0] state;
reg       busy_int;

reg [31:0] data_write_buffer;

assign input_buffer_empty = (input_buffer_rdusedw == 0);
assign output_buffer_full = output_buffer_wrusedw[12];
assign busy = busy_int | write_req | read_req;

//----------------------------------------------------------------------------
// State Machine
//----------------------------------------------------------------------------
always @(posedge clk ) begin
  if ( reset ) begin
    busy_int <= 1;
    data_write_buffer <= 32'd0;
    state <= IDLE;
  end
  else begin
    input_buffer_rdreq <= 0;
    output_buffer_wrreq <= 0;
    case ( state )
      IDLE: begin
        data_read <= 32'd0;
        if ( read_req ) begin
          busy_int <= 1;
          state <= RD_1;
        end
        else if ( write_req ) begin
          busy_int <= 1;
          data_write_buffer <= data_write;
          state <= WR_1;
        end
        else begin
          busy_int <= 0;
        end
      end
      RD_1: begin
        if ( !input_buffer_empty ) begin
          input_buffer_rdreq <= 1;
          state <= RD_2;
        end
      end
      RD_2: begin
        data_read <= input_buffer_q;
        busy_int <= 0;
        state <= IDLE;
      end
      WR_1: begin
        if ( !output_buffer_full ) begin
          output_buffer_wrreq <= 1;
          output_buffer_data <= data_write_buffer;
          /* output_buffer_data <= {19'd0, output_buffer_wrusedw}; */
          busy_int <= 0;
          state <= IDLE;
        end
      end
    endcase
  end
end

okWireOR # (.N(2)) wireOR (okEH, okEHx);

// 32 bit wide 1024 depth fifo
fifo32_clk_crossing_with_usage  output_buffer (
  .wrclk ( clk ),
  .rdclk ( okClk ),
  .aclr ( reset ),
  .data ( output_buffer_data),
  .q ( output_buffer_q ),
  .wrreq ( output_buffer_wrreq ),
  .rdreq ( output_buffer_rdreq ),
  .rdusedw ( output_buffer_rdusedw ),
  .wrusedw ( output_buffer_wrusedw )
);

okBTPipeOut pipeout_inst(
  .okHE ( okHE ),
  .okEH ( okEHx[64:0] ),
  .ep_addr ( 8'hA0 ),
  /* .ep_datain ( {19'd0, output_buffer_rdusedw} ), */
  .ep_datain ( output_buffer_q ),
  .ep_read ( output_buffer_rdreq ),
  .ep_blockstrobe (  ),
  .ep_ready ( output_buffer_rdusedw >= RD_BLOCK_SIZE )
);

// 32 bit wide 1024 depth fifo
fifo32_clk_crossing_with_usage  input_buffer (
  .wrclk ( okClk ),
  .rdclk ( clk ),
  .aclr ( reset ),
  .data ( input_buffer_data),
  .q ( input_buffer_q ),
  .wrreq ( input_buffer_wrreq ),
  .rdreq ( input_buffer_rdreq ),
  .wrusedw ( input_buffer_wrusedw ),
  .rdusedw ( input_buffer_rdusedw )
);

okBTPipeIn pipein_inst(
  .okHE ( okHE ),
  .okEH ( okEHx[129:65] ),
  .ep_addr (8'h80 ),
  .ep_dataout ( input_buffer_data),
  .ep_write ( input_buffer_wrreq ),
  .ep_blockstrobe (  ),
  .ep_ready ( input_buffer_wrusedw >= WR_BLOCK_SIZE )
);

endmodule
