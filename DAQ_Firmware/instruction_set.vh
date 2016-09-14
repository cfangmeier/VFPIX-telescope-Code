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
// Title       : instruction_set
// Author      : Caleb Fangmeier
// Description : A detailed description of the instruction set implemented by
//               the DAQ firmware.
//
// $Id$
//-------------------------------------------------------------------------

parameter NOOP          = 5'h00;
/* NOOP
 * This is the no-op command. Needed for padding data in
 * Input command stream.
 * FORMAT:
 * 0000 0XXX XXXX XXXX XXXX XXXX XXXX XXXX
 * MSB                                   LSB
 */

parameter WRITE_REG     = 5'h01;
/* WRITE_REG
 * Write to register. Sets one of the internal registers.
 * FORMAT:
 * 0000 110A AAAD DDDD DDDD DDDD DDDX XXXX
 * MSB                                   LSB
 * A: 4-bit Register Address
 * D: 16-bit Register Data
 */

parameter READ_REG     = 5'h02;
/*
 * READ_REG:Internal
 *   Read from internal register. Places its data into the readback buffer.
 *   FORMAT:
 *   0001 010A AAAX XXXX XXXX XXXX XXXX XXXX
 *   MSB                                   LSB
 *   A: 4-bit Register Address
 * READ_REG:ADC
 *   Read from ADC register. Places its data into the readback buffer.
 *   FORMAT:
 *   0001 000A AARR RRRR RRXX DXXX XXXX XXXX
 *   MSB                                   LSB
 *   A: 3-bit ADC select
 *   R: 8-bit register address
 * READ_REG:DAC
 *   Read from DAC register. Not implemented. Places null onto readback
 *   buffer.
 *   FORMAT:
 *   0001 001X XXXX XXXX XXXX XXXX XXXX XXXX
 *   MSB                                   LSB
 */

parameter WRITE_RAM = 5'h03;
/* WRITE_RAM
 * Copies the contents of registers {ram_buf_high,ram_buf_low}
 * to RAM at the specified address.
 * FORMAT:
 * 0001 1AAA AAAA AAAA AAAA AAAA AAAA AAXX
 * MSB                                   LSB
 * A: 25-bit RAM Address
 */

parameter READ_RAM = 5'h04;
/* READ_RAM
 * Reads ram_read_count 32-bit words starting at the specified
 * address in RAM. Places the data into the readback buffer.
 * FORMAT:
 * 0010 0AAA AAAA AAAA AAAA AAAA AAAA AAXX
 * MSB                                   LSB
 * A: 25-bit Register Address
 */
