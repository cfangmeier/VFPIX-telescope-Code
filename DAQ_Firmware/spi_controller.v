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
  input  wire        sys_clk, // 50 MHz
  input  wire        reset,

  input  wire        dac_request_write,
  input  wire [4:0]  dac_address,
  input  wire [11:0] dac_data,

  input  wire        adc_request_write,
  input  wire        adc_request_read,
  input  wire [15:0] adc_address,
  input  wire [7:0]  adc_data,
  output wire [7:0]  adc_data_readback,

  output wire        busy,

  output wire        sclk,
  inout  wire        sdio,

  output wire [7:0] adc_csb,
  output wire [1:0] dac_csb
  );


/*
 * Depending on the output device, data is updated either
 * on the rising or falling edge of the clock. Therefore,
 * the output clock must be (non)inverted for
 * (falling)rising edge devices.
 */
wire sclk_int;
reg invert_sclk;
assign sclk = sclk_int^invert_sclk;


reg [31:0] data_out;
reg request_action;
reg [5:0] read_bits;
reg [5:0] write_bits;
wire [31:0] data_readback;
assign adc_data_readback[7:0] = data_readback[7:0];

reg [2:0] adc_select;
wire csb;
assign adc_csb[0] = csb | (adc_select != 3'h0);
assign adc_csb[1] = csb | (adc_select != 3'h1);
assign adc_csb[2] = csb | (adc_select != 3'h2);
assign adc_csb[3] = csb | (adc_select != 3'h3);
assign adc_csb[4] = csb | (adc_select != 3'h4);
assign adc_csb[5] = csb | (adc_select != 3'h5);
assign adc_csb[6] = csb | (adc_select != 3'h6);
assign adc_csb[7] = csb | (adc_select != 3'h7);

reg  dac_select;
assign dac_csb[0] = csb | (dac_select != 1'b0);
assign dac_csb[1] = csb | (dac_select != 1'b1);

always @(posedge sys_clk or posedge reset) begin
  if (reset) begin
    data_out <= 32'b00000000;
    request_action <= 0;
    invert_sclk <= 0;
  end
  else begin
    if ( !busy & dac_request_write ) begin
      data_out[19:8] <= dac_data[11:0];
      data_out[23:20] <= dac_address[3:0];
      data_out[27:24] <= 4'b0011;
      data_out[31:28] <= 4'b1001;
      read_bits <= 6'h00;
      write_bits <= 6'h20;
      request_action <= 1;
      invert_sclk <= 1;
      dac_select <= dac_address[4];
    end
    else if ( !busy & adc_request_write ) begin
      data_out[31] <= 0; // r/wb
      data_out[30:29] <= 2'h0; // w1,w0
      data_out[28:16] <= adc_address[12:0]; // A12:A0
      data_out[15:8] <= adc_data[7:0]; // D7:D0
      read_bits <= 6'd00;
      write_bits <= 6'd24;
      request_action <= 1;
      invert_sclk <= 1;
      adc_select <= adc_address[15:13];
    end
    else if ( !busy & adc_request_read ) begin
      data_out[31] <= 1; // r/wb
      data_out[30:29] <= 2'h0; // w1,w0
      data_out[28:16] <= adc_address[12:0]; // A12:A0
      read_bits <= 6'd08;
      write_bits <= 6'd16;
      request_action <= 1;
      invert_sclk <= 1;
      adc_select <= adc_address[15:13];
    end
    else begin
      request_action <= 0;
    end
  end
end

spi_interface spi_interface_inst(
  .clk ( sys_clk ),
  .reset ( reset ),
  .data_in ( data_readback ),
  .data_out ( data_out ),
  .read_bits ( read_bits ),
  .write_bits ( write_bits ),
  .request_action ( request_action ),
  .busy ( busy ),
  .sclk ( sclk_int ),
  .sdio ( sdio ),
  .csb ( csb )
);
endmodule
