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
// Title       : adc_frontend
// Author      : Caleb Fangmeier
// Description : Frontend for reading adc data.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps


module adc_frontend (
  input  wire        clk,  // 150 MHz
  input  wire        reset,

  output  wire        adc_clk,  // 10 MHz

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire        write_req,
  input  wire        read_req,
  input  wire [31:0] data_write,
  output reg  [31:0] data_read,
  input  wire [25:0] addr,
  output wire        busy,

  //--------------------------------------------------------------------------
  //---------------------------HW INTERFACE-----------------------------------
  //--------------------------------------------------------------------------
  input  wire [7:0]  adc_fco,
  input  wire [7:0]  adc_dco,
  input  wire [7:0]  adc_dat_a,
  input  wire [7:0]  adc_dat_b,
  input  wire [7:0]  adc_dat_c,
  input  wire [7:0]  adc_dat_d
);



generate
  genvar i;
  for( i=0; i<8; i=i+1 ) begin: my_loop
    adc_deser adc_deser_inst (
      .clk ( clk ),
      .reset ( reset ),

      .begin_sample ( begin_sample[i] ),
      .buffer_rdreq ( buffer_rdreq[i] ),
      .buffer_data_a ( buffer_data_a[i] ),
      .buffer_data_b ( buffer_data_b[i] ),
      .buffer_data_c ( buffer_data_c[i] ),
      .buffer_data_d ( buffer_data_d[i] ),
      .busy ( deser_busy[i] ),

      .adc_fco ( adc_fco[i] ),
      .adc_dco ( adc_dco[i] ),
      .adc_dat_a ( adc_dat_a[i] ),
      .adc_dat_b ( adc_dat_b[i] ),
      .adc_dat_c ( adc_dat_c[i] ),
      .adc_dat_d ( adc_dat_d[i] )
    );
  end
endgenerate

adc_pll adc_pll_inst (
  .areset ( 1'b0 ),
  .inclk0 ( clk ),
  .c0 ( adc_clk ),
  .locked (  )
);

endmodule
