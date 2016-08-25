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
// Title       : daq_firmware
// Author      : Caleb Fangmeier
// Created     : Aug. 24, 2016
// Description : This is the top-level design file for the telescope
//               firmware
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module daq_firmware(
  input  wire [4:0]   okUH,
  output wire [2:0]   okHU,
  inout  wire [31:0]  okUHU,
  inout  wire         okAA,

  input  wire         sys_clk,  // 50 MHz

  output wire [1:0]   led,

  output wire [ 12: 0]       mem_addr,
  output wire [  2: 0]       mem_ba,
  output wire                mem_cas_n,
  output wire [  0: 0]       mem_cke,
  inout  wire [  0: 0]       mem_clk,
  inout  wire [  0: 0]       mem_clk_n,
  output wire [  0: 0]       mem_cs_n,
  output wire [  1: 0]       mem_dm,
  inout  wire [ 15: 0]       mem_dq,
  inout  wire [  1: 0]       mem_dqs,
  output wire [  0: 0]       mem_odt,
  output wire                mem_ras_n,
  output wire                mem_we_n,

  output wire                rj45_led_sck,
  output wire                rj45_led_sin,
  output wire                rj45_led_lat,
  output wire                rj45_led_blk,

  output wire sclk,
  inout  wire sdio,
  output wire supdac_csb,
  output wire rngdac_csb,
  output wire [7:0] adc_csb,

  output  wire        adc_clk,  // ?? MHz
  input   wire [7:0]  adc_fco,
  input   wire [7:0]  adc_dco,
  input   wire [7:0]  adc_dat_a,
  input   wire [7:0]  adc_dat_b,
  input   wire [7:0]  adc_dat_c,
  input   wire [7:0]  adc_dat_d
  );

`include "instruction_set.vh"
`include "register_space.vh"

//
// PARAMETERS
//
// State Listing
parameter IDLE          = 3'h0;
parameter READ_COMMAND  = 3'h1;
parameter PROC_COMMAND  = 3'h2;
parameter READ_DATA     = 3'h3;
parameter PUSH_DATA     = 3'h4;
parameter WAIT_COMPLETE = 3'h5;


//
// WIRES
//
// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;

// Circuit wires
wire fifowrite;
wire fiforead;
wire [15:0] datain;
wire [15:0] dataout;
wire [31:0] wireout;

wire reset;

wire readback_request_read;
wire command_request_write;

wire [31:0] data_in;
wire [31:0] data_out;

wire regWrite;
wire [31:0] regDataOut;

wire command_available_n;

wire sys_clk_n;
wire [2:0] state_next;

wire command_request_read;
wire readback_buffer_write;
wire readback_buffer_data;
wire readback_buffer_q;
wire readback_buffer_full;
wire readback_buffer_read;

wire int_reg_data;
wire int_reg_addr;
wire int_reg_write;

wire dac_request_write;
wire dac_address;
wire dac_data;

wire adc_request_write;
wire adc_request_read;
wire adc_address;
wire adc_data;

wire spi_busy;

//
// REGISTERS
//
reg [2:0] state;
wire [31:0] command;



//
// ASSIGNMENTS
//
assign reset = wireout[0];

//
// SYNCHRONOUS
//
always @(posedge sys_clk or posedge reset) begin
  if ( !reset ) begin
    state <= IDLE;
  end
  else begin
    state <= state_next;
  end
end

always_comb
//
// ASYNCHRONOUS
//
always @(state or
         command) begin
  //Default states
  state_next = state;
  command_request_read = 0;
  int_reg_write = 0;
  case (state)
    IDLE: begin
      if ( !command_available_n) begin
        state_next = READ_COMMAND;
        command_request_read = 1;
      end
    end
    READ_COMMAND: begin
      command_request_read = 1;
      state_next = PROC_COMMAND;
    end
    PROC_COMMAND: begin
      case (command[31:27])
        NOOP: begin
          state_next = IDLE;
        end
        WRITE_REG: begin
          case (command[26:25])
            //SEL_ADC:
              // TODO: Write to ADC
            //SEL_DAC:
              // TODO: Write to DAC
            SEL_INT: begin
              int_reg_addr = command[24:20];
              int_reg_data = command[19:4];
              int_reg_write = 1;
              next_state = IDLE;
            end
          endcase

        end
        READ_REG: begin
          case (command[26:25])
            //SEL_ADC:
              // TODO: Read from ADC
            //SEL_DAC:
              // TODO: Read from DAC
            SEL_INT: begin
              int_reg_addr = command[24:20];
              readback_buffer_data = int_reg_data;
              if ( !readback_buffer_full ) begin
                readback_buffer_write = 1;
                next_state = IDLE;
              end
            end
          endcase
        end
        WRITE_RAM: begin

        end
        READ_RAM: begin

        end
      endcase
    end
    READ_DATA: begin

    end
    PUSH_DATA: begin

    end
    WAIT_COMPLETE: begin

    end
  endcase
end

//
// INSTANTIATIONS
//

// 32 bit wide 1024 depth fifo
testfifo  instructionbuffer (
  .aclr ( reset ),
  .data ( data_in ),
  .rdclk ( sys_clk ),
  .rdreq ( command_request_read ),
  .wrclk ( okClk ),
  .wrreq ( command_request_write ),
  .q ( command ),
  .rdempty ( command_available_n ),
  .rdusedw (  ),
  .wrfull (  ),
  .wrusedw (  )
);

// 32 bit wide 1024 depth fifo
testfifo  readback_buffer (
  .aclr ( reset ),
  .data ( readback_buffer_data ),
  .rdclk ( okClk ),
  .rdreq ( readback_buffer_read ),
  .wrclk ( sys_clk ),
  .wrreq ( readback_buffer_write ),
  .q ( readback_buffer_q ),
  .rdempty (  ),
  .rdusedw (  ),
  .wrfull ( readback_buffer_full ),
  .wrusedw (  )
);

internal_registers internal_registers_inst(
  .clk( sys_clk ),
  .data( int_reg_data ),
  .addr( int_reg_addr ),
  .write( int_reg_write ),
  .reset( reset )
);


rj45_led_controller rj45_led_controller_inst(
  .sys_clk ( sys_clk ),
  .led_vals_i ( led_data[7:0] ),
  .led_vals_o (  ),
  .rj45_led_sck ( rj45_led_sck ),
  .rj45_led_sin ( rj45_led_sin ),
  .rj45_led_lat ( rj45_led_lat ),
  .rj45_led_blk ( rj45_led_blk )
);

spi_controller spi_controller_inst(
  .sys_clk ( sys_clk ),
  .reset ( reset ),
  .dac_request_write ( dac_request_write ),
  .dac_address ( dac_address ),
  .dac_data ( dac_data ),
  .adc_request_write ( adc_request_write ),
  .adc_request_read ( adc_request_read ),
  .adc_address ( adc_address ),
  .adc_data ( adc_data ),
  .busy ( spi_busy ),
  .sclk ( sclk ),
  .sdio ( sdio ),
  .adc_csb ( adc_csb ),
  .dac_csb ( {supdac_csb, rngdac_csb} ),
);

memory memory_inst(
  .sys_clk(sys_clk),
  .mem_addr(mem_addr),
  .mem_ba(mem_ba),
  .mem_cas_n(mem_cas_n),
  .mem_cke(mem_cke),
  .mem_clk(mem_clk),
  .mem_clk_n(mem_clk_n),
  .mem_cs_n(mem_cs_n),
  .mem_dm(mem_dm),
  .mem_dq(mem_dq),
  .mem_dqs(mem_dqs),
  .mem_odt(mem_odt),
  .mem_ras_n(mem_ras_n),
  .mem_we_n(mem_we_n)
);

// FrontPanel module instantiations
wire [65*3-1:0]  okEHx;
okHost okHI(
  .okUH(okUH),
  .okHU(okHU),
  .okUHU(okUHU),
  .okAA(okAA),
  .okClk(okClk),
  .okHE(okHE),
  .okEH(okEH)
);
okWireOR # (.N(3)) wireOR (okEH, okEHx);


okWireIn wire10(
  .okHE(okHE),
  .ep_addr(8'h10),
  .ep_dataout(wireout)
);

okTriggerOut trigOut0A(
  .okHE(okHE),
  .ep_addr(8'h0A),
  .ep_clk(sys_clk),
  .ep_trigger()
);

okPipeIn pipe80(
  .okHE(okHE),
  .okEH(okEHx[0*65 +: 65]),
  .ep_addr(8'h80),
  .ep_write(command_request_write),
  .ep_dataout(data_in)
);

okPipeOut pipeA0(
  .okHE(okHE),
  .okEH(okEHx[1*65 +: 65]),
  .ep_addr(8'hA0),
  .ep_read( readback_buffer_read ),
  .ep_datain( readback_buffer_q )
);

okRegisterBridge regBridge (
  .okHE(okHE),
  .okEH(okEHx[2*65 +: 65]),
  .ep_write(regWrite),
  .ep_read(),
  .ep_address(),
  .ep_dataout(regDataOut),
  .ep_datain()
);

endmodule
