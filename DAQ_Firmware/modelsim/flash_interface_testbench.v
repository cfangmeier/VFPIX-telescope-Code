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
// Title       : flash_interface_testbench
// Author      : Caleb Fangmeier
// Description : Testbench for the flash interface
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps


module flash_interface_testbench (
    // no I/O for the testbench
);

parameter CLK_PERIOD = 10;
integer i;

reg clk;
reg reset;

reg  [7:0] instruction;
reg        execute;
reg  [7:0] bytes_to_read;
reg  [7:0] write_buffer_data;
reg        write_buffer_write;
reg        read_buffer_read;

reg  [7:0] instruction_shifter;
reg  [7:0] data_shifter;
reg  [15:0] out_shifter;
reg        word_complete;

wire       busy;
wire [7:0] read_buffer_q;
wire       read_buffer_empty;

wire       flash_c;
wire       flash_sb;
wire [3:0] flash_dq;

wire sout;
reg sin;

assign sout = flash_dq[0];
assign flash_dq[1] = sin;


initial clk = 1'b0;
always #( CLK_PERIOD/2.0 )
  clk = ~clk;

initial i = 0;

initial reset = 1'b1;
always @( posedge clk ) begin
  i = i + 1;
  execute <= 0;
  write_buffer_write <= 0;
  bytes_to_read <= 0;
  bytes_to_read <= 0;
  if ( i == 2 )
    reset <= 1'b0;

  if ( i == 4 ) begin
    write_buffer_data <= 8'hFF;
    write_buffer_write <= 1;
  end

  if ( i == 5 ) begin
    write_buffer_data <= 8'h22;
    write_buffer_write <= 1;
  end

  if ( i == 6 ) begin
    instruction <= 8'hAA;
    execute <= 1;
    bytes_to_read <= 2;
  end
  if ( ~read_buffer_empty ) begin
    read_buffer_read <= 1;
  end
end

integer clk_cnt;
integer words_received;

always @(posedge flash_c or negedge flash_c) begin
  if ( flash_sb ) begin
    instruction_shifter <= 0;
    data_shifter <= 0;
    clk_cnt <= 0;
    word_complete <= 0;
    words_received <= 0;
    out_shifter <= 16'hBEEF;
  end
  else begin
    if ( flash_c ) begin
      clk_cnt <= clk_cnt + 1;
      if ( clk_cnt < 8 ) begin
        instruction_shifter <= {instruction_shifter[6:0], sout};
      end
      else begin
        data_shifter <= {data_shifter[6:0], sout};
        if ( ((clk_cnt+1) % 8) == 0 ) begin
          word_complete <= 1;
          words_received <= words_received + 1;
        end
        else begin
          word_complete <= 0;
        end
      end
    end
    else begin
      if ( words_received >= 2 ) begin
        sin <= out_shifter[15];
        out_shifter <= {out_shifter[14:0], out_shifter[15]};
      end
    end
  end
end

flash_interface flash_interface_inst(
  .clk ( clk ),
  .reset ( reset ),

  .instruction ( instruction ),
  .execute ( execute ),
  .bytes_to_read ( bytes_to_read ),
  .busy ( busy ),

  .write_buffer_data ( write_buffer_data ),
  .write_buffer_write ( write_buffer_write ),

  .read_buffer_q ( read_buffer_q ),
  .read_buffer_empty ( read_buffer_empty ),
  .read_buffer_read ( read_buffer_read ),

  .flash_c ( flash_c ),
  .flash_sb ( flash_sb ),
  .flash_dq ( flash_dq )
);


endmodule
