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
// Title       : adc_deser
// Author      : Caleb Fangmeier
// Description : Deserializer unit for the frontend ADCs. The deserializer is
// always running, but under idle condition, no deserialized samples are
// written into the input buffer. When a sample should be taken, the
// read_enable signal should be placed high synchronous with the internal ADC
// clock (10MHz). The actual sample from this time will be available eight
// samples later, at which point the value is placed into the output buffer.
//
// Care must be taken to ensure that the internal buffers are not overused.
// They are only 128 samples deep to accomodate 1 sample for each channel of
// the APC128 readout chip.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps


module adc_deser (
  input  wire        clk,  // 150 MHz
  input  wire        reset,

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire        read_enable,

  input  wire        buffer_rdreq,
  output wire        buffer_empty,
  output wire [9:0]  buffer_data_a,
  output wire [9:0]  buffer_data_b,
  output wire [9:0]  buffer_data_c,
  output wire [9:0]  buffer_data_d,

  //--------------------------------------------------------------------------
  //---------------------------HW INTERFACE-----------------------------------
  //--------------------------------------------------------------------------
  input  wire        adc_fco,
  input  wire        adc_dco,
  input  wire        adc_dat_a,
  input  wire        adc_dat_b,
  input  wire        adc_dat_c,
  input  wire        adc_dat_d
);

//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
reg [9:0]  input_shifter[3:0];

reg [3:0]  negedge_sample;

reg [7:0]  sample_delay_shifter;

//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire [39:0] buffer_q;
wire [39:0] buffer_data;

//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------

assign buffer_data = {input_shifter[0], input_shifter[1],
                      input_shifter[2], input_shifter[3]};

assign buffer_data_a = buffer_q[39:30];
assign buffer_data_b = buffer_q[29:20];
assign buffer_data_c = buffer_q[19:10];
assign buffer_data_d = buffer_q[9:0];


//----------------------------------------------------------------------------
// Clocked Logic
//----------------------------------------------------------------------------

always @( posedge adc_fco or negedge reset ) begin
  if ( ~reset ) begin
    sample_delay_shifter <= 8'd0;
  end
  else begin
    sample_delay_shifter <= {sample_delay_shifter[6:0], read_enable};
  end
end

always @( negedge adc_dco ) begin
  negedge_sample[0] = adc_dat_a;
  negedge_sample[1] = adc_dat_b;
  negedge_sample[2] = adc_dat_c;
  negedge_sample[3] = adc_dat_d;
end

always @( posedge adc_dco ) begin
  input_shifter[0] = {input_shifter[0][7:0], negedge_sample[0], adc_dat_a};
  input_shifter[1] = {input_shifter[1][7:0], negedge_sample[1], adc_dat_b};
  input_shifter[2] = {input_shifter[2][7:0], negedge_sample[2], adc_dat_c};
  input_shifter[3] = {input_shifter[3][7:0], negedge_sample[3], adc_dat_d};
end

//----------------------------------------------------------------------------
// Instantiations
//----------------------------------------------------------------------------
adc_data_buffer adc_data_buffer_inst (
  .aclr ( reset ),
  .data ( buffer_data ),
  .q ( buffer_q ),
  .wrclk ( adc_fco ),
  .rdclk ( clk ),
  .wrreq ( sample_delay_shifter[7] ),
  .rdreq ( buffer_rdreq ),
  .wrfull (  ),
  .rdempty ( buffer_empty )
);

endmodule
