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
// Title       : memory_testbench
// Author      : Caleb Fangmeier
// Description : Testbench for the memory (RAM+FLASH) interface
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps


module memory_testbench (
    // no I/O for the testbench
);

parameter CLK_PERIOD = 10;
integer slow_clk_cnt;
integer fast_clk_cnt;

reg pll_ref_clk;
wire clk;
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

reg         memory_write_req;
reg         memory_read_req;
reg  [31:0] memory_data_write;
wire [31:0] memory_data_read;
reg  [25:0] memory_addr;
wire        memory_busy;
reg         memory_program;

reg        input_buffer_empty;
reg [31:0] input_buffer_q;
wire       input_buffer_read;

// RAM  PHY Interface
wire         global_reset_n;
wire [15: 0] mem_dq;
wire [ 1: 0] mem_dqs;
wire [ 1: 0] mem_dqs_n;
wire [12: 0] mem_addr;
wire [ 2: 0] mem_ba;
wire         mem_cas_n;
wire         mem_cke;
wire         mem_clk;
wire         mem_clk_n;
wire         mem_cs_n;
wire [ 1: 0] mem_dm;
wire         mem_odt;
wire         mem_ras_n;
wire         mem_we_n;




assign sout = flash_dq[0];
assign flash_dq[1] = sin;


initial pll_ref_clk = 1'b0;
always #( CLK_PERIOD/2.0 )
  pll_ref_clk = ~pll_ref_clk;

initial slow_clk_cnt = 0;

initial reset = 1'b1;
always @(posedge pll_ref_clk) begin
  slow_clk_cnt = slow_clk_cnt + 1;
  if ( slow_clk_cnt == 2 )
    reset <= 1'b0;
end
/* always @( posedge clk ) begin */
/*   fast_clk_cnt = fast_clk_cnt + 1; */
/*   execute <= 0; */
/*   write_buffer_write <= 0; */
/*   bytes_to_read <= 0; */
/*   bytes_to_read <= 0; */
/*   if ( fast_clk_cnt == 20 ) begin */
/*     memory_write_req <=1; */
/*     memory_data_write <= 32'hDEADBEEF; */
/*     memory_addr <= 26'h0; */
/*   end */
/* end */

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

ram_controller_mem_model ram_controller_mem_model_inst (
  .mem_addr ( mem_addr ),
  .mem_ba ( mem_ba ),
  .mem_cas_n ( mem_cas_n ),
  .mem_cke ( mem_cke ),
  .mem_clk ( mem_clk ),
  .mem_clk_n ( mem_clk_n ),
  .mem_cs_n ( mem_cs_n ),
  .mem_dm ( mem_dm ),
  .mem_odt ( mem_odt ),
  .mem_ras_n ( mem_ras_n ),
  .mem_we_n ( mem_we_n ),

  .global_reset_n ( global_reset_n ),
  .mem_dq ( mem_dq ),
  .mem_dqs ( mem_dqs ),
  .mem_dqs_n ( mem_dqs_n )
  );

memory memory_inst(
  .pll_ref_clk ( pll_ref_clk ),
  .phy_clk ( clk ),
  .reset ( reset ),

  .write_req ( memory_write_req ),
  .read_req ( memory_read_req ),
  .data_write ( memory_data_write ),
  .data_read ( memory_data_read ),
  .addr ( memory_addr ),
  .busy ( memory_busy ),

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

  .flash_c ( flash_c ),
  .flash_sb ( flash_sb ),
  .flash_dq ( flash_dq ),

  .program ( memory_program ),
  .input_buffer_empty ( input_buffer_empty ),
  .input_buffer_q ( input_buffer_q ),
  .input_buffer_read ( input_buffer_read )
  );


endmodule
