 /* spi_interface
  * Implementation of a generic SPI interface.
  *
  * Interfacing HDL must supply the exact data to be written
  * over the interface (including write/read bit and address)
  * properly formatted for the device being spoken to.
  */
`default_nettype none

module spi_interface (
  input  wire         clk,
  input  wire         reset,
  input  wire [31:0]  data_out,
  output reg  [31:0]  data_in,
  input  wire [5:0]   read_bits,
  input  wire [5:0]   write_bits,
  input  wire         request_action,
  output reg          busy,
  output wire         sclk,
  inout  wire         sdio,
  output reg          csb
);

reg [6:0] cycle_counter;
reg [31:0] data_in_shifter;
reg [31:0] data_out_shifter;
reg is_writing;
reg sdio_int;

assign sdio = is_writing ? sdio_int : 1'bz;
assign sclk = clk & busy;
always @(posedge clk or posedge reset) begin
  if (reset) begin
    busy <= 0;
    is_writing <= 0;
    sdio_int <= 0;
    cycle_counter <= 7'h00;
    data_in_shifter <= 32'h00000000;
    data_out_shifter <= 32'h00000000;
  end
  else begin
    if (!busy) begin
      if (request_action) begin
        busy <= 1;
        cycle_counter <= 6'h00;
        data_out_shifter <= data_out;
        data_in_shifter <= 32'h00000000;
        csb <= 1;
      end
    end
    else begin
      if (cycle_counter < write_bits) begin  // writing
        is_writing <= 1;
        sdio_int <= data_out_shifter[0];
        data_out_shifter[31:0] <= {1'b0, data_out_shifter[31:1]};
        cycle_counter <= cycle_counter + 1;
        csb <= 0;
      end
      else if (cycle_counter < (write_bits+read_bits)) begin  // reading
        is_writing <= 0;
        data_in_shifter <= {data_in_shifter[30:0], sdio};
        cycle_counter <= cycle_counter + 1;
        csb <= 0;
      end
      else begin
        data_in <= data_in_shifter;
        busy <= 0;
        cycle_counter <= 6'h00;
        csb <= 1;
      end
    end
  end

end

endmodule
