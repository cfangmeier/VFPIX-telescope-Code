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
// Title       : control_unit
// Author      : Caleb Fangmeier
// Description : This is the top-level design file for the telescope
//               firmware
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module control_unit(
  input  wire         clk,  // 50 MHz
  input  wire         reset,

  input  wire         instr_ready,
  output reg          instr_ack,
  input  wire [31:0]  instr_in,

  output wire         dac_request_write,
  output wire [4:0]   dac_address,
  output wire [11:0]  dac_data,

  output wire         adc_request_write,
  output wire         adc_request_read,
  output wire [15:0]  adc_address,
  output wire [7:0]   adc_data,
  input  wire [7:0]   adc_data_readback,

  input wire          spi_busy
  );

`include "instruction_set.vh"
`include "register_space.vh"

//
// PARAMETERS
//
// State Listing
parameter IDLE          = 3'h0;
parameter PROC_INSTR    = 3'h1;
parameter READ_DATA     = 3'h2;
parameter PUSH_DATA     = 3'h3;
parameter WAIT_COMPLETE = 3'h4;


//
// WIRES
//



//
// REGISTERS
//
reg [2:0] state;
reg [31:0] instr;


reg [15:0] regs[15:0];
//
// ASSIGNMENTS
//

//
// SYNCHRONOUS
//
always @(posedge clk or posedge reset) begin
  if ( reset ) begin
    state <= IDLE;
  end
  else begin
    //Default states
    instr_ack <= 0;

    if ( state == IDLE) begin
        if ( instr_ready ) begin
          state <= PROC_INSTR;
          instr_ack <= 1;
          instr <= instr_in;
        end
    end
    else begin
      case (instr[31:27])  // CASE INSTRUCTION
      //-----------------------------------------------------------
      //------------BEGIN INSTRUCTION: NOOP------------------------
      //-----------------------------------------------------------
        NOOP: begin
          state <= IDLE;
        end
      //-----------------------------------------------------------
      //------------BEGIN INSTRUCTION: WRITE_REG-------------------
      //-----------------------------------------------------------
        WRITE_REG: begin
          case (state)  // CASE STAGE
            PROC_INSTR: begin
              case (instr[26:25]) // CASE REGISTER TYPE
                SEL_ADC: begin
                  // TODO: Write to ADC
                  state <= IDLE;
                end
                SEL_DAC: begin
                  // TODO: Write to DAC
                  state <= IDLE;
                end
                SEL_INT: begin
                  regs[instr[24:21]] <= instr[20:5];
                  state <= IDLE;
                end
                default: begin
                  state <= IDLE;
                end
              endcase  // END CASE REGISTER TYPE
            end
          endcase  // END CASE STATE
        end
      //-----------------------------------------------------------
      //------------BEGIN INSTRUCTION: READ_REG--------------------
      //-----------------------------------------------------------
        READ_REG: begin
          case (state)  // CASE STAGE
            PROC_INSTR: begin
              case (instr[26:25]) // CASE REGISTER TYPE
                SEL_ADC: begin
                  // TODO: Read from ADC
                  state <= IDLE;
                end
                SEL_DAC: begin
                  // TODO: Read from DAC
                  state <= IDLE;
                end
                SEL_INT: begin
                  // TODO: Read Internal registers
                    state <= IDLE;
                end
                default: begin
                  state <= IDLE;
                end
              endcase
            end // END STAGE
          endcase  // END CASE STATE
        end
      endcase  // END CASE INSTRUCTION
    end  // END ELSE (NOT IDLE)
  end  // END ELSE (NO RESET)
end  // END ALWAYS

endmodule
