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
// Title       : Signal Cross Domain
// Author      : Caleb Fangmeier
// Description : Clock Crossing For a signal bus. Modified from source found
// here: http://fpga4fun.com/CrossClockDomain1.html
// $Id$
//-------------------------------------------------------------------------
module signal_cross_domain #(parameter N=1) (
    input clkA,   // we actually don't need clkA in that example, but it is here for completeness as we'll need it in further examples
    input [N-1:0] SignalIn_clkA,
    input clkB,
    output [N-1:0] SignalOut_clkB
);

// We use a two-stages shift-register to synchronize SignalIn_clkA to the clkB clock domain
reg [N-1:0] SyncA_clkB_0;
reg [N-1:0] SyncA_clkB_1;
always @(posedge clkB) SyncA_clkB_0 <= SignalIn_clkA;   // notice that we use clkB
always @(posedge clkB) SyncA_clkB_1 <= SyncA_clkB_0;   // notice that we use clkB

assign SignalOut_clkB = SyncA_clkB_1;  // new signal synchronized to (=ready to be used in) clkB domain
endmodule
