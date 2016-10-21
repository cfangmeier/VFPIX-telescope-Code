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
  input  wire [16:0] address,
  output reg         busy,

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
wire [31:0] input_buffer_data_in;
wire [31:0] input_buffer_data_out;
reg  [31:0] output_buffer_data_in;
wire [31:0] output_buffer_data_out;

reg  input_buffer_rd_req;
wire input_buffer_wr_req;
wire input_buffer_empty;
wire output_buffer_rd_req;
reg  output_buffer_wr_req;
wire output_buffer_full;

wire [9:0] input_buffer_used_w;
wire [9:0] output_buffer_used_w;

wire [65*2-1:0] okEHx;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
reg [2:0] state;

//----------------------------------------------------------------------------
// State Machine
//----------------------------------------------------------------------------
always @(posedge clk ) begin
  if ( reset ) begin
    busy <= 0;
    state <= IDLE;
  end
  else begin
    input_buffer_rd_req <= 0;
    output_buffer_wr_req <= 0;
    case ( state )
      IDLE: begin
        if ( read_req ) begin
          busy <= 1;
          state <= RD_1;
        end
        else if ( write_req ) begin
          busy <= 1;
          state <= WR_1;
        end
      end
      RD_1: begin
        if ( !input_buffer_empty ) begin
          input_buffer_rd_req <= 1;
          state <= RD_2;
        end
      end
      RD_2: begin
        data_read <= input_buffer_data_out;
        busy <= 0;
        state <= IDLE;
      end
      WR_1: begin
        if ( !output_buffer_full ) begin
          output_buffer_wr_req <= 1;
          output_buffer_data_in <= data_write;
          busy <= 0;
          state <= IDLE;
        end
      end
    endcase
  end
end

okWireOR # (.N(2)) wireOR (okEH, okEHx);

// 32 bit wide 1024 depth fifo
fifo32_clk_crossing_with_usage  output_buffer (
  .aclr ( reset ),
  .rdclk ( okClk ),
  .rdreq ( output_buffer_rd_req ),
  .rdempty (  ),
  .rdusedw ( output_buffer_used_w ),
  .q ( output_buffer_data_out ),

  .wrclk ( clk ),
  .wrreq ( output_buffer_wr_req ),
  .wrfull ( output_buffer_full ),
  .wrusedw ( ),
  .data ( output_buffer_data_in )
);

okBTPipeOut pipeout_inst(
  .okHE ( okHE ),
  .okEH ( okEHx[64:0] ),
  .ep_addr ( 8'hB0 ),
  .ep_datain ( output_buffer_data_out ),
  .ep_read ( output_buffer_rd_req ),
  .ep_blockstrobe (  ),
  .ep_ready ( output_buffer_used_w >= RD_BLOCK_SIZE )
);

// 32 bit wide 1024 depth fifo
fifo32_clk_crossing_with_usage  input_buffer (
  .aclr ( reset ),
  .rdclk ( clk ),
  .rdreq ( input_buffer_rd_req ),
  .rdempty ( input_buffer_empty ),
  .rdusedw ( ),
  .q ( input_buffer_data_out ),

  .wrclk ( okClk ),
  .wrreq (  ),
  .wrfull (  ),
  .wrusedw ( input_buffer_used_w ),
  .data ( input_buffer_data_in )
);

okBTPipeIn pipein_inst(
  .okHE ( okHE ),
  .okEH ( okEHx[129:65] ),
  .ep_addr (8'hB1 ),
  .ep_dataout ( input_buffer_data_in ),
  .ep_write ( input_buffer_wr_req ),
  .ep_blockstrobe (  ),
  .ep_ready ( input_buffer_used_w >= WR_BLOCK_SIZE )
);

endmodule
