`default_nettype none

module daq_firmware(
  input  wire [4:0]   okUH,
  output wire [2:0]   okHU,
  inout  wire [31:0]  okUHU,
  inout  wire         okAA,

  input  wire         sys_clk,

  output wire [1:0]   led
  );

// Target interface bus:
wire         okClk;
wire [112:0] okHE;
wire [64:0]  okEH;


// Circuit wires
wire fifowrite;
wire fiforead;
wire [15:0] datain;
wire [15:0] dataout;
wire [15:0] wireout;


wire [65*2-1:0]  okEHx;
okHost okHI(
  .okUH(okUH),
  .okHU(okHU),
  .okUHU(okUHU),
  .okAA(okAA),
  .okClk(okClk),
  .okHE(okHE),
  .okEH(okEH)
);
okWireOR # (.N(2)) wireOR (okEH, okEHx);


wire request_write;
wire request_read;

wire [31:0] data_in;
wire [31:0] data_out;


// 32 bit wide 1024 depth fifo
fifo32  fifo32_inst (
  .clock ( okClk ),
  .data ( data_in ),
  .rdreq ( request_read ),
  .wrreq ( request_write ),
  .empty ( ),
  .full ( ),
  .q ( data_out ),
  .usedw ( )
);

// FrontPanel module instantiations
okWireIn wire10(
      .okHE(okHE),
      .ep_addr(8'h10),
      .ep_dataout(wireout)
);

okPipeIn pipe80(
      .okHE(okHE),
      .okEH(okEHx[0*65 +: 65]),
      .ep_addr(8'h80),
      .ep_write(request_write),
      .ep_dataout(data_in)
);

okPipeOut pipeA0(
      .okHE(okHE),
      .okEH(okEHx[1*65 +: 65]),
      .ep_addr(8'hA0),
      .ep_read(request_read),
      .ep_datain(data_out)
);

endmodule
