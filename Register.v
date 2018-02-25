`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:14 07/28/2016 
// Design Name: 
// Module Name:    Register 
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
module Register(
    input clk, input [19:0] Rin, output [19:0] Rout ,input EnWrite, input EnRead
    );
	reg [19:0]R;
	assign Rout = (EnRead)?  R : 20'bz;
	initial begin R = 20'b0; end
	always @ (negedge clk) 
	  begin
		if (EnWrite)begin
			R <= Rin;
		end
	  end
endmodule