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
// Description : This is the control unit for the the firmware.
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module control_unit(
  input  wire         clk,  // 50 MHz
  input  wire         reset,

  output reg         memory_read_req,
  output reg         memory_write_req,
  output wire [25:0] memory_addr,
  output wire [31:0] memory_data_write,
  input  wire [31:0] memory_data_read,
  input  wire        memory_busy
);


//----------------------------------------------------------------------------
// Parameters
//----------------------------------------------------------------------------
// State Listing
localparam STAGE_1     = 3'h1,
           STAGE_2     = 3'h2,
           STAGE_3     = 3'h3,
           STAGE_4     = 3'h4,
           STAGE_4_MEM = 3'h6,
           STAGE_5     = 3'h5;
// ALU Operations
localparam ALU_SUB  = 5'b00000,
           ALU_SLL  = 5'b00001,
           ALU_ADD  = 5'b00010,
           ALU_XOR  = 5'b00100,
           ALU_OR   = 5'b00101,
           ALU_AND  = 5'b00110,
           ALU_MULT = 5'b01001;

// Op-Code Enumeration
localparam OP_NOOP  = 6'b00_0000,
           OP_ALU   = 6'b00_0011,
           OP_JR    = 6'b00_1011,
           OP_SPUSH = 6'b00_0111,
           OP_SPOP  = 6'b00_1111,
           OP_B     = 6'b00_0001,
           OP_BAL   = 6'b00_1001,
           OP_LDW   = 6'b00_0010,
           OP_STW   = 6'b00_0110,
           OP_ADDIL = 6'b00_1010,
           OP_ADDIH = 6'b00_1110,
           OP_ORIL  = 6'b01_0010,
           OP_ORIH  = 6'b01_0110,
           OP_ANDIL = 6'b01_1010,
           OP_ANDIH = 6'b01_1110;

localparam COND_EQ  = 4'b0000, // Z==1
           COND_NE  = 4'b0001, // Z==0
           COND_HS  = 4'b0010, // C==1
           COND_LO  = 4'b0011, // C==0
           COND_MI  = 4'b0100, // N==1
           COND_PL  = 4'b0101, // N==0
           COND_VS  = 4'b0110, // V==1
           COND_VC  = 4'b0111, // V==0
           COND_HI  = 4'b1000, // C==1 & Z==0
           COND_LS  = 4'b1001, // C==0 | Z==1
           COND_GE  = 4'b1010, // (N==1 & V==1) | (N==0 & V==0)
           COND_LT  = 4'b1011, // (N==1 & V==0) | (N==0 & V==1)
           COND_GT  = 4'b1100, // Z==0 | (N==1 & V==1) | (N==0 & V==0)
           COND_LE  = 4'b1101, // Z==1 | (N==1 & V==0) | (N==0 & V==1)
           COND_AL  = 4'b1110, // 1
           COND_NV  = 4'b1111; // 0

//----------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------
wire [31:0] alu_inA;
wire [31:0] alu_inB;

wire [31:0] wr_out_a;
wire [31:0] wr_out_b;

wire [31:0] muxB_out;
wire [31:0] muxY_out;
wire [24:0] muxPC_out;
wire [15:0] muxINC_out;
wire [25:0] muxMA_out;

wire lshift_result;
wire lshift_overflow;
wire lshift_underflow;
wire multiply_result;

//----------------------------------------------------------------------------
// Registers
//----------------------------------------------------------------------------
// Working Registers
reg [31:0] wr[15:0];
reg [3:0]  wr_addr_a;
reg [3:0]  wr_addr_b;
reg [3:0]  wr_addr_c;
reg        wr_write;

// Program Counter
reg [24:0] pc;
reg [24:0] ret_addr;
// Instruction Register
reg [31:0] ir;

// Intermediate Registers
reg [31:0] ra;
reg [31:0] rax;
reg [31:0] rb;
reg [31:0] rz;
reg [31:0] ry;
reg [31:0] rm;

// ALU Status Registers
reg  [32:0] alu_out;
reg alu_comb_N; // Result Negative
reg alu_comb_Z; // Result Zero
reg alu_comb_C; // Carry
reg alu_comb_V; // Overflow
// Persistent flags that only get updated when set-bit is set
reg N;
reg Z;
reg C;
reg V;

reg status_pass;
reg status_pass_temp;

// Control Unit outputs
reg        pc_enable;
reg        ir_enable;
reg [31:0] immediate;
reg [31:0] immediate_temp;
reg [4:0]  alu_op;
reg [2:0]  cpu_stage;
reg [2:0]  cpu_stage_next;

reg        muxB_sel;
reg [1:0]  muxY_sel;
reg        muxPC_sel;
reg        muxINC_sel;
reg [1:0]  muxMA_sel;
//----------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------
assign muxB_out = (muxB_sel == 1'h0) ? rb : immediate;
assign muxY_out = (muxY_sel == 2'h0) ? rz            :
                  (muxY_sel == 2'h1) ? memory_data_read :
                  (muxY_sel == 2'h2) ? ret_addr + 1  :
                  /* else         */   alu_out[31:0];
assign alu_inA = ra;
assign alu_inB = muxB_out;

assign muxINC_out = (muxINC_sel == 1'h0) ? 16'h1 : immediate[15:0];
assign muxPC_out = (muxPC_sel == 1'h0) ? ra[24:0] : pc + muxINC_out;

assign muxMA_out = (muxMA_sel == 2'h0) ? rz[25:0] :
                   (muxMA_sel == 2'h1) ? {1'b0,pc}:
                   (muxMA_sel == 2'h2) ? rax[25:0]:
                   /* else         */    0;

assign wr_out_a = (wr_addr_a == 0) ? 0: wr[wr_addr_a-1];
assign wr_out_b = (wr_addr_b == 0) ? 0: wr[wr_addr_b-1];

assign memory_data_write = rm;
assign memory_addr = muxMA_out[25:0];


//----------------------------------------------------------------------------
// ALU
//----------------------------------------------------------------------------
always @(alu_inA or alu_inB or alu_op) begin
  case ( alu_op )
    ALU_ADD:
      alu_out <= alu_inA + alu_inB;
    ALU_SUB:
      alu_out <= alu_inA - alu_inB;
    ALU_AND:
      alu_out <= {1'b0, alu_inA & alu_inB};
    ALU_OR:
      alu_out <= {1'b0, alu_inA | alu_inB};
    ALU_XOR:
      alu_out <= {1'b0, alu_inA ^ alu_inB};
    ALU_SLL:
      alu_out <= {1'b0, lshift_result};
    ALU_MULT:
      alu_out <= {1'b0, multiply_result};
    default:
      alu_out <= 0;
  endcase
end

//----------------------------------------------------------------------------
// ALU Status Flags
//----------------------------------------------------------------------------
always @(alu_inA or alu_inB or alu_op or alu_out) begin
  alu_comb_N <= alu_out[31];
  alu_comb_Z <= (alu_out == 0);
  case ( alu_op )
    ALU_ADD: begin
      alu_comb_V <= (alu_inA[31] & alu_inB[31] & ~alu_out[31]) |
                   (~alu_inA[31] & ~alu_inB[31] & alu_out[31]);
      alu_comb_C <= alu_out[32];
    end
    ALU_SUB: begin
      alu_comb_V <= (alu_inA[31] & ~alu_inB[31] & ~alu_out[31]) |
                   (~alu_inA[31] & alu_inB[31] & alu_out[31]);
      alu_comb_C <= ~alu_out[32];
    end
    default: begin
      alu_comb_V <= 0;
      alu_comb_C <= 0;
    end
  endcase
end


//----------------------------------------------------------------------------
// PC Logic
//----------------------------------------------------------------------------
always @( posedge clk ) begin
  if ( reset )
    pc <= 0;
  else if ( pc_enable )
    pc <= muxPC_out;
end

//----------------------------------------------------------------------------
// IR Logic
//----------------------------------------------------------------------------
always @( posedge clk ) begin
  if ( reset )
    ir <= 0;
  else if ( ir_enable )
    ir <= memory_data_read;
end

//----------------------------------------------------------------------------
// Working Registers
//----------------------------------------------------------------------------
integer j;
always @( posedge clk ) begin
  if ( reset ) begin
    for (j=0; j < 16; j=j+1) begin
      /* wr[j] <= j; */
      wr[j] <= 0;
    end
  end
  else begin
    if ( wr_write ) begin
      if ( wr_addr_c != 0 ) begin
        wr[wr_addr_c-1] <= ry;
      end
    end
  end
end

//----------------------------------------------------------------------------
// Register clocking
//----------------------------------------------------------------------------
always @( posedge clk ) begin
  if ( reset ) begin
    ra <= 0;
    rax <= 0;
    rb <= 0;
    rz <= 0;
    rm <= 0;
    ry <= 0;
    ret_addr <= 0;
    cpu_stage <= STAGE_5;
    immediate <= 0;
    N <= 0;
    Z <= 0;
    C <= 0;
    V <= 0;
  end
  else begin
    ra <= wr_out_a;
    rax <= ra;
    rb <= wr_out_b;
    rz <= alu_out[31:0];
    rm <= rb;
    ry <= muxY_out;
    ret_addr <= pc;
    cpu_stage <= cpu_stage_next;
    immediate <= immediate_temp;
    if (ir[21] & cpu_stage == STAGE_3) begin
      N <= alu_comb_N;
      Z <= alu_comb_Z;
      C <= alu_comb_C;
      V <= alu_comb_V;
    end
    if (cpu_stage == STAGE_2 ) begin
      status_pass <= status_pass_temp;
    end
  end
end

//----------------------------------------------------------------------------
// Condition Codes
//----------------------------------------------------------------------------
always @(ir or Z or C or N or V) begin
  case ( ir[25:22] )
    COND_EQ: begin
      status_pass_temp = Z;
    end
    COND_NE: begin
      status_pass_temp = ~Z;
    end
    COND_HS: begin
      status_pass_temp = C;
    end
    COND_LO: begin
      status_pass_temp = ~C;
    end
    COND_MI: begin
      status_pass_temp = N;
    end
    COND_PL: begin
      status_pass_temp = ~N;
    end
    COND_VS: begin
      status_pass_temp = V;
    end
    COND_VC: begin
      status_pass_temp = ~V;
    end
    COND_HI: begin
      status_pass_temp = C & ~Z;
    end
    COND_LS: begin
      status_pass_temp = ~C | Z;
    end
    COND_GE: begin
      status_pass_temp = (N & V) | (~N & ~V);
    end
    COND_LT: begin
      status_pass_temp = (N & ~V) | (~N & V);
    end
    COND_GT: begin
      status_pass_temp = ~Z & (N & V) | (~N & ~V);
    end
    COND_LE: begin
      status_pass_temp = Z | (N & ~V) | (~N & V);
    end
    COND_AL: begin
      status_pass_temp = 1;
    end
    COND_NV: begin
      status_pass_temp = 0;
    end
  endcase
end

//----------------------------------------------------------------------------
// Control Unit
//----------------------------------------------------------------------------
always @(cpu_stage or ir or memory_busy) begin
  if ( reset ) begin
    cpu_stage_next <= STAGE_5;
    pc_enable <= 0;
    immediate_temp <= 0;
    alu_op <= 0;
    memory_read_req <= 0;
    memory_write_req <= 0;
  end
  else begin
    // Set defaults
    pc_enable <= 0;
    ir_enable <= 0;
    immediate_temp <= 0;
    alu_op <= 0;
    muxB_sel <= 0;
    muxY_sel <= 0;
    muxPC_sel <= 1;
    muxINC_sel <= 0;
    muxMA_sel <= 0;
    memory_read_req <= 0;
    memory_write_req <= 0;
    wr_write <= 0;
    case ( cpu_stage )
      STAGE_1: begin
        if ( !memory_busy ) begin
          ir_enable <= 1;
          cpu_stage_next <= STAGE_2;
        end
      end // END STAGE_1
      STAGE_2: begin
        cpu_stage_next <= STAGE_3;
        case ( ir[31:26] )
          OP_ALU: begin
            wr_addr_a <= ir[20:17];
            wr_addr_b <= ir[16:13];
          end
          OP_JR: begin
            wr_addr_a <= ir[20:17];
            wr_addr_b <= ir[16:13];
          end
          OP_SPUSH: begin
            wr_addr_a <= 4'd14;
            wr_addr_b <= ir[12:9];
            immediate_temp <= 4;
          end
          OP_SPOP: begin
            wr_addr_a <= 4'd14;
            immediate_temp <= 4;
          end
          OP_B: begin
            if ( ir[15] )
              immediate_temp <= {16'hFFFF, ir[15:0]};
            else
              immediate_temp <= {16'h0000, ir[15:0]};
          end
          OP_BAL: begin
            if ( ir[15] )
              immediate_temp <= {16'hFFFF, ir[15:0]};
            else
              immediate_temp <= {16'h0000, ir[15:0]};
          end
          OP_LDW: begin
            wr_addr_a <= ir[25:22];
            if ( ir[15] )
              immediate_temp <= {16'hFFFF, ir[15:0]};
            else
              immediate_temp <= {16'h0000, ir[15:0]};
          end
          OP_STW: begin
            wr_addr_a <= ir[25:22];
            wr_addr_b <= ir[20:17];
            if ( ir[15] )
              immediate_temp <= {16'hFFFF, ir[15:0]};
            else
              immediate_temp <= {16'h0000, ir[15:0]};
          end
          OP_ADDIL: begin
            wr_addr_a <= ir[25:22];
            if ( ir[15] )
              immediate_temp <= {16'hFFFF, ir[15:0]};
            else
              immediate_temp <= {16'h0000, ir[15:0]};
          end
          OP_ADDIH: begin
            wr_addr_a <= ir[25:22];
            immediate_temp <= {ir[15:0], 16'h0000};
          end
          OP_ORIL: begin
            wr_addr_a <= ir[25:22];
            immediate_temp <= {16'h0000, ir[15:0]};
          end
          OP_ORIH: begin
            wr_addr_a <= ir[25:22];
            immediate_temp <= {ir[15:0], 16'h0000};
          end
          OP_ANDIL: begin
            wr_addr_a <= ir[25:22];
            immediate_temp <= {16'hFFFF, ir[15:0]};
          end
          OP_ANDIH: begin
            wr_addr_a <= ir[25:22];
            immediate_temp <= {ir[15:0], 16'hFFFF};
          end
          default: begin
          end
        endcase
      end // END STAGE_2
      STAGE_3: begin
        cpu_stage_next <= STAGE_4;
        pc_enable <= 1;
        case ( ir[31:26] )
          OP_ALU: begin
            muxB_sel <= 0;
            alu_op <= ir[8:4];
          end
          OP_JR: begin
            if ( status_pass ) begin
              muxPC_sel <= 0;
            end
          end
          OP_SPUSH: begin
            muxB_sel <= 1;
            alu_op <= ALU_SUB;
            muxY_sel <= 3;
          end
          OP_SPOP: begin
            muxB_sel <= 1;
            alu_op <= ALU_ADD;
            muxY_sel <= 3;
          end
          OP_B: begin
            if ( status_pass ) begin
              muxINC_sel <= 1;
            end
          end
          OP_BAL: begin
            if ( status_pass ) begin
              muxINC_sel <= 1;
            end
          end
          OP_LDW: begin
            muxB_sel <= 1;
            alu_op <= ALU_ADD;
          end
          OP_STW: begin
            muxB_sel <= 1;
            alu_op <= ALU_ADD;
          end
          OP_ADDIL: begin
            muxB_sel <= 1;
            alu_op <= ALU_ADD;
          end
          OP_ADDIH: begin
            muxB_sel <= 1;
            alu_op <= ALU_ADD;
          end
          OP_ORIL: begin
            muxB_sel <= 1;
            alu_op <= ALU_OR;
          end
          OP_ORIH: begin
            muxB_sel <= 1;
            alu_op <= ALU_OR;
          end
          OP_ANDIL: begin
            muxB_sel <= 1;
            alu_op <= ALU_AND;
          end
          OP_ANDIH: begin
            muxB_sel <= 1;
            alu_op <= ALU_AND;
          end
          default: begin
          end
        endcase
      end // END STAGE_3
      STAGE_4: begin
        cpu_stage_next <= STAGE_5;
        case ( ir[31:26] )
          OP_ALU: begin
            muxY_sel <= 0;
          end
          OP_SPUSH: begin
            wr_addr_c <= 14;
            muxMA_sel <= 0;
            if ( status_pass ) begin
              wr_write <= 1;
              memory_write_req <= 1;
              cpu_stage_next <= STAGE_4_MEM;
            end
            else begin
              cpu_stage_next <= STAGE_5;
            end
          end
          OP_SPOP: begin
            wr_addr_c <= 14;
            muxMA_sel <= 2;
            if ( status_pass ) begin
              wr_write <= 1;
              memory_read_req <= 1;
              cpu_stage_next <= STAGE_4_MEM;
            end
            else begin
              cpu_stage_next <= STAGE_5;
            end
          end
          OP_BAL: begin
            muxY_sel <= 2;
          end
          OP_LDW: begin
            muxMA_sel <= 0;
            memory_read_req <= 1;
            cpu_stage_next <= STAGE_4_MEM;
          end
          OP_STW: begin
            muxMA_sel <= 0;
            memory_write_req <= 1;
            cpu_stage_next <= STAGE_4_MEM;
          end
          OP_ADDIL: begin
            muxY_sel <= 0;
          end
          OP_ADDIH: begin
            muxY_sel <= 0;
          end
          OP_ORIL: begin
            muxY_sel <= 0;
          end
          OP_ORIH: begin
            muxY_sel <= 0;
          end
          OP_ANDIL: begin
            muxY_sel <= 0;
          end
          OP_ANDIH: begin
            muxY_sel <= 0;
          end
          default: begin
          end
        endcase
      end // END STAGE_4
      STAGE_4_MEM: begin  // Stalls while waiting for data
        cpu_stage_next <= STAGE_4_MEM;
        if ( !memory_busy ) begin
          cpu_stage_next <= STAGE_5;
          muxY_sel <= 1;
        end
      end
      STAGE_5: begin
        cpu_stage_next <= STAGE_1;
        muxMA_sel <= 1;
        memory_read_req <= 1;
        case ( ir[31:26] )
          OP_ALU: begin
            wr_write <= status_pass;
            wr_addr_c <= ir[12:9];
          end
          OP_BAL: begin
            wr_write <= status_pass;
            wr_addr_c <= 15;
          end
          OP_LDW: begin
            wr_write <= 1;
            wr_addr_c <= ir[20:17];
          end
          OP_ADDIL: begin
            wr_write <= 1;
            wr_addr_c <= ir[20:17];
          end
          OP_ADDIH: begin
            wr_write <= 1;
            wr_addr_c <= ir[20:17];
          end
          OP_ORIL: begin
            wr_write <= 1;
            wr_addr_c <= ir[20:17];
          end
          OP_ORIH: begin
            wr_write <= 1;
            wr_addr_c <= ir[20:17];
          end
          OP_ANDIL: begin
            wr_write <= 1;
            wr_addr_c <= ir[20:17];
          end
          OP_ANDIH: begin
            wr_write <= 1;
            wr_addr_c <= ir[20:17];
          end
          OP_SPOP: begin
            wr_write <= status_pass;
            wr_addr_c <= ir[12:9];
          end
          default: begin
          end
        endcase
      end // END STAGE_5
    endcase // END CASE stage
  end // END ELSE
end  // END ALWAYS


lshift  lshift_inst (
  .data ( alu_inA ),
  .distance ( alu_inB[4:0] ),
  .overflow ( lshift_overflow ),
  .result ( lshift_result ),
  .underflow ( lshift_underflow )
);

multiplier  multiplier_inst (
  .dataa ( alu_inA[15:0] ),
  .datab ( alu_inB[15:0] ),
  .result ( multiply_result )
);

endmodule
