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
// Title       : register_space
// Author      : Caleb Fangmeier
// Description : A listing of internal registers and a description of the 
//               register address space.
//
//  The WRITE_REG and READ_REG instructions use the following addressing
//  scheme. There are 32 bits in the instruction. The first five are the
//  instruction specifier. The next two bits (SEL) determine which device
//  contains the register to be written to.
//    SEL | Device
//    ----+-------
//    00  | ADC
//    01  | DAC
//    10  | Internal
//    11  | Reserved
//  Depending on the value of SEL, the remaining 23 bits are interpreted
//  slightly differently.
//  SEL_ADC
//    DATA: A AARR RRRR RRDD DDDD DDXX XXXX
//          LSB                           MSB
//    A: 3-bit ADC Selector
//    R: 8-bit ADC Register Address
//    D: 8-bit ADC Register Data (if writing)
//  SEL_DAC
//    DATA: S AAAA CCCC DDDD DDDD DDDD XXXX
//          LSB                           MSB
//    S: 1-bit rngdac/supdac_n device select
//    4: 4-bit DAC channel selector
//    B: 12-bit Register Data (if writing)
//  SEL_INT
//    DATA: A AAAA DDDD DDDD DDDD DDDD XXXX
//          LSB                           MSB
//    A: 5-bit Register Address
//    D: 16-bit Register Data (if writing)
//
// $Id$
//-------------------------------------------------------------------------

//
// Internal Register Listing
//
parameter SEL_ADC = 2'b00;
parameter SEL_DAC = 2'b01;
parameter SEL_INT = 2'b10;
parameter SEL_RES = 2'b11;

parameter RJ45_LEDS = 5'h10;
