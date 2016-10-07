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
// Description : This is the interface HDL for the FPGA Flash on the ZEM.
// One interacts with this interface by first pushing all bytes to be written
// into the write buffer. This includes all bytes to be written after the
// instruction ( Address *and* Data). This finished, assert execute
// during the same clock cycle as presenting the instruction and the number
// of bytes to be read. If the instruction has any data read back, it will
// be placed into the read buffer as it becomes available. After the
// operation is complete, the busy signal will go low.
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module flash_interface(
  input  wire        clk,  // 150 MHz
  input  wire        reset,

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------

  input  wire [7:0]  instruction,
  input  wire        execute,
  input  wire [8:0]  bytes_to_read,
  output reg         busy,

  input  wire [7:0]   write_buffer_data,
  input  wire         write_buffer_write,
  output wire         write_buffer_full,

  output wire [7:0]   read_buffer_q,
  output wire         read_buffer_empty,
  input  wire         read_buffer_read,

  //--------------------------------------------------------------------------
  //-----------HARDWARE INTERFACE---------------------------------------------
  //--------------------------------------------------------------------------
  output wire        flash_c,
  output reg         flash_sb,
  inout  wire [3:0]  flash_dq
);

//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
localparam IDLE         = 3'd0,
           DATA_WRITE_0 = 3'd1,
           DATA_WRITE   = 3'd2,
           DATA_READ_0  = 3'd3,
           DATA_READ    = 3'd4;


localparam CLK_DIV = 2;
//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire update_in;  // Read-in on positive edge of clock
wire update_out; // Write-out on negative edge of clk
wire sdi;

wire       write_buffer_empty;
wire [7:0] write_buffer_q;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
reg [CLK_DIV:0] clk_div1;
reg [CLK_DIV:0] clk_div2;

reg [7:0] input_shifter;
reg [7:0] output_shifter;

reg [2:0] bit_counter;
reg [8:0] bytes_read;
reg [8:0] bytes_to_read_int;

reg        write_buffer_read;

reg        read_buffer_write;
reg [7:0]  read_buffer_data;

reg [2:0] state;
//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------
assign update_in  =  clk_div1[CLK_DIV] & ~clk_div2[CLK_DIV];
assign update_out = ~clk_div1[CLK_DIV] &  clk_div2[CLK_DIV];

assign flash_c = clk_div2[CLK_DIV] & busy;
assign flash_dq[0] = output_shifter[7];
assign sdi = flash_dq[1];
assign flash_dq[2] = 1;
assign flash_dq[3] = 1;
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
  write_buffer_read <= 0;
  read_buffer_write <= 0;
  if ( reset ) begin
    flash_sb <= 1;
    state <= IDLE;
  end
  else begin
    case ( state )
      IDLE: begin
        if ( execute ) begin
          state <= DATA_WRITE_0;
          output_shifter <= instruction;
          bytes_to_read_int <= bytes_to_read;
          busy <= 1;
        end
      end
      DATA_WRITE_0: begin
        if ( update_out ) begin
          state <= DATA_WRITE;
          flash_sb <= 0;
          bit_counter <= 0;
        end
      end
      DATA_WRITE: begin
        if ( update_out ) begin
          bit_counter <= bit_counter + 1;
          output_shifter <= {output_shifter[6:0], 1'b0};
          if ( bit_counter == 3'd7 ) begin
            if ( !write_buffer_empty ) begin
              output_shifter <= write_buffer_q;
              write_buffer_read <= 1;
            end
            else if ( bytes_to_read_int > 0 ) begin
              state <= DATA_READ;
              output_shifter <= 0;
              bytes_read <= 0;
            end
            else begin
              state <= IDLE;
              flash_sb <= 1;
              busy <= 0;
            end
          end
        end
      end
      DATA_READ_0: begin
        if ( update_in ) begin
          state <= DATA_READ;
          bytes_read <= 0;
        end
      end
      DATA_READ: begin
        if ( update_in ) begin
          bit_counter <= bit_counter + 1;
          input_shifter <= {input_shifter[6:0], sdi};
          if ( bit_counter == 3'd7 ) begin
            read_buffer_data <= {input_shifter[6:0], sdi};
            read_buffer_write <= 1;
            bytes_read <= bytes_read + 1;
            if ( (bytes_read+1) == bytes_to_read_int ) begin
              state <= IDLE;
              flash_sb <= 1;
              busy <= 0;
            end
          end
        end
      end
    endcase
  end
end


fifo8_256 write_buffer (
  .clock ( clk ),
  .sclr ( reset ),
  .data ( write_buffer_data ),
  .wrreq ( write_buffer_write ),
  .full ( write_buffer_full ),
  .rdreq ( write_buffer_read ),
  .empty ( write_buffer_empty ),
  .q ( write_buffer_q )
);

fifo8_256 read_buffer (
  .clock ( clk ),
  .sclr ( reset ),
  .data ( read_buffer_data ),
  .wrreq ( read_buffer_write ),
  .full (  ),
  .rdreq ( read_buffer_read ),
  .empty ( read_buffer_empty ),
  .q ( read_buffer_q )
);

endmodule
