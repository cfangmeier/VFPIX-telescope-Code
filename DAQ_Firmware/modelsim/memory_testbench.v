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
integer clk_cnt;

reg         pll_ref_clk;
wire        clk;
reg         reset;

reg  [7:0]  instruction;
reg         execute;
reg  [7:0]  bytes_to_read;
reg  [7:0]  write_buffer_data;
reg         write_buffer_write;
reg         read_buffer_read;

reg  [7:0]  instruction_shifter;
reg  [23:0] address_shifter;
reg  [7:0]  data_shifter;
reg  [7:0]  status_out_shifter;
reg  [63:0] data_out_shifter;
reg         byte_complete;

wire        busy;
wire [7:0]  read_buffer_q;
wire        read_buffer_empty;

wire        flash_dq0;
wire        flash_dq1;
wire        flash_wb;
wire        flash_holdb;
wire        flash_c;
wire        flash_sb;

wire        sout;
reg         sin;

reg         memory_write_req;
reg         memory_read_req;
reg  [31:0] memory_data_write;
wire [31:0] memory_data_read;
reg  [25:0] memory_addr;
wire        memory_busy;
reg         memory_program;
wire        memory_program_ack;


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



assign sout = flash_dq0;
assign flash_dq1 = sin;


initial pll_ref_clk = 1'b0;
always #( CLK_PERIOD/2.0 )
  pll_ref_clk = ~pll_ref_clk;

initial slow_clk_cnt = 0;
initial clk_cnt = 0;

initial reset = 1'b1;
always @(posedge pll_ref_clk) begin
  slow_clk_cnt = slow_clk_cnt + 1;
  if ( slow_clk_cnt == 2 )
    reset <= 1'b0;
end

initial memory_program = 1;
always @( posedge clk ) begin
  if ( memory_program_ack ) begin
    memory_program <= 0;
  end
end

integer flash_clk_cnt;
integer bytes_received;

always @(posedge flash_c or negedge flash_c) begin
  if ( flash_sb ) begin
    instruction_shifter <= 0;
    data_shifter <= 0;
    address_shifter <= 0;
    flash_clk_cnt <= 0;
    byte_complete <= 0;
    bytes_received <= 0;
    status_out_shifter <= 8'hAA;
    data_out_shifter <= 64'h00_00_00_02__AB_CD_EF_FF;
  end
  else begin
    if ( flash_c ) begin
      flash_clk_cnt <= flash_clk_cnt + 1;
      if ( flash_clk_cnt < 8 ) begin
        instruction_shifter <= {instruction_shifter[6:0], sout};
      end
      else begin
        case ( instruction_shifter )
          8'b0000_0010: begin
            if ( flash_clk_cnt < 32 ) begin
              address_shifter <= {address_shifter[23:0], sout};
            end
            else begin
              data_shifter <= {data_shifter[6:0], sout};
            end
            if ( ((flash_clk_cnt+1) % 8) == 0 ) begin
              byte_complete <= 1;
              bytes_received <= bytes_received + 1;
            end
            else begin
              byte_complete <= 0;
            end
          end
          8'b0000_0011: begin
            if ( flash_clk_cnt < 32 ) begin
              address_shifter <= {address_shifter[23:0], sout};
            end
            if ( ((flash_clk_cnt+1) % 8) == 0 ) begin
              byte_complete <= 1;
              bytes_received <= bytes_received + 1;
            end
            else begin
              byte_complete <= 0;
            end
          end
        endcase
      end
    end
    else begin
      case ( instruction_shifter )
        8'b0000_0101: begin
          sin <= status_out_shifter[7];
          status_out_shifter <= {status_out_shifter[6:0], status_out_shifter[7]};
        end
        8'b0000_0011: begin
          if ( flash_clk_cnt >= 32 ) begin
            sin <= data_out_shifter[63];
            data_out_shifter <= {data_out_shifter[62:0], data_out_shifter[63]};
          end
        end
      endcase
    end
  end
end

wire        program_buffer_empty;
reg  [31:0] program_buffer_q;
wire        program_buffer_read;
reg  [3:0]  program_buffer_pointer;
reg  [31:0] program_buffer_array[15:0];

assign program_buffer_empty = 0;

initial begin
  program_buffer_pointer   <= 0;
  program_buffer_array[00] <= 32'd2;
  program_buffer_array[01] <= 32'hDEADBEEF;
  program_buffer_array[02] <= 32'hDEADBEEF;
  program_buffer_array[03] <= 32'hDEADBEEF;
  program_buffer_array[04] <= 32'hDEADBEEF;
  program_buffer_array[05] <= 32'hDEADBEEF;
  program_buffer_array[06] <= 32'hDEADBEEF;
  program_buffer_array[07] <= 32'hDEADBEEF;
  program_buffer_array[08] <= 32'hDEADBEEF;
  program_buffer_array[09] <= 32'hDEADBEEF;
  program_buffer_array[10] <= 32'hDEADBEEF;
  program_buffer_array[11] <= 32'hDEADBEEF;
  program_buffer_array[12] <= 32'hDEADBEEF;
  program_buffer_array[13] <= 32'hDEADBEEF;
  program_buffer_array[14] <= 32'hDEADBEEF;
  program_buffer_array[15] <= 32'hDEADBEEF;
end

always @( negedge clk ) begin
  if ( program_buffer_read ) begin
    program_buffer_q <= program_buffer_array[program_buffer_pointer];
    program_buffer_pointer <= program_buffer_pointer+1;
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

  .flash_dq0 ( flash_dq0 ),
  .flash_dq1 ( flash_dq1 ),
  .flash_wb ( flash_wb ),
  .flash_holdb ( flash_holdb ),
  .flash_c ( flash_c ),
  .flash_sb ( flash_sb ),

  .program ( memory_program ),
  .program_ack ( memory_program_ack ),
  .program_buffer_empty ( program_buffer_empty ),
  .program_buffer_q ( program_buffer_q ),
  .program_buffer_read ( program_buffer_read )
  );


endmodule
