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
// Title       : hal
// Author      : Caleb Fangmeier
// Description : Hardware Abstraction Layer for DAQ Firmware. This acts
// essentially as a multiplexer between several sub units. They are all
// accessible through an associated memory address. All sub-units must
// implement an interface consisting of read/write request signals, input
// and output data buses, a 17-bit address input, and a busy output signal.
// If the requested operation is a read, the data must be available on the
// output data bus the cycle after busy is de-asserted.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module hal(
  input  wire sys_clk,     // 50 MHz
  output wire clk,         // 150 MHz
  output reg  reset,

  // Processor Interface
  input  wire                memory_read_req,
  input  wire                memory_write_req,
  output wire [31:0]         memory_data_read,
  input  wire [31:0]         memory_data_write,
  input  wire [25:0]         memory_addr,
  output wire                memory_busy,


  // Hardware Interface
  output wire [1:0]   led,
  output wire [1:0]   led_ext,

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
  input   wire [7:0]  adc_dat_d,

  inout  wire  [3:0]         flash_dq,
  output wire                flash_c,
  output wire                flash_sb,

  // FrontPanel Interface
  input  wire [4:0]   okUH,
  output wire [2:0]   okHU,
  inout  wire [31:0]  okUHU,
  inout  wire         okAA
);


//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
localparam OK_SIZE = 4;

//----------------------------------------------------------------------------
// REGISTERS
//----------------------------------------------------------------------------

reg enable_ram;
reg enable_spi;
reg enable_rj45;
reg enable_led;
reg enable_aux;

reg        memory_program;
reg [31:0] control_bus_last;
//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire okClk;
wire [112:0] okHE;
wire [64:0] okEH;

wire [31:0] control_bus;
wire [31:0] control_bus_ok;

wire busy_ram;
wire busy_spi;
wire busy_rj45;
wire busy_led;
wire busy_aux;

wire write_req_ram;
wire write_req_spi;
wire write_req_rj45;
wire write_req_led;
wire write_req_aux;

wire read_req_ram;
wire read_req_spi;
wire read_req_rj45;
wire read_req_led;
wire read_req_aux;

wire [31:0] data_read_ram;
wire [31:0] data_read_spi;
wire [31:0] data_read_rj45;
wire [31:0] data_read_led;
wire [31:0] data_read_aux;

wire        program_buffer_read;
wire        program_buffer_write;
wire        program_buffer_empty;
wire [12:0] program_buffer_wrusedw;
wire [12:0] program_buffer_rdusedw;
wire [31:0] program_buffer_data;
wire [31:0] program_buffer_q;

wire        memory_program_ack;
wire [31:0] debug_wireout;

wire local_init_done;
wire local_ready;
wire [5:0] state;

//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------
assign memory_busy = busy_ram | busy_spi |
                     busy_rj45 | busy_led |
                     busy_aux;
assign memory_data_read = data_read_ram | data_read_spi |
                          data_read_rj45 | data_read_led |
                          data_read_aux;

assign write_req_ram = memory_write_req & enable_ram;
assign write_req_spi = memory_write_req & enable_spi;
assign write_req_rj45 = memory_write_req & enable_rj45;
assign write_req_led = memory_write_req & enable_led;
assign write_req_aux = memory_write_req & enable_aux;

assign read_req_ram = memory_read_req & enable_ram;
assign read_req_spi = memory_read_req & enable_spi;
assign read_req_rj45 = memory_read_req & enable_rj45;
assign read_req_led = memory_read_req & enable_led;
assign read_req_aux = memory_read_req & enable_aux;

assign program_buffer_empty = (program_buffer_rdusedw == 0);

assign debug_wireout[4:0] = control_bus[4:0];
assign debug_wireout[5] = local_init_done;
assign debug_wireout[6] = local_ready;
assign debug_wireout[7] = 1'b0;
assign debug_wireout[13:8] = state;
assign debug_wireout[30:14] = 17'h0;
assign debug_wireout[31] = busy_ram;

//----------------------------------------------------------------------------
// Synchronous register updates
//----------------------------------------------------------------------------
always @( posedge sys_clk ) begin
  reset <= control_bus[0];
  if ( control_bus[1] & ~control_bus_last[1] ) begin
    memory_program <= 1;
  end
  else if ( memory_program_ack ) begin
    memory_program <= 0;
  end
  control_bus_last <= control_bus;
end
assign led = ~control_bus[3:2];
assign led_ext[1] = 0;
assign led_ext[0] = busy_ram;

//----------------------------------------------------------------------------
// Address Decoder
//----------------------------------------------------------------------------
always @( memory_addr or reset ) begin
  if ( reset ) begin
    enable_ram <= 0;
    enable_spi <= 0;
    enable_rj45 <= 0;
    enable_led <= 0;
    enable_aux <= 0;
  end
  else begin
    enable_ram <= 0;
    enable_spi <= 0;
    enable_rj45 <= 0;
    enable_led <= 0;
    enable_aux <= 0;
    if ( ~memory_addr[25] ) begin
      enable_ram <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00001 | memory_addr[24:20] == 5'b00010 ) begin
      enable_spi <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00011 ) begin
      enable_aux <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00100 ) begin
      enable_led <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00101 ) begin
      enable_rj45 <= 1;
    end
  end
end



//----------------------------------------------------------------------------
// Instantiations
//----------------------------------------------------------------------------
okHost okHI(
  .okUH(okUH),
  .okHU(okHU),
  .okUHU(okUHU),
  .okAA(okAA),
  .okClk(okClk),
  .okHE(okHE),
  .okEH(okEH)
);
wire [65*3-1:0]  okEHx;
okWireOR # (.N(3)) wireOR (okEH, okEHx);


spi_controller spi_controller_inst (
  .clk ( clk ),
  .reset ( reset ),

  .write_req ( write_req_spi ),
  .read_req ( read_req_spi ),
  .data_write ( memory_data_write ),
  .data_read ( data_read_spi ),
  .address ( memory_addr ),
  .busy ( busy_spi ),

  .sclk ( sclk ),
  .sdio ( sdio ),
  .adc_csb ( adc_csb ),
  .dac_csb ( {supdac_csb, rngdac_csb} )
);

aux_io aux_io_inst(
  .clk ( clk ),
  .reset ( reset ),

  .write_req ( write_req_aux ),
  .read_req ( read_req_aux),
  .data_write ( memory_data_write ),
  .data_read ( data_read_aux ),
  .address ( memory_addr ),
  .busy ( busy_aux ),

  .okClk ( okClk ),
  .okHE ( okHE ),
  .okEH ( okEHx[64:0] )
);

memory memory_inst (
  .pll_ref_clk ( sys_clk ) ,
  .phy_clk ( clk ),
  .reset ( reset ),

  .write_req ( write_req_ram ),
  .read_req ( read_req_ram ),
  .data_write ( memory_data_write ),
  .data_read ( data_read_ram ),
  .addr ( memory_addr ),
  .busy ( busy_ram ),

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
  .program_ack ( memory_program_ack ),
  .program_buffer_empty ( program_buffer_empty ),
  .program_buffer_q ( program_buffer_q ),
  .program_buffer_read ( program_buffer_read ),

  .local_ready ( local_ready ),
  .state ( state ),
  .local_init_done( local_init_done )
  );

adc_pll adc_pll_inst (
  .areset ( 1'b0 ),
  .inclk0 ( sys_clk ),
  .c0 ( adc_clk ),
  .locked (  )
);

okWireIn_sync control_wires(
  .clk ( sys_clk ),
  .okClk ( okClk ),
  .okHE ( okHE ),
  .ep_addr ( 8'h10 ),
  .ep_dataout ( control_bus )
);

// 32 bit wide 1024 depth fifo
fifo32_clk_crossing_with_usage  programming_input_buffer (
  .wrclk ( okClk ),
  .rdclk ( clk ),
  .aclr ( reset ),
  .data ( program_buffer_data ),
  .q ( program_buffer_q ),
  .wrreq ( program_buffer_write ),
  .rdreq ( program_buffer_read ),
  .wrusedw ( program_buffer_wrusedw ),
  .rdusedw ( program_buffer_rdusedw )
);

okBTPipeIn programming_input_btpipe(
  .okHE ( okHE ),
  .okEH ( okEHx[129:65] ),
  .ep_addr ( 8'hA1 ),
  .ep_dataout ( program_buffer_data ),
  .ep_write ( program_buffer_write ),
  .ep_blockstrobe (  ),
  .ep_ready ( (4096 - program_buffer_wrusedw) >= 64 )
);

debug_unit debug_unit_inst (
  .clk ( clk ),
  .reset ( reset ),
  .debug_wireout ( debug_wireout ),
  .okClk ( okClk ),
  .okHE ( okHE ),
  .okEH ( okEHx[194:130] )
);

endmodule
