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
// Title       : rj45_led_controller
// Author      : Caleb Fangmeier
// Created     : Aug. 24, 2016
// Description : This is an interface implementation for controlling a series
//               of eight LEDs on the 8xRJ-45 jack on the Telescope DAQ Board
//               The physical controller is a TLC59282 constant-current LED
//               driver.
//
//               It works by shifting 16 bits into a register on the
//               chip and then latching the value of the shift register into
//               the active register. This controller simply adapts the interface
//               to a simple 8-bit parallel value, and a clock. When the 8-bit
//               value changes, on the next clock a write is initiated.
//
// $Id$
//-------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module rj45_led_controller(
  input  wire         clk,  // 50 MHz
  input  wire [7:0]   led_vals_i,
  output reg  [7:0]   led_vals_o,
  output wire         rj45_led_sck,
  output wire         rj45_led_sin,
  output wire         rj45_led_lat,
  output wire         rj45_led_blk,
  input  wire         reset
  );

//
// REGISTERS
//
reg [1:0] clk_div;
reg clk_veto;
reg [15:0] led_value_shift;
reg [4:0] write_counter;
reg latch;

//
// ASSIGNMENTS
//
assign rj45_led_sck = clk & !clk_veto;
assign rj45_led_sin = led_value_shift[15];
assign rj45_led_lat = latch;
assign rj45_led_blk = 0;

always @(posedge clk or posedge reset) begin
  if ( reset ) begin
    clk_div <= 2'b11;
    clk_veto <= 0;
    led_value_shift <= 16'h0000;
    write_counter <= 5'h00;
    latch <= 0;
  end
  else begin
    clk_div <= clk_div+1;
  end
end

always @(negedge clk_div[1]) begin
  if (write_counter < 5'h11) begin
      write_counter <= write_counter + 1;
  end
  if (write_counter == 5'h11) begin
    if (led_vals_i != led_vals_o) begin
      led_vals_o <= led_vals_i;
      write_counter <= 5'h00;
      led_value_shift <= { 1'b0, led_vals_i[0],
                           1'b0, led_vals_i[1],
                           1'b0, led_vals_i[2],
                           1'b0, led_vals_i[3],
                           1'b0, led_vals_i[4],
                           1'b0, led_vals_i[5],
                           1'b0, led_vals_i[6],
                           1'b0, led_vals_i[7]};
    end
  end
  if (write_counter < 5'h0F) begin
    led_value_shift <= {led_value_shift[14:0], 1'b0};
  end
  else if (write_counter == 5'h0F) begin
    latch <= 1;
    clk_veto <= 1;
  end
  else if (write_counter == 5'h10) begin
    latch <= 0;
    clk_veto <= 0;
  end
end

endmodule
