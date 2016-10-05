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
  input  wire         clk,
  input  wire         reset,
  input  wire [31:0]  data_out,
  output reg  [31:0]  data_in,
  input  wire [5:0]   read_bits,
  input  wire [5:0]   write_bits,
  input  wire         request_action,
  output reg          busy,
  output wire         sclk,
  inout  wire         sdio,
  output reg          cs
);

parameter DIVIDE = 2;
wire [DIVIDE-1:0] sclk_next;

reg [6:0] cycle_counter;
reg [30:0] data_in_shifter;
reg [31:0] data_out_shifter;
reg is_writing;
reg sdio_int;
reg [DIVIDE-1:0] sclk_int;


assign sdio = is_writing ? sdio_int : 1'bz;
assign sclk = sclk_int[DIVIDE-1] | ~busy;
assign sclk_next = sclk_int + 1;

always @( posedge clk ) begin
  if (reset) begin
    busy <= 0;
    is_writing <= 0;
    sdio_int <= 0;
    cycle_counter <= 7'h00;
    data_in_shifter <= 32'h00000000;
    data_out_shifter <= 32'h00000000;
    cs <= 0;
    sclk_int <= 0;
  end
  else begin
    sclk_int <= sclk_next;
    if (!busy) begin
      if (request_action) begin
        busy <= 1;
        cycle_counter <= 6'h00;
        data_out_shifter <= data_out;
        data_in_shifter <= 32'h00000000;
        cs <= 0;
        sclk_int <= 0;
      end
    end
    else begin
      data_in <= 0;
      if ( ~sclk_int[DIVIDE-1] & sclk_next[DIVIDE-1] ) begin
        if (cycle_counter < write_bits) begin  // writing
          is_writing <= 1;
          sdio_int <= data_out_shifter[31];
          data_out_shifter[31:0] <= {data_out_shifter[30:0], 1'b0};
          cs <= 1;
          cycle_counter <= cycle_counter + 1;
        end
        else if (cycle_counter < (write_bits+read_bits)) begin  // reading
          is_writing <= 0;
          data_in_shifter <= {data_in_shifter[29:0], sdio};
          cs <= 1;
          cycle_counter <= cycle_counter + 1;
        end
        else begin
          data_in <= {data_in_shifter, sdio};
          busy <= 0;
          cycle_counter <= 6'h00;
          cs <= 0;
        end
      end
    end
  end
end

endmodule
