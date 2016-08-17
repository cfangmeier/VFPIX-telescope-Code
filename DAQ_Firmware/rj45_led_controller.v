 /* rj45_led_controller
  * 
  * This is an interface implementation for controlling a series
  * of eight LEDs on the 8xRJ-45 jack on the Telescope DAQ Board
  * The physical controller is a TLC59282 constant-current LED
  * driver.
  *
  * It works by shifting 16 bits into a register on the
  * chip and then latching the value of the shift register into
  * the active register. This controller simply adapts the interface
  * to a simple 8-bit parallel value, a clock, and a write_request input.
  * When write_request goes high, the current value of led_vals is stored
  * and then written to the output.
  *
  * To continuously sample the value of led_vals, simply tie write_request
  * high.
  */
`default_nettype none

module rj45_led_controller(
  input  wire         sys_clk,
  input  wire [7:0]   led_vals,
  input  wire         write_request,
  output wire         rj45_led_sck,
  output wire         rj45_led_sin,
  output wire         rj45_led_lat,
  output wire         rj45_led_blk
  );


reg [15:0] sys_clk_div;
reg clk_veto = 0;
wire clk = sys_clk_div[5];


always @(posedge sys_clk) begin
  sys_clk_div <= sys_clk_div+1;
end

reg [15:0] led_value_shift;
reg [4:0] write_counter;

reg latch;
always @(negedge clk) begin
  if (write_counter < 5'h11) begin
      write_counter <= write_counter + 1;
  end
  if (write_counter == 5'h11) begin
    if (write_request) begin
      write_counter <= 5'h00;
      led_value_shift <= { 1'b0, led_vals[0],
                           1'b0, led_vals[1],
                           1'b0, led_vals[2],
                           1'b0, led_vals[3],
                           1'b0, led_vals[4],
                           1'b0, led_vals[5],
                           1'b0, led_vals[6],
                           1'b0, led_vals[7]};
    end
  end
  if (write_counter < 5'h0F) begin
    led_value_shift <= {led_value_shift[14:0], 1'b0};
  end
  else if (write_counter == 5'h0F) begin
    latch <= 1;
    clk_veto <= 1;
  end
  else if (write_counter == 5'h10) begin
    latch <= 0;
    clk_veto <= 0;
  end
end

assign rj45_led_sck = clk & !clk_veto;
assign rj45_led_sin = led_value_shift[15];
assign rj45_led_lat = latch;
assign rj45_led_blk = 0;

endmodule
