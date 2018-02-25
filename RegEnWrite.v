`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:42 07/28/2016 
// Design Name: 
// Module Name:    RegEnWrite 
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
module RegEnWrite(
    input clk, input [19:0] Rin, output [19:0] Rout ,input EnWrite
    );
	reg [19:0]R;
	//reg [11:0]Rout;
	assign Rout = R;
	initial begin R = 20'b0; end
	always @ (negedge clk) 
	  begin
		if (EnWrite) begin
			R <= Rin;
			end
			  
	  end
endmodule
