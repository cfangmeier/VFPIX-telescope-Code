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
// Title       : spi_controller
// Author      : Caleb Fangmeier
// Description : Controller responsible for multiplexing the SPI interface
//               to allow controll by multiple agents.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps


module spi_controller(
  input  wire        clk,
  input  wire        reset,

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire        write_req,
  input  wire        read_req,
  input  wire [31:0] data_write,
  output wire [31:0] data_read,
  input  wire [16:0] address,
  output wire        busy,

  //--------------------------------------------------------------------------
  //---------------------------HW INTERFACE-----------------------------------
  //--------------------------------------------------------------------------
  output wire        sclk,
  inout  wire        sdio,
  output wire [7:0] adc_csb,
  output wire [1:0] dac_csb
);


reg         dac_request_write;
reg [4:0]   dac_address;
reg [11:0]  dac_data;
reg         adc_request_read;
reg         adc_request_write;
reg [10:0]  adc_address;
reg [11:0]  adc_data;
reg [7:0]   adc_data_readback;

always @( write_req or read_req or address or data_write ) begin
  adc_request_write <= 0;
  adc_request_read <= 0;
  adc_address <= 0;
  adc_data <= 0;
  dac_request_write <= 0;
  dac_address <= 0;
  dac_data <= 0;
  if ( write_req ) begin
    if ( address[15:11] == 5'b00001 ) begin
      adc_request_write <= 1;
      adc_address <= address[10:0];
      adc_data <= data_write[7:0];
    end
    else if ( address[15:11] == 5'b00010 ) begin
      dac_request_write <= 1;
      dac_address <= address[4:0];
      dac_data <= data_write[11:0];
    end
  end
  if ( read_req ) begin
    if ( address[15:11] == 5'b00001 ) begin
      adc_request_read <= 1;
      adc_address <= address[10:0];
    end
    else if ( address[15:11] == 5'b00010 ) begin
      // No read of DAC
    end
  end

end



//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire sclk_int;
wire [31:0] interface_data_read;

wire cs;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
reg invert_sclk;

reg [31:0] interface_data_write;
reg request_action;
reg [5:0] read_bits;
reg [5:0] write_bits;

reg  dev_select;
reg [2:0] adc_select;
reg dac_select;

//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------

/*
 * Depending on the output device, data is updated either
 * on the rising or falling edge of the clock. Therefore,
 * the output clock must be (non)inverted for
 * (falling)rising edge devices.
 */
assign sclk = sclk_int^invert_sclk;

generate
  genvar i;
  for (i=0; i<8; i=i+1) begin: loop_a
    assign adc_csb[i] = ~(cs & (adc_select == i) & dev_select);
  end
  for (i=0; i<2; i=i+1) begin: loop_b
    assign dac_csb[i] = ~(cs & (dac_select == i) & ~dev_select);
  end
endgenerate

assign data_read = interface_data_read;

//----------------------------------------------------------------------------
// State Machine
//----------------------------------------------------------------------------

always @( posedge clk ) begin
  if (reset) begin
    interface_data_write <= 32'b00000000;
    request_action <= 0;
    invert_sclk <= 0;
  end
  else begin
    if ( !busy & dac_request_write ) begin
      interface_data_write[31:28] <= 4'b1001;
      interface_data_write[27:24] <= 4'b0011;
      interface_data_write[23:20] <= dac_address[3:0];
      interface_data_write[19:8] <= dac_data[11:0];
      interface_data_write[7:0] <= 0;
      read_bits <= 6'h00;
      write_bits <= 6'h20;
      request_action <= 1;
      invert_sclk <= 1;
      dac_select <= dac_address[4];
      dev_select <= 0;
    end
    else if ( !busy & adc_request_write ) begin
      interface_data_write[31] <= 0; // r/wb
      interface_data_write[30:29] <= 2'h0; // w1,w0
      interface_data_write[28:24] <= 5'h00; // A12:A8
      interface_data_write[23:16] <= adc_address[7:0]; // A7:A0
      interface_data_write[15:8] <= adc_data[7:0]; // D7:D0
      interface_data_write[7:0] <= 0;
      read_bits <= 6'd00;
      write_bits <= 6'd24;
      request_action <= 1;
      invert_sclk <= 0;
      adc_select <= adc_address[10:8];
      dev_select <= 1;
    end
    else if ( !busy & adc_request_read ) begin
      interface_data_write[31] <= 1; // r/wb
      interface_data_write[30:29] <= 2'h0; // w1,w0
      interface_data_write[28:24] <= 5'h00; // A12:A8
      interface_data_write[23:16] <= adc_address[7:0]; // A7:A0
      interface_data_write[15:0] <= 0;
      read_bits <= 6'd08;
      write_bits <= 6'd16;
      request_action <= 1;
      invert_sclk <= 0;
      adc_select <= adc_address[10:8];
      dev_select <= 1;
    end
    else begin
      request_action <= 0;
    end
  end
end

//
// INSTANTIATIONS
//

spi_interface spi_interface_inst(
  .clk ( clk ),
  .reset ( reset ),
  .data_in ( interface_data_read ),
  .data_out ( interface_data_write ),
  .read_bits ( read_bits ),
  .write_bits ( write_bits ),
  .request_action ( request_action ),
  .busy ( busy ),
  .sclk ( sclk_int ),
  .sdio ( sdio ),
  .cs ( cs )
);
endmodule
