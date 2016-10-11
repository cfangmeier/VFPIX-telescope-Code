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
  input  wire sys_clk,
  output wire clk,
  output wire reset,
  output wire hal_init_finished,

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
localparam DEBUG_SIZE = 2;
localparam OK_SIZE = 3+DEBUG_SIZE;

//----------------------------------------------------------------------------
// REGISTERS
//----------------------------------------------------------------------------

reg enable_ram;
reg enable_spi;
reg enable_rj45;
reg enable_led;
reg enable_aux;

//----------------------------------------------------------------------------
// WIRES
//----------------------------------------------------------------------------
wire okClk;
wire [112:0] okHE;
wire [65:0] okEH;
wire [65*OK_SIZE-1:0]  okEHx;

wire [31:0] control_bus;
wire memory_program;

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

wire        input_buffer_read;
wire        input_buffer_write;
wire        input_buffer_empty;
wire [10:0] input_buffer_words_available;
wire [10:0] input_buffer_used_words;
wire [31:0] input_buffer_data;
wire [31:0] input_buffer_q;
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

assign reset   = control_bus[0];
assign memory_program = control_bus[1];

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
okWireOR # (.N(OK_SIZE)) wireOR (okEH, okEHx);


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
  .okHE ( okHE),
  .okEHx ( okEHx[129:0] )
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
  .input_buffer_empty ( input_buffer_empty ),
  .input_buffer_q ( input_buffer_q ),
  .input_buffer_read ( input_buffer_read )
  );


adc_pll adc_pll_inst (
  .areset ( 1'b0 ),
  .inclk0 ( sys_clk ),
  .c0 ( adc_clk ),
  .locked (  )
);


okWireIn control_wires(
  .okHE(okHE),
  .ep_addr(8'h10),
  .ep_dataout(control_bus)
);

// 32 bit wide 1024 depth fifo
fifo32_clk_crossing_with_usage  programming_input_buffer (
  .aclr ( reset ),
  .rdclk ( clk ),
  .rdreq ( input_buffer_read ),
  .rdempty ( input_buffer_empty ),
  .rdusedw ( input_buffer_words_available),
  .q ( input_buffer_q ),

  .wrclk ( okClk ),
  .wrreq ( input_buffer_write ),
  .wrfull (  ),
  .wrusedw ( input_buffer_used_words ),
  .data ( input_buffer_data )
);

okBTPipeIn programming_input_btpipe(
  .okHE ( okHE ),
  .okEH ( okEHx[194:130] ),
  .ep_addr (8'hA1 ),
  .ep_dataout ( input_buffer_data ),
  .ep_write ( input_buffer_write ),
  .ep_blockstrobe (  ),
  .ep_ready ( (1024 - input_buffer_used_words) >= 64 )
);



/* debug_unit #(.DEBUG_SIZE(DEBUG_SIZE)) debug_unit_inst ( */
/*   .phy_clk ( phy_clk ), */
/*   .reset ( reset ), */
/*   .sys_clk ( sys_clk ), */
/*   .debug_enable ( debug_enable ), */
/*   .single_step ( single_step_enable ), */
/*   .clock_counter ( debug_clock_counter ), */
/*   .debug_wireout ( debug_wireout), */
/*   .okHE ( okHE ), */
/*   .okEHx ( okEHx[65*OK_SIZE-1 -: 65*DEBUG_SIZE-1] ) */
/* ); */


endmodule
