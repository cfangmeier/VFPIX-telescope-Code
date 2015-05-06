`timescale 1 ns / 1 ps

module seven_segment_display
(
  input clk,
  input [0:15]num_in,
  output reg [0:6]dig,
  output reg dp,
  output reg neg,
  output reg clr,
  output reg [0:3]dig_sel
);

//dig format
//dig[0] : A, top
//dig[1] : B, top/right
//dig[1] : C, bottom/right
//dig[1] : D, bottom
//dig[1] : E, bottom/left
//dig[1] : F, top/left
//dig[1] : G, middle
reg [0:3]dig1;
reg [0:3]dig2;
reg [0:3]dig3;
reg [0:3]dig4;

always @(posedge clk) begin
  if(dig_sel == 0) begin
    dig_sel <= 1;
  end
  else begin
    dig_sel <= {dig_sel[3],dig_sel[0:2]};
  end 
end

always @(posedge clk) begin
  case(dig_sel)
  4'b0001: dig <= dig1;
  4'b1000: dig <= dig2;
  4'b0100: dig <= dig3;
  4'b0010: dig <= dig4;
  endcase
end


always @(posedge clk) begin
  case(num_in[0:3])
    4'b0000: dig1 = 7'b1111110; //0
    4'b0001: dig1 = 7'b0110000; //1
    4'b0010: dig1 = 7'b101101; //2
    4'b0011: dig1 = 7'b1111001; //3
    4'b0100: dig1 = 7'b0110011; //4
    4'b0101: dig1 = 7'b1011011; //5
    4'b0110: dig1 = 7'b1011111; //6
    4'b0111: dig1 = 7'b1110000; //7
    4'b1000: dig1 = 7'b1111111; //8
    4'b1001: dig1 = 7'b1111011; //9
    4'b1010: dig1 = 7'b1110111; //A
    4'b1011: dig1 = 7'b0011111; //b
    4'b1100: dig1 = 7'b1001110; //C
    4'b1101: dig1 = 7'b0111101; //d
    4'b1110: dig1 = 7'b1001111; //E
    4'b1111: dig1 = 7'b1000111; //F
  endcase
  case(num_in[4:7])
    4'b0000: dig2 = 7'b1111110; //0
    4'b0001: dig2 = 7'b0110000; //1
    4'b0010: dig2 = 7'b101101; //2
    4'b0011: dig2 = 7'b1111001; //3
    4'b0100: dig2 = 7'b0110011; //4
    4'b0101: dig2 = 7'b1011011; //5
    4'b0110: dig2 = 7'b1011111; //6
    4'b0111: dig2 = 7'b1110000; //7
    4'b1000: dig2 = 7'b1111111; //8
    4'b1001: dig2 = 7'b1111011; //9
    4'b1010: dig2 = 7'b1110111; //A
    4'b1011: dig2 = 7'b0011111; //b
    4'b1100: dig2 = 7'b1001110; //C
    4'b1101: dig2 = 7'b0111101; //d
    4'b1110: dig2 = 7'b1001111; //E
    4'b1111: dig2 = 7'b1000111; //F
  endcase
  case(num_in[8:11])
    4'b0000: dig3 = 7'b1111110; //0
    4'b0001: dig3 = 7'b0110000; //1
    4'b0010: dig3 = 7'b101101; //2
    4'b0011: dig3 = 7'b1111001; //3
    4'b0100: dig3 = 7'b0110011; //4
    4'b0101: dig3 = 7'b1011011; //5
    4'b0110: dig3 = 7'b1011111; //6
    4'b0111: dig3 = 7'b1110000; //7
    4'b1000: dig3 = 7'b1111111; //8
    4'b1001: dig3 = 7'b1111011; //9
    4'b1010: dig3 = 7'b1110111; //A
    4'b1011: dig3 = 7'b0011111; //b
    4'b1100: dig3 = 7'b1001110; //C
    4'b1101: dig3 = 7'b0111101; //d
    4'b1110: dig3 = 7'b1001111; //E
    4'b1111: dig3 = 7'b1000111; //F
  endcase
  case(num_in[11:15])
    4'b0000: dig4 = 7'b1111110; //0
    4'b0001: dig4 = 7'b0110000; //1
    4'b0010: dig4 = 7'b101101; //2
    4'b0011: dig4 = 7'b1111001; //3
    4'b0100: dig4 = 7'b0110011; //4
    4'b0101: dig4 = 7'b1011011; //5
    4'b0110: dig4 = 7'b1011111; //6
    4'b0111: dig4 = 7'b1110000; //7
    4'b1000: dig4 = 7'b1111111; //8
    4'b1001: dig4 = 7'b1111011; //9
    4'b1010: dig4 = 7'b1110111; //A
    4'b1011: dig4 = 7'b0011111; //b
    4'b1100: dig4 = 7'b1001110; //C
    4'b1101: dig4 = 7'b0111101; //d
    4'b1110: dig4 = 7'b1001111; //E
    4'b1111: dig4 = 7'b1000111; //F
  endcase
end

always @(posedge clk) begin
  dp <= 0;
  neg <= 0;
  clr <= 0;
end

endmodule
