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
// Title       : spi_interface
// Author      : Caleb Fangmeier
// Description : Implementation of a generic SPI interface.
//               Interfacing HDL must supply the exact data to be written
//               over the interface (including write/read bit and address)
//               properly formatted for the device being spoken to.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module spi_interface (
  input  wire         clk,  // 150 MHz
  input  wire         reset,

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire [31:0]  data_out,
  output reg  [31:0]  data_in,
  input  wire [7:0]   read_bits,
  input  wire [7:0]   write_bits,
  input  wire         request_action,
  output wire         busy,

  //--------------------------------------------------------------------------
  //-----------HARDWARE INTERFACE---------------------------------------------
  //--------------------------------------------------------------------------
  output wire         sclk,
  inout  wire         sdio,
  output reg          cs
);

//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
localparam IDLE         = 3'd0,
           DATA_WRITE_0 = 3'd1,
           DATA_WRITE   = 3'd2,
           DATA_READ_0  = 3'd3,
           DATA_READ    = 3'd4;

localparam CLK_DIV = 3;
//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire update_in;  // Read-in on positive edge of clock
wire update_out; // Write-out on negative edge of clk
wire sdo;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
reg [CLK_DIV:0] clk_div1;
reg [CLK_DIV:0] clk_div2;

reg [31:0] input_shifter;
reg [31:0] output_shifter;

reg [7:0]   read_bits_reg;
reg [7:0]   write_bits_reg;

reg [8:0] bit_counter;
reg is_writing;
reg busy_int;

reg [2:0] state;

//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------
assign update_in  =  clk_div1[CLK_DIV] & ~clk_div2[CLK_DIV]; // posedge serial clock
assign update_out = ~clk_div1[CLK_DIV] &  clk_div2[CLK_DIV]; // negedge serial clock

assign sdo = output_shifter[31];

assign sclk = clk_div2[CLK_DIV] & cs;
assign sdio = is_writing ? sdo : 1'bz;
assign busy = busy_int | request_action;

//----------------------------------------------------------------------------
// Clock Division
//----------------------------------------------------------------------------
always @( posedge clk ) begin
  if ( reset ) begin
    clk_div2 <= 0;
    clk_div1 <= 0;
  end
  else begin
    clk_div2 <= clk_div1;
    clk_div1 <= clk_div1 + 1;
  end
end

//----------------------------------------------------------------------------
// State Machine
//----------------------------------------------------------------------------
always @( posedge clk ) begin
  if ( reset ) begin
    state <= IDLE;
    data_in <= 32'd0;
    busy_int <= 1;
    is_writing <= 0;
    cs <= 0;
  end
  else begin
    case ( state )
      IDLE: begin
        data_in <= 32'd0;
        if ( request_action ) begin
          state <= DATA_WRITE_0;
          busy_int <= 1;
          output_shifter <= data_out;
          input_shifter <= 32'd0;
          write_bits_reg <= write_bits;
          read_bits_reg <= read_bits;
        end
        else begin
          busy_int <= 1'd0;
        end
      end
      DATA_WRITE_0: begin
        if ( update_out ) begin
          state <= DATA_WRITE;
          is_writing <= 1'd1;
          cs <= 1'd1;
          bit_counter <= 9'd1;
        end
      end
      DATA_WRITE: begin
        if ( update_out ) begin
          if ( bit_counter == write_bits_reg ) begin
            state <= DATA_READ;
            bit_counter <= 9'd0;
            is_writing <= 1'd0;
          end
          else begin
            bit_counter <= bit_counter + 9'd1;
            output_shifter <= {output_shifter[30:0], 1'd0};
          end
        end
      end
      DATA_READ: begin
        if ( update_in ) begin
          if ( bit_counter == read_bits_reg ) begin
            state <= IDLE;
            busy_int <= 1'd0;
            cs <= 1'd0;
            data_in <= input_shifter;
          end
          else begin
            bit_counter <= bit_counter + 9'd1;
            input_shifter <= {input_shifter[30:0], sdio};
          end
        end
      end
    endcase
  end
end

endmodule
