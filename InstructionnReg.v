`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:50 07/28/2016 
// Design Name: 
// Module Name:    InstructionnReg 
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
module InstructionnReg(
    input clk, input [9:0] Rin, output [9:0] Rout ,input EnWrite
    );
	reg [9:0]R;
	//reg [11:0]Rout;
	assign Rout = R;
	initial begin R = 10'b0; end
	always @ (negedge clk) 
	  begin
		if (EnWrite) begin
			R <= Rin;
			end
			  
	  end
endmodule