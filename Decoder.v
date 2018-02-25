`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:42 07/28/2016 
// Design Name: 
// Module Name:    Decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Decoder(
    input [2:0] in,
	 output out0,
    output out1,
    output out2,
    output out3,
    output out4,
    output out5,
    output out6,
    output out7
    );
	assign out0 = (in == 3'b0)? 1'b1: 1'b0;
	assign out1 = (in == 3'b1)? 1'b1: 1'b0;
	assign out2 = (in == 3'b10)? 1'b1: 1'b0;
	assign out3 = (in == 3'b11)? 1'b1: 1'b0;
	assign out4 = (in == 3'b100)? 1'b1: 1'b0;
	assign out5 = (in == 3'b101)? 1'b1: 1'b0;
	assign out6 = (in == 3'b110)? 1'b1: 1'b0;
	assign out7 = (in == 3'b111)? 1'b1: 1'b0;

endmodule
