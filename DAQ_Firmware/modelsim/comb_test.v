`default_nettype none
`timescale 1ns / 1ps

module comb_test();

parameter CLK_PERIOD = 10; // 10 ns

reg clk;
reg reset;
reg in1, in2;
reg out1;

initial clk = 1'b0;
initial begin
  reset = 1'b1;
  #20 reset = 1'b0;
end

always #(CLK_PERIOD/2.0) begin
  clk <= ~clk;
end

wire out_a;

initial begin
  in1 = 0;
  in2 = 0;
  wait(reset);
  wait(~reset);
  @(posedge clk);
  in1 = 1;
  in2 = 0;
  @(posedge clk);
  in1 = 0;
  in2 = 1;
  @(posedge clk);
  in1 = 1;
  in2 = 1;
end

always @(in1 or in2) begin
  if ( in2 ) begin
    out1 <= 1'b0;
  end
  if ( in1 ) begin
    out1 <= 1'b1;
  end
end

endmodule
