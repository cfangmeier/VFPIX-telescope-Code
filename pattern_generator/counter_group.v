`timescale 1 ns / 1 ps

module counter_group
(
  input selector,
  input incrementor,
  input reverse,
  input clr,
  output wire [15:0]cntr0,
  output wire [15:0]cntr1,
  output wire [15:0]cntr2,
  output wire [15:0]cntr3,
  output wire [15:0]cntr4,
  output wire [15:0]cntr5,
  output wire [15:0]cntr6,
  output wire [15:0]cntr7,
  output wire [15:0]cntr_sel,
  output reg [7:0]cntr_ind
);


reg [2:0] cntr_cur;
reg [15:0] cntrs[7:0];
assign cntr0 = cntrs[0];
assign cntr1 = cntrs[1];
assign cntr2 = cntrs[2];
assign cntr3 = cntrs[3];
assign cntr4 = cntrs[4];
assign cntr5 = cntrs[5];
assign cntr6 = cntrs[6];
assign cntr7 = cntrs[7];

wire [15:0] cntrs_def[7:0];
assign cntrs_def[0] = 16'H0066;  //Vana(2V)
assign cntrs_def[1] = 16'H0033;  //RG(1V)
assign cntrs_def[2] = 16'H0051;  //Vthr(1.58V)
assign cntrs_def[3] = 16'H0033;  //Aref(1V)
assign cntrs_def[4] = 16'H0000;
assign cntrs_def[5] = 16'H0000;
assign cntrs_def[6] = 16'H0000;
assign cntrs_def[7] = 16'H0000;

assign cntr_sel = cntrs[cntr_cur];

wire s = selector | clr | incrementor;
always @(posedge s) begin
  if (clr == 1) begin
    /* cntrs[cntr_cur] <= 0; */
    cntrs[cntr_cur] <= cntrs_def[cntr_cur];
  end else if (selector == 1) begin
    if (reverse == 1)
      cntr_cur <= cntr_cur - 1;
    else
      cntr_cur <= cntr_cur + 1;
  end else begin
    if (reverse == 1)
      cntrs[cntr_cur] <= cntrs[cntr_cur] - 1;
    else
      cntrs[cntr_cur] <= cntrs[cntr_cur] + 1;
  end
end


always @(cntr_cur) begin
  case(cntr_cur)
    0: cntr_ind <= 8'H01;
    1: cntr_ind <= 8'H02;
    2: cntr_ind <= 8'H04;
    3: cntr_ind <= 8'H08;
    4: cntr_ind <= 8'H10;
    5: cntr_ind <= 8'H20;
    6: cntr_ind <= 8'H40;
    7: cntr_ind <= 8'H80;
  endcase
end

endmodule
