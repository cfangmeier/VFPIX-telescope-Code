 /* spi_controller
  *
  * Controller responsible for multiplexing the SPI interface to allow
  * controll by multiple agents.
  *
  * The interfacing HDL must also supply clk_inv to determine
  * if data is read by the device on the rising(clk_inv=1)
  * or falling(clk_inv=0) clock edge.
  */
`default_nettype none

module spi_controller(
  input  wire         sys_clk,
  input  wire         reset,
  output wire         sclk,
  inout  wire         sdio,
  output wire         csb
  );


reg [10:0] clk_div;
always @(posedge sys_clk) begin
  if (reset) begin
    clk_div <= 11'h000;
  end
  else begin
    clk_div <= clk_div + 1;
  end
end

wire sclk_internal;
assign sclk = sclk_internal;

wire clk;
assign clk = clk_div[4];

reg [31:0] data_out;
wire busy;
reg request_action;
always @(posedge clk or posedge reset) begin
  if (reset) begin
    data_out <= 32'b00000000;
    request_action <= 0;
  end
  else begin
    if ( !busy ) begin
      data_out[19:8] <= data_out[19:8] + 1;
      data_out[23:20] <= 4'b1111;
      data_out[27:24] <= 4'b0011;
      request_action <= 1;
    end
    else begin
      request_action <= 0;
    end
  end
end
spi_interface spi_interface_inst(
  .clk ( clk ),
  .reset ( reset ),
  .data_in (  ),
  .data_out ( data_out ),
  .read_bits ( 6'h00 ),
  .write_bits ( 6'h20 ),
  .request_action ( request_action ),
  .busy ( busy ),
  .sclk ( sclk_internal ),
  .sdio ( sdio ),
  .csb ( csb )
);
endmodule
