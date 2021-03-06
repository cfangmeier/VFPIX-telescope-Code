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
// and output data buses, a 26-bit address input, and a busy output signal.
// If the requested operation is a read, the data must be available on the
// output data bus the cycle after busy is de-asserted. At all other times,
// the output data bus must be forced to all zeros.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module hal(
  input  wire                sys_clk,     // 50 MHz
  output wire                clk,         // 133 MHz
  output wire                reset,

  // Processor Interface
  input  wire                memory_read_req,
  input  wire                memory_write_req,
  output wire [ 31: 0]       memory_data_read,
  input  wire [ 31: 0]       memory_data_write,
  input  wire [ 25: 0]       memory_addr,
  output wire                memory_busy,


  // Hardware Interface
  output wire [  1: 0]       led,
  output wire [  1: 0]       led_ext,

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

  output wire                sclk,
  inout  wire                sdio,
  output wire                supdac_csb,
  output wire                rngdac_csb,
  output wire [  7: 0]       adc_csb,

  output wire                adc_clk,  // 13.3 MHz
  input  wire [  7: 0]       adc_fco,
  input  wire [  7: 0]       adc_dco,
  input  wire [  7: 0]       adc_dat_a,
  input  wire [  7: 0]       adc_dat_b,
  input  wire [  7: 0]       adc_dat_c,
  input  wire [  7: 0]       adc_dat_d,

  output wire                flash_dq0,
  input  wire                flash_dq1,
  output wire                flash_wb,
  output wire                flash_holdb,
  output wire                flash_c,
  output wire                flash_sb,

  // APC128 Interface
  output wire                apc_cal,
  output wire                apc_cs,
  output wire                apc_is1,
  output wire                apc_is2,
  output wire                apc_le,
  output wire                apc_null,
  output wire                apc_r12,
  output wire                apc_reset,
  output wire                apc_rphi1,
  output wire                apc_rphi2,
  output wire                apc_sbi,
  output wire                apc_seb,
  output wire                apc_sphi1,
  output wire                apc_sphi2,
  output wire                apc_sr,

  output wire                apc_rbo_a1,
  output wire                apc_rbo_b1,
  output wire                apc_rbo_a2,
  output wire                apc_rbo_b2,
  output wire                apc_rbo_a3,
  output wire                apc_rbo_b3,
  output wire                apc_rbo_a4,
  output wire                apc_rbo_b4,
  input  wire                apc_rbi,

  // FrontPanel Interface
  input  wire [  4: 0]       okUH,
  output wire [  2: 0]       okHU,
  inout  wire [ 31: 0]       okUHU,
  inout  wire                okAA,

  //TEMPORARY
  input wire  [ 24: 0]       pc,
  input wire  [ 31: 0]       ir,
  input wire  [  1: 0]       muxMA_sel,
  input wire  [  2: 0]       cpu_stage,
  input wire  [31:0]         r1,
  input wire  [31:0]         r15,
  input wire                 wr_write,
  input wire  [31:0]         rz,
  input wire  [31:0]         ry,
  input wire  [31:0]         alu_inA,
  input wire  [31:0]         alu_inB,
  input wire  [31:0]         immediate,
  input wire  [31:0]         immediate_temp,
  input wire                 muxB_sel
);


//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
localparam OK_SIZE = 4;
localparam DEBUG_SIZE = 10;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
reg                      enable_ram;
reg                      enable_spi;
reg                      enable_rj45;
reg                      enable_aux;
reg                      enable_adc_frontend;

reg                      memory_program;
reg [31:0]               control_bus_last;
reg                      init_finished;

//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire                     okClk;
wire [112:0]             okHE;
wire [64:0]              okEH;

reg                      reset_ram;
wire [31:0]              control_bus;
wire [31:0]              control_bus_ok;

wire                     busy_ram;
wire                     write_req_ram;
wire                     read_req_ram;
wire [31:0]              data_read_ram;

wire                     busy_spi;
wire                     write_req_spi;
wire                     read_req_spi;
wire [31:0]              data_read_spi;

wire                     busy_rj45;
wire                     write_req_rj45;
wire                     read_req_rj45;
wire [31:0]              data_read_rj45;

wire                     busy_aux;
wire                     write_req_aux;
wire                     read_req_aux;
wire [31:0]              data_read_aux;

wire                     busy_adc_frontend;
wire                     write_req_adc_frontend;
wire                     read_req_adc_frontend;
wire [31:0]              data_read_adc_frontend;

wire                     program_buffer_read;
wire                     program_buffer_write;
wire                     program_buffer_empty;
wire [12:0]              program_buffer_wrusedw;
wire [12:0]              program_buffer_rdusedw;
wire [31:0]              program_buffer_data;
wire [31:0]              program_buffer_q;

wire                     memory_program_ack;
wire [32*DEBUG_SIZE-1:0] debug_wireout;

wire [5:0] state;
wire       busy_int;

//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------
assign memory_busy = busy_ram | busy_spi |
                     busy_rj45 | busy_aux | busy_adc_frontend;
assign memory_data_read = data_read_ram | data_read_spi |
                          data_read_rj45 | data_read_aux;

assign write_req_ram = memory_write_req & enable_ram;
assign write_req_spi = memory_write_req & enable_spi;
assign write_req_rj45 = memory_write_req & enable_rj45;
assign write_req_aux = memory_write_req & enable_aux;
assign write_req_adc_frontend = memory_write_req & enable_adc_frontend;

assign read_req_ram = memory_read_req & enable_ram;
assign read_req_spi = memory_read_req & enable_spi;
assign read_req_rj45 = memory_read_req & enable_rj45;
assign read_req_aux = memory_read_req & enable_aux;
assign read_req_adc_frontend = memory_read_req & enable_adc_frontend;

assign program_buffer_empty = (program_buffer_rdusedw == 0);

assign led = ~control_bus[3:2];
assign led_ext[1] = 0;
assign led_ext[0] = busy_ram;

assign apc_cal = 0;
assign apc_cs = 0;
assign apc_is1 = 0;
assign apc_is2 = 0;
assign apc_le = 0;
assign apc_null = 0;
assign apc_r12 = 0;
assign apc_reset = 0;
assign apc_rphi1 = 0;
assign apc_rphi2 = 0;
assign apc_sbi = 0;
assign apc_seb = 0;
assign apc_sphi1 = 0;
assign apc_sphi2 = 0;
assign apc_sr = 0;

assign apc_rbo_a1 = 0;
assign apc_rbo_b1 = 0;
assign apc_rbo_a2 = 0;
assign apc_rbo_b2 = 0;
assign apc_rbo_a3 = 0;
assign apc_rbo_b3 = 0;
assign apc_rbo_a4 = 0;
assign apc_rbo_b4 = 0;
//----------------------------------------------------------------------------
// DEBUG WIRE
//----------------------------------------------------------------------------

assign debug_wireout[5:0] = state;
assign debug_wireout[29:6] = pc;
assign debug_wireout[63:32] = ir;
assign debug_wireout[89:64] = memory_addr;
assign debug_wireout[121:90] = memory_data_read;
assign debug_wireout[153:122] = memory_data_write;
assign debug_wireout[157:155] = cpu_stage;
assign debug_wireout[158] = wr_write;

assign debug_wireout[159] = memory_busy;
assign debug_wireout[160] = busy_ram;
assign debug_wireout[161] = busy_spi;
assign debug_wireout[162] = busy_rj45;
assign debug_wireout[163] = busy_aux;
assign debug_wireout[164] = enable_ram;
assign debug_wireout[165] = enable_spi;
assign debug_wireout[166] = enable_rj45;
assign debug_wireout[167] = enable_aux;
assign debug_wireout[168] = memory_program_ack;
assign debug_wireout[169] = init_finished;

assign debug_wireout[171] = memory_program;
assign debug_wireout[172] = memory_write_req;
assign debug_wireout[173] = memory_read_req;
assign debug_wireout[174] = busy_int;

assign debug_wireout[175] = sclk;
assign debug_wireout[176] = sdio;
assign debug_wireout[177] = supdac_csb;
assign debug_wireout[178] = rngdac_csb;
assign debug_wireout[186:179] = adc_csb;

assign debug_wireout[223:192] = data_read_ram;
assign debug_wireout[255:224] = data_read_spi;
assign debug_wireout[287:256] = data_read_rj45;

assign debug_wireout[319:288] = data_read_aux;

//----------------------------------------------------------------------------
// Synchronous register updates
//----------------------------------------------------------------------------
always @( posedge sys_clk ) begin
  reset_ram <= control_bus[0];
end

always @( posedge clk ) begin
  if ( reset ) begin
    control_bus_last <= 32'd0;
    init_finished <= 0;
    memory_program <= 0;
  end
  else begin
    control_bus_last <= control_bus;
    if ( memory_program_ack ) begin
      memory_program <= 0;
    end
    else if ( control_bus[1] & ~control_bus_last[1] ) begin
      memory_program <= 1;
    end

    if ( ~memory_busy ) begin
      init_finished <= 1;
    end
  end
end

//----------------------------------------------------------------------------
// Address Decoder
//----------------------------------------------------------------------------
always @( memory_addr or reset ) begin
  if ( reset ) begin
    enable_ram <= 0;
    enable_spi <= 0;
    enable_rj45 <= 0;
    enable_aux <= 0;
    enable_adc_frontend <= 0;
  end
  else begin
    enable_ram <= 0;
    enable_spi <= 0;
    enable_rj45 <= 0;
    enable_aux <= 0;
    enable_adc_frontend <= 0;
    if ( ~memory_addr[25] ) begin
      enable_ram <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00001 | memory_addr[24:20] == 5'b00010 ) begin
      enable_spi <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00011 ) begin
      enable_aux <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00101 ) begin
      enable_rj45 <= 1;
    end
    else if ( memory_addr[24:20] == 5'b00110 ) begin
      enable_adc_frontend <= 1;
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

rj45_led_controller rj45_led_controller_inst (
  .clk ( clk ),
  .reset ( reset ),

  .write_req ( write_req_rj45 ),
  .read_req ( read_req_rj45 ),
  .data_write ( memory_data_write ),
  .data_read ( data_read_rj45 ),
  .address ( memory_addr ),
  .busy ( busy_rj45 ),

  .rj45_led_sck ( rj45_led_sck ),
  .rj45_led_sin ( rj45_led_sin ),
  .rj45_led_lat ( rj45_led_lat ),
  .rj45_led_blk ( rj45_led_blk )
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
  .okEH ( okEHx[0 +: 65] )
);


memory memory_inst (
  .pll_ref_clk ( sys_clk ) ,
  .clk ( clk ),
  .reset_in ( reset_ram ),
  .reset_out ( reset ),

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

  .flash_dq0 ( flash_dq0 ),
  .flash_dq1 ( flash_dq1 ),
  .flash_wb ( flash_wb ),
  .flash_holdb ( flash_holdb ),
  .flash_c ( flash_c ),
  .flash_sb ( flash_sb ),

  .program_req ( memory_program ),
  .program_ack ( memory_program_ack ),
  .program_buffer_empty ( program_buffer_empty ),
  .program_buffer_q ( program_buffer_q ),
  .program_buffer_read ( program_buffer_read ),

  .state ( state ),
  .busy_int ( busy_int )
);


adc_frontend adc_frontend_inst (
  .clk ( clk ),
  .reset ( reset ),
  .adc_clk ( adc_clk ),

  .write_req ( write_req_adc_frontend ),
  .read_req ( read_req_adc_frontend ),
  .data_write ( memory_data_write ),
  .data_read ( data_read_adc_frontend ),
  .addr ( memory_addr ),
  .busy ( busy_adc_frontend ),

  .adc_fco ( adc_fco ),
  .adc_dco ( adc_dco ),
  .adc_dat_a ( adc_dat_a ),
  .adc_dat_b ( adc_dat_b ),
  .adc_dat_c ( adc_dat_c ),
  .adc_dat_d ( adc_dat_d )
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
  .okEH ( okEHx[65 +: 65] ),
  .ep_addr ( 8'h9C ),
  .ep_dataout ( program_buffer_data ),
  .ep_write ( program_buffer_write ),
  .ep_blockstrobe (  ),
  .ep_ready ( (4096 - program_buffer_wrusedw) >= 64 )
);

debug_unit #( .SIZE(DEBUG_SIZE) ) debug_unit_inst (
  .clk ( clk ),
  .reset ( reset_ram | ~init_finished ),
  .debug_wireout ( debug_wireout ),
  .okClk ( okClk ),
  .okHE ( okHE ),
  .okEH ( okEHx[130 +: 65] )
);

endmodule
