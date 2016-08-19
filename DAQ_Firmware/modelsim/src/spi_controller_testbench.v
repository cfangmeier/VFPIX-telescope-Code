
`timescale 1 ns / 100 ps
`default_nettype none

module spi_controller_testbench();
reg sys_clk;
reg reset;

wire sclk;
wire sdio;
wire csb;

spi_controller dut(
  .sys_clk ( sys_clk ),
  .reset (reset),
  .sclk ( sclk ),
  .sdio ( sdio ),
  .csb ( csb )
);


initial
begin
  $display($time, " << Starting the Simulation >>");
  sys_clk = 1'b0;
  reset = 1'b1;
  #20 reset = 1'b0;
end

always
begin
  #1 sys_clk = ~sys_clk;
end

endmodule
