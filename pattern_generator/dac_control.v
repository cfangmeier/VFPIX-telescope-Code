`timescale 1 ns / 1 ps

module dac_control
(
  input clk,

  output reg db,
  output reg clr_n,
  output reg pd_n,
  output reg cs_n,
  output reg wr_n,
  output reg a0,
  output reg a1,
  output reg ldac_n,
)
