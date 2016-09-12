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
// Title       : control_unit_testbench
// Author      : Caleb Fangmeier
// Description : Testbench for the control unit
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module control_unit_testbench
  (
    // no I/O for the testbench
  );

// Wires
reg sys_clk;
reg reset;

reg instr_empty;
wire instr_ack;
reg [31:0] instr[3:0];

reg readback_buffer_full;
wire readback_buffer_write;
wire [31:0] readback_buffer_data;

wire dac_request_write;
wire dac_address;
wire dac_data;

wire adc_request_write;
wire adc_request_read;
wire adc_address;
wire adc_data;
wire adc_data_readback;

reg spi_busy;

integer i;

parameter CLK_PERIOD = 10;

control_unit control_unit_inst (
  .clk ( sys_clk ),
  .reset ( reset ),

  .instr_ready ( ~instr_empty ),
  .instr_ack ( instr_ack ),
  .instr_in ( instr[0] ),

  .readback_ready ( ~readback_buffer_full ),
  .readback_write ( readback_buffer_write ),
  .readback_data ( readback_buffer_data ),

  .dac_request_write ( dac_request_write ),
  .dac_address ( dac_address ),
  .dac_data ( dac_data ),

  .adc_request_write ( adc_request_write ),
  .adc_request_read ( adc_request_read ),
  .adc_address ( adc_address ),
  .adc_data ( adc_data ),
  .adc_data_readback ( adc_data_readback ),

  .spi_busy ( spi_busy )
);

initial sys_clk = 1'b0;
always #( CLK_PERIOD/2.0 )
  sys_clk = ~sys_clk;

initial reset = 1'b1;
always @( posedge sys_clk ) begin
  i = i + 1;
  if ( i == 20 )
    #1 reset <= 1'b0;
end

initial i = 0;
initial instr_empty = 1'b0;
initial instr[0] = 32'h_0C_18_00_60;
initial instr[1] = 32'h_14_18_00_60;
initial instr[2] = 32'h_00_00_00_00;
initial instr[3] = 32'h_00_00_00_00;
initial readback_buffer_full = 1'b0;

always @(posedge sys_clk) begin
  if ( instr_ack ) begin
    instr[0] <= instr[1];
    instr[1] <= instr[2];
    instr[2] <= instr[3];
    instr[3] <= instr[0];
  end
end
endmodule
