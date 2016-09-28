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
// Title       : control_unit_testbench
// Author      : Caleb Fangmeier
// Description : Testbench for the control unit
//
// $Id$
//-------------------------------------------------------------------------
`default_nettype none
`timescale 1ns / 1ps

module control_unit_testbench
  (
    // no I/O for the testbench
  );

// Wires
reg sys_clk;
reg reset;

integer i;

parameter CLK_PERIOD = 10;
parameter MEM_WORDS = 128;

wire        read_req;
wire        write_req;
wire [16:0] addr;
wire [31:0] data_o;
reg  [31:0] data_i;
reg         busy;

/* reg [7:0] mem[0:4096]; // 1k words */
reg [31:0] mem[0:MEM_WORDS-1]; // 1k words

control_unit control_unit_inst (
  .clk ( sys_clk ),
  .reset ( reset ),

  .memory_read_req ( read_req ),
  .memory_write_req ( write_req ),
  .memory_addr ( addr ),
  .memory_data_o ( data_o ),
  .memory_data_i ( data_i ),
  .memory_busy ( busy )
);
initial i = 0;

initial sys_clk = 1'b0;
always #( CLK_PERIOD/2.0 )
  sys_clk = ~sys_clk;

initial reset = 1'b1;
always @( posedge sys_clk ) begin
  i = i + 1;
  if ( i == 2 )
    reset <= 1'b0;
end

initial $readmemh("instructions.txt", mem);

always @(posedge sys_clk or reset) begin
  if ( reset ) begin
    /* //add $r0 $r0 $r1 */
    /* mem[0] = 8'b000011_00; */
    /* mem[1] = 8'b00_0_0000_0; */
    /* mem[2] = 8'b001_0000_0; */
    /* mem[3] = 8'b10_000000; */
    //bal 12
    /* mem[0] = 8'b001001_00; */
    /* mem[1] = 8'b00_000000; */
    /* mem[2] = 8'b00000000; */
    /* mem[3] = 8'b00001100; */

    //jr $r15
    /* mem[12] = 8'b001011_00; */
    /* mem[13] = 8'b00_0_1111_0; */
    /* mem[14] = 8'b000_0000_0; */
    /* mem[15] = 8'b00_000000; */

    /* //ldw $r10 $r0 24 */
    /* mem[0] = 8'b000010_00; */
    /* mem[1] = 8'b00_0_1010_0; */
    /* mem[2] = 8'b00000000; */
    /* mem[3] = 8'b00011000; */

    /* //stw $r10 $r0 28 */
    /* mem[4] = 8'b000110_00; */
    /* mem[5] = 8'b00_0_1010_0; */
    /* mem[6] = 8'b00000000; */
    /* mem[7] = 8'b00011100; */

    //andil $r10 $r0 {}
    /* mem[0] = 8'b011010_00; */
    /* mem[1] = 8'b00_0_1010_0; */
    /* mem[2] = 8'b11111111; */
    /* mem[3] = 8'b11111111; */

    /* //andih $r10 $r10 {} */
    /* mem[4] = 8'b011110_10; */
    /* mem[5] = 8'b10_0_1010_0; */
    /* mem[6] = 8'b10101010; */
    /* mem[7] = 8'b11111111; */

    /* //andih $r10 $r10 {} */
    /* mem[8] = 8'b011110_10; */
    /* mem[9] = 8'b10_0_1010_0; */
    /* mem[10] = 8'b00000000; */
    /* mem[11] = 8'b10101010; */

    /* mem[24] = 8'b10000001; */
    /* mem[25] = 8'b01010101; */
    /* mem[26] = 8'b10101010; */
    /* mem[27] = 8'b01111110; */
  end
  else begin
    busy <= 0;
    if ( read_req ) begin
      data_i <= mem[addr>>2];
    end
    if ( write_req ) begin
      mem[addr>>2] <= data_o;
    end
  end
end

integer j;
reg [7:0] memory [0:15]; // 8 bit memory with 16 entries

initial begin
    for (j=0; j<16; j=j+1) begin
        memory[j] = j;
    end
    $writememb("memory_binary.txt", memory);
    $writememh("memory_hex.txt", memory);
end
endmodule
