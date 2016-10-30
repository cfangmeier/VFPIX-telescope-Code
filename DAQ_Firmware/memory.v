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
// Title       : memory
// Author      : Caleb Fangmeier
// Description : Memory interface
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module memory(
  input  wire pll_ref_clk,
  output wire phy_clk,
  input  wire reset,

  //--------------------------------------------------------------------------
  //------------------------CONTROL INTERFACE---------------------------------
  //--------------------------------------------------------------------------
  input  wire        write_req,
  input  wire        read_req,
  input  wire [31:0] data_write,
  output reg  [31:0] data_read,
  input  wire [25:0] addr,
  output reg         busy,

  //--------------------------------------------------------------------------
  //---------------------------HW INTERFACE-----------------------------------
  //--------------------------------------------------------------------------
  //===RAM===
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

  //===FLASH===
  output wire        flash_dq0,
  input  wire        flash_dq1,
  output wire        flash_wb,
  output wire        flash_holdb,
  output wire        flash_c,
  output wire        flash_sb,
  //--------------------------------------------------------------------------
  //---------------------------PROGRAMMING INTERFACE--------------------------
  //--------------------------------------------------------------------------
  input  wire         program,
  output reg          program_ack,
  input  wire         program_buffer_empty,
  input  wire [31:0]  program_buffer_q,
  output reg          program_buffer_read,

  //--------------------------------------------------------------------------
  //---------------------------******TEMPORARY******--------------------------
  //--------------------------------------------------------------------------
  output wire        local_ready,
  output reg  [5:0]  state,
  output wire [7:0]  flash_data,
  output wire        flash_empty,
  output wire        flash_busy,
  output wire        local_init_done,
  output reg  [6:0]  page_words,
  output reg  [16:0] pages_written,
  output reg  [16:0] pages_to_write,
  output reg         pages_to_write_valid,

  output reg  [24:0] local_address,
  output reg  [31:0] local_wdata,
  output wire [31:0] local_rdata,
  output reg         local_write_req,
  output reg         local_read_req,
  output wire [7:0]  flash_input_shifter,
  output wire        flash_read_buffer_write
  );

//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
// State Enumeration
localparam VOID                         = 6'd00,
           DELAY                        = 6'd01,
           INIT                         = 6'd02,
           IDLE                         = 6'd03,
           PROGRAM_WRITE_ENABLE         = 6'd04,
           PROGRAM_WRITE_ENABLE_B       = 6'd05,
           PROGRAM_WRITE_FINISH         = 6'd06,
           PROGRAM_WRITE_FINISH_B       = 6'd07,
           PROGRAM_START                = 6'd08,
           PROGRAM_PAGE                 = 6'd09,
           PROGRAM_SECTOR_ERASE_ADDR1   = 6'd10,
           PROGRAM_SECTOR_ERASE_ADDR2   = 6'd11,
           PROGRAM_SECTOR_ERASE_ADDR3   = 6'd12,
           PROGRAM_SECTOR_ERASE_EXECUTE = 6'd13,
           PROGRAM_SECTOR_ERASE_FINISH  = 6'd14,
           PROGRAM_ADDR1                = 6'd15,
           PROGRAM_ADDR2                = 6'd16,
           PROGRAM_ADDR3                = 6'd17,
           PROGRAM_DAT1                 = 6'd18,
           PROGRAM_DAT2A                = 6'd19,
           PROGRAM_DAT2B                = 6'd20,
           PROGRAM_DAT2C                = 6'd21,
           PROGRAM_DAT2D                = 6'd22,
           PROGRAM_DAT2E                = 6'd23,
           LOAD_0                       = 6'd24,
           LOAD_1                       = 6'd25,
           LOAD_ADDR1                   = 6'd26,
           LOAD_ADDR2                   = 6'd27,
           LOAD_ADDR3                   = 6'd28,
           LOAD_EXECUTE                 = 6'd29,
           LOAD_WORD1                   = 6'd30,
           LOAD_WORD1B                  = 6'd31,
           LOAD_WORD2                   = 6'd32,
           LOAD_WORD3                   = 6'd33,
           LOAD_WORD4                   = 6'd34,
           READ_1                       = 6'd35,
           READ_2                       = 6'd36,
           WRITE_1                      = 6'd37,
           WRITE_2                      = 6'd38;

// Flash Instruction Codes
localparam FLASH_WREN = 8'b0000_0110,  // WRITE ENABLE
           FLASH_WRDI = 8'b0000_0100,  // WRITE DISABLE
           FLASH_RFSR = 8'b0111_0000,  // READ FLAG STATUS REGISTER
           FLASH_RDSR = 8'b0000_0101,  // READ STATUS REGISTER
           FLASH_BE   = 8'b1100_0111,  // BULK ERASE
           FLASH_SE   = 8'b1101_1000,  // SECTOR ERASE
           FLASH_PP   = 8'b0000_0010,  // PAGE PROGRAM
           FLASH_READ = 8'b0000_0011,  // READ DATA
           FLASH_RDID = 8'b1001_1111;  // READ DEVICE ID
//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
/* wire        local_ready; */
/* wire [31:0] local_rdata; */
wire        local_rdata_valid;
/* wire        local_init_done; */

/* wire        flash_busy; */

wire [7:0]  flash_read_buffer_q;
wire        flash_write_buffer_full;
wire        flash_read_buffer_empty;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------

/* reg  [24:0] local_address; */
/* reg         local_write_req; */
/* reg         local_read_req; */
reg         local_burstbegin;
/* reg  [31:0] local_wdata; */

/* reg  [5:0]  state; */
reg  [5:0]  state_callback;
reg  [7:0]  delay_counter;

/* reg  [16:0] pages_to_write; */
/* reg  [16:0] pages_written; */
/* reg         pages_to_write_valid; */

reg  [16:0] pages_to_read;
reg  [16:0] pages_read;
reg         pages_to_read_valid;

/* reg  [6:0]  page_words; */
reg  [31:0] page_word;
reg  [23:0] page_address;

reg  [7:0]  flash_instruction;
reg         flash_execute;
reg  [8:0]  flash_bytes_to_read;

reg  [7:0]  flash_write_buffer_data;
reg         flash_write_buffer_write;
reg         flash_read_buffer_read;

assign flash_data = flash_read_buffer_q;
assign flash_empty = flash_read_buffer_empty;

//----------------------------------------------------------------------------
// State Machine
//----------------------------------------------------------------------------

always @( posedge phy_clk ) begin
  local_write_req <= 0;
  local_read_req <= 0;
  local_burstbegin <= 0;
  data_read <= 32'h0;

  program_buffer_read <= 0;

  flash_execute <= 0;
  flash_read_buffer_read <= 0;
  flash_write_buffer_write <= 0;

  if ( reset  | ~local_init_done) begin
    state <= INIT;
    busy <= 1;
    program_ack <= 0;
  end
  else begin
    case ( state )
      INIT: begin
        if ( local_ready && local_init_done ) begin
          state <= IDLE;
          busy <= program;
        end
        else begin
          busy <= 1;
        end
      end
      IDLE: begin
        program_ack <= 0;
        if ( program ) begin
          state <= PROGRAM_START;
          program_ack <= 1;
          busy <= 1;
        end
        else if ( write_req ) begin
          state <= WRITE_1;
          local_wdata <= data_write;
          local_address <= addr[24:0];
          busy <= 1;
        end
        else if ( read_req ) begin
          state <= READ_1;
          local_address <= addr[24:0];
          busy <= 1;
        end
      end
      DELAY: begin
        if ( delay_counter == 8'd0 ) begin
          state <= state_callback;
          state_callback <= VOID;
        end
        else begin
          delay_counter <= delay_counter - 8'd1;
        end
      end
//============================================================================
//==========================PROGRAM SEQUENCE==================================
//============================================================================
      PROGRAM_WRITE_ENABLE: begin
        if ( !flash_busy ) begin
          state <= PROGRAM_WRITE_ENABLE_B;
          flash_instruction <= FLASH_WREN;
          flash_bytes_to_read <= 0;
          flash_execute <= 1;
        end
      end
      PROGRAM_WRITE_ENABLE_B: begin
        if ( !flash_busy ) begin
          state <= state_callback;
          state_callback <= VOID;
        end
      end
      PROGRAM_WRITE_FINISH: begin
        if ( !flash_busy ) begin
          state <= PROGRAM_WRITE_FINISH_B;
          flash_instruction <= FLASH_RDSR;
          flash_bytes_to_read <= 1;
          flash_execute <= 1;
        end
      end
      PROGRAM_WRITE_FINISH_B: begin
        if ( !flash_busy  && !flash_read_buffer_empty ) begin
          flash_read_buffer_read <= 1;
          if ( ~flash_read_buffer_q[0] ) begin
            state <= state_callback;
            state_callback <= VOID;
          end
          else begin
            state <= PROGRAM_WRITE_FINISH;
          end
        end
      end
      PROGRAM_START: begin
        if ( !flash_busy ) begin
          state <= PROGRAM_PAGE;
          pages_to_write_valid <= 0;
          pages_written <= 0;
        end
      end
      PROGRAM_PAGE: begin
        if ( pages_to_write_valid && (pages_written == pages_to_write) ) begin
          state <= LOAD_0;
        end
        else begin
          state <= PROGRAM_WRITE_ENABLE;
          if ( (pages_written % 16'd256) == 0 ) begin
            state_callback <= PROGRAM_SECTOR_ERASE_ADDR1;
          end
          else begin
            state_callback <= PROGRAM_ADDR1;
          end
          page_words <= 0;
          page_address <= {pages_written[15:0]+16'h800, 8'h00};
        end
      end
      PROGRAM_SECTOR_ERASE_ADDR1: begin
        state <= PROGRAM_SECTOR_ERASE_ADDR2;
        flash_write_buffer_data <= page_address[23:16];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_SECTOR_ERASE_ADDR2: begin
        state <= PROGRAM_SECTOR_ERASE_ADDR3;
        flash_write_buffer_data <= page_address[15:8];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_SECTOR_ERASE_ADDR3: begin
        state <= PROGRAM_SECTOR_ERASE_EXECUTE;
        flash_write_buffer_data <= page_address[7:0];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_SECTOR_ERASE_EXECUTE: begin
        state <= PROGRAM_WRITE_FINISH;
        state_callback <= PROGRAM_SECTOR_ERASE_FINISH;

        flash_instruction <= FLASH_SE;
        flash_bytes_to_read <= 0;
        flash_execute <= 1;
      end
      PROGRAM_SECTOR_ERASE_FINISH: begin
        state <= PROGRAM_WRITE_ENABLE;
        state_callback <= PROGRAM_ADDR1;
      end
      PROGRAM_ADDR1: begin
        state <= PROGRAM_ADDR2;
        flash_write_buffer_data <= page_address[23:16];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_ADDR2: begin
        state <= PROGRAM_ADDR3;
        flash_write_buffer_data <= page_address[15:8];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_ADDR3: begin
        state <= PROGRAM_DAT1;
        flash_write_buffer_data <= page_address[7:0];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_DAT1: begin
        if ( page_words == 7'd64 ) begin
          state <= PROGRAM_WRITE_FINISH;
          state_callback <= PROGRAM_PAGE;

          flash_instruction <= FLASH_PP;
          flash_execute <= 1;
          flash_bytes_to_read <= 0;

          pages_written <= pages_written + 17'd1;
        end
        else if ( !program_buffer_empty ) begin
          program_buffer_read <= 1;
          state <= DELAY;
          delay_counter <= 0;
          state_callback <= PROGRAM_DAT2A;
        end
      end
      PROGRAM_DAT2A: begin
        state <= PROGRAM_DAT2B;
        page_word <= program_buffer_q;
        if ( !pages_to_write_valid && (page_words == 0) ) begin
          pages_to_write <= program_buffer_q[16:0];
          pages_to_write_valid <= 1;
        end
      end
      PROGRAM_DAT2B: begin
        state <= PROGRAM_DAT2C;
        flash_write_buffer_data <= page_word[31:24];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_DAT2C: begin
        state <= PROGRAM_DAT2D;
        flash_write_buffer_data <= page_word[23:16];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_DAT2D: begin
        state <= PROGRAM_DAT2E;
        flash_write_buffer_data <= page_word[15:8];
        flash_write_buffer_write <= 1;
      end
      PROGRAM_DAT2E: begin
        state <= PROGRAM_DAT1;
        flash_write_buffer_data <= page_word[7:0];
        flash_write_buffer_write <= 1;
        page_words <= (page_words + 7'd1);
      end
//============================================================================
//==========================LOAD SEQUENCE=====================================
//============================================================================
      LOAD_0: begin
        state <= LOAD_1;
        pages_to_read_valid <= 0;
        pages_read <= 0;
        page_address <= 0;
      end
      LOAD_1: begin
        if ( pages_to_read_valid && (pages_read == pages_to_read) ) begin
          state <= IDLE;
        end
        else begin
          state <= LOAD_ADDR1;
          page_address <= {pages_read[15:0]+16'h800, 8'h00};
        end
      end
      LOAD_ADDR1: begin
        state <= LOAD_ADDR2;
        flash_write_buffer_data <= page_address[23:16];
        flash_write_buffer_write <= 1;
      end
      LOAD_ADDR2: begin
        state <= LOAD_ADDR3;
        flash_write_buffer_data <= page_address[15:8];
        flash_write_buffer_write <= 1;
      end
      LOAD_ADDR3: begin
        state <= LOAD_EXECUTE;
        flash_write_buffer_data <= page_address[7:0];
        flash_write_buffer_write <= 1;
      end
      LOAD_EXECUTE: begin
        state <= LOAD_WORD1;
        flash_instruction <= FLASH_READ;
        flash_execute <= 1;
        flash_bytes_to_read <= 9'd256;
        page_words <= 0;
      end
      LOAD_WORD1: begin
        if ( ~flash_busy ) begin
          if ( page_words == 64 ) begin
            pages_read <= pages_read + 17'd1;
            state <= LOAD_1;
          end
          else begin
            state <= LOAD_WORD1B;
            flash_read_buffer_read <= 1;
          end
        end
      end
      LOAD_WORD1B: begin
        state <= LOAD_WORD2;
        flash_read_buffer_read <= 1;
        page_word[31:24] <= flash_read_buffer_q;
      end
      LOAD_WORD2: begin
        state <= LOAD_WORD3;
        flash_read_buffer_read <= 1;
        page_word[23:16] <= flash_read_buffer_q;
      end
      LOAD_WORD3: begin
        state <= LOAD_WORD4;
        flash_read_buffer_read <= 1;
        page_word[15:8] <= flash_read_buffer_q;
      end
      LOAD_WORD4: begin
        state <= WRITE_1;
        state_callback <= LOAD_WORD1;
        local_wdata <= {page_word[31:8], flash_read_buffer_q};
        page_word[7:0] <= flash_read_buffer_q;
        local_address <= {2'b00, pages_read, page_words[5:0]};
        if ( page_words == 0 && pages_read == 0 ) begin
          pages_to_read <= {page_word[15:8], flash_read_buffer_q};
          pages_to_read_valid <= 1;
        end
        page_words <= page_words + 7'd1;
      end
//============================================================================
//==========================WRITE SEQUENCE====================================
//============================================================================
      WRITE_1: begin
        if ( local_init_done & local_ready ) begin
          state <= WRITE_2;
          local_write_req <= 1;
          local_burstbegin <= 1;
        end
      end
      WRITE_2: begin
        if ( local_ready ) begin
          busy <= 0;
          if ( state_callback != VOID ) begin
            state <= state_callback;
            state_callback <= VOID;
          end
          else begin
            state <= IDLE;
          end
        end
      end
//============================================================================
//==========================READ SEQUENCE=====================================
//============================================================================
      READ_1: begin
        if ( local_init_done & local_ready ) begin
          state <= READ_2;
          local_read_req <= 1;
          local_burstbegin <= 1;
        end
      end
      READ_2: begin
        if ( local_ready & local_rdata_valid ) begin
          data_read <= local_rdata;
          busy <= 0;
          if ( state_callback != VOID ) begin
            state <= state_callback;
            state_callback <= VOID;
          end
          else begin
            state <= IDLE;
          end
        end
      end
    endcase
  end
end


//----------------------------------------------------------------------------
// Instantiations
//----------------------------------------------------------------------------

ram_controller ram_controller_inst(
  .pll_ref_clk ( pll_ref_clk ),
  .phy_clk ( phy_clk ),
  .global_reset_n ( ~reset ),
  .soft_reset_n ( 1'b1 ),
  .reset_phy_clk_n (  ),

  .local_address ( local_address ),
  .local_write_req ( local_write_req ),
  .local_read_req ( local_read_req ),
  .local_burstbegin ( local_burstbegin ),
  .local_wdata ( local_wdata ),
  .local_be ( 4'hF ),
  .local_size ( 3'd1 ),
  .local_ready ( local_ready ),
  .local_rdata ( local_rdata ),
  .local_rdata_valid ( local_rdata_valid ),
  .local_refresh_ack ( ),
  .local_init_done ( local_init_done ),


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

  .aux_full_rate_clk ( ),
  .aux_half_rate_clk ( ),
  .reset_request_n (  )
);

flash_interface flash_interface_inst (
  .clk ( phy_clk ),
  .reset ( reset | ~local_init_done ),

  .instruction ( flash_instruction ),
  .execute ( flash_execute ),
  .bytes_to_read ( flash_bytes_to_read ),
  .busy ( flash_busy ),

  .write_buffer_data ( flash_write_buffer_data ),
  .write_buffer_write ( flash_write_buffer_write ),
  .write_buffer_full ( flash_write_buffer_full ),

  .read_buffer_q ( flash_read_buffer_q ),
  .read_buffer_empty ( flash_read_buffer_empty ),
  .read_buffer_read ( flash_read_buffer_read ),

  .flash_dq0 ( flash_dq0 ),
  .flash_dq1 ( flash_dq1 ),
  .flash_wb ( flash_wb ),
  .flash_holdb ( flash_holdb ),
  .flash_c ( flash_c ),
  .flash_sb ( flash_sb ),

  .input_shifter ( flash_input_shifter ),
  .read_buffer_write ( flash_read_buffer_write )
);


endmodule
