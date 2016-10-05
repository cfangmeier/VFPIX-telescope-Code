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
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.  -------------------------------------------------------------------------
// Title       : memory
// Author      : Caleb Fangmeier
// Description : Memory interface
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module memory(
  input  wire pll_ref_clk,
  output wire phy_clk,
  input  wire reset,

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
  //---------------------------HW INTERFACE-----------------------------------
  //--------------------------------------------------------------------------
  //===RAM===
  output wire [ 12: 0]       mem_addr,
  output wire [  2: 0]       mem_ba,
  output wire                mem_cas_n,
  output wire [  0: 0]       mem_cke,
  inout  wire [  0: 0]       mem_clk,
  inout  wire [  0: 0]       mem_clk_n,
  output wire [  0: 0]       mem_cs_n,
  output wire [  1: 0]       mem_dm,
  inout  wire [ 15: 0]       mem_dq,
  inout  wire [  1: 0]       mem_dqs,
  output wire [  0: 0]       mem_odt,
  output wire                mem_ras_n,
  output wire                mem_we_n
  );

//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
localparam IDLE    = 3'd0,
           READ_1  = 3'd1,
           READ_2  = 3'd2,
           WRITE_1 = 3'd3,
           WRITE_2 = 3'd4;

//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire        local_ready;
wire [31:0] local_rdata;
wire        local_rdata_valid;
wire        local_init_done;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------

reg  [24:0] local_address;
reg         local_write_req;
reg         local_read_req;
reg         local_burstbegin;
reg  [31:0] local_wdata;

reg [2:0] state;


//----------------------------------------------------------------------------
// State Machine
//----------------------------------------------------------------------------

always @( posedge phy_clk) begin
  local_write_req <= 0;
  local_read_req <= 0;
  local_burstbegin <= 0;
  data_read <= 32'h0;
  if ( reset ) begin
    state <= IDLE;
  end
  else begin
    case ( state )
      IDLE: begin
        if ( write_req ) begin
          state <= WRITE_1;
          local_wdata <= data_write;
          local_address <= addr[24:0];
          busy <= 1;
        end
        else if ( read_req ) begin
          state <= READ_1;
          local_address <= addr[24:0];
          busy <= 1;
        end
      end
      WRITE_1: begin
        if ( local_init_done & local_ready ) begin
          state <= WRITE_2;
          local_write_req <= 1;
          local_burstbegin <= 1;
        end
      end
      WRITE_2: begin
        if ( local_ready ) begin
          state <= IDLE;
          busy <= 0;
        end
      end
      READ_1: begin
        if ( local_init_done & local_ready ) begin
          state <= READ_2;
          local_read_req <= 1;
          local_burstbegin <= 1;
        end
      end
      READ_2: begin
        if ( local_ready & local_rdata_valid ) begin
          state <= IDLE;
          data_read <= local_rdata;
          busy <= 0;
        end
      end
    endcase
  end
end


//----------------------------------------------------------------------------
// Instantiations
//----------------------------------------------------------------------------




ram_controller ram_controller_inst(
  .pll_ref_clk ( pll_ref_clk ),
  .phy_clk ( phy_clk ),
  .global_reset_n ( ~reset ),
  .soft_reset_n (  ),
  .reset_phy_clk_n (  ),

  .local_address ( addr[24:0] ),
  .local_write_req ( write_req ),
  .local_read_req ( read_req ),
  .local_burstbegin ( local_burstbegin ),
  .local_wdata ( local_wdata ),
  .local_be ( 4'hF ),
  .local_size ( 3'd1 ),
  .local_ready ( local_ready ),
  .local_rdata ( local_rdata ),
  .local_rdata_valid ( local_rdata_valid ),
  .local_refresh_ack ( ),
  .local_init_done ( local_init_done ),


  .mem_addr ( mem_addr ),
  .mem_ba ( mem_ba ),
  .mem_cas_n ( mem_cas_n ),
  .mem_cke ( mem_cke ),
  .mem_clk ( mem_clk ),
  .mem_clk_n ( mem_clk_n ),
  .mem_cs_n ( mem_cs_n ),
  .mem_dm ( mem_dm ),
  .mem_dq ( mem_dq ),
  .mem_dqs ( mem_dqs ),
  .mem_odt ( mem_odt ),
  .mem_ras_n ( mem_ras_n ),
  .mem_we_n ( mem_we_n ),

  .aux_full_rate_clk ( ),
  .aux_half_rate_clk ( ),
  .reset_request_n (  )
);
endmodule
