`timescale 1 ns / 1 ps

module adc_deser
(
  input d_clk,
  input fclk,
  input ser_dat_A,
  input ser_dat_B,
  input ser_dat_C,
  input ser_dat_D,
  output r_clk,
  output reg [11:0] dat_A,
  output reg [11:0] dat_B,
  output reg [11:0] dat_C,
  output reg [11:0] dat_D
);

reg [11:0] pipe_A;
reg [11:0] pipe_B;
reg [11:0] pipe_C;
reg [11:0] pipe_D;

always @(posedge fclk) begin
  dat_A <= pipe_A;
  dat_B <= pipe_B;
  dat_C <= pipe_C;
  dat_D <= pipe_D;
end

always @(posedge dclk) begin
  pipe_A <= {pipe_A[10:0],ser_dat_A};
  pipe_B <= {pipe_B[10:0],ser_dat_B};
  pipe_C <= {pipe_C[10:0],ser_dat_C};
  pipe_D <= {pipe_D[10:0],ser_dat_D};
end

endmodule
