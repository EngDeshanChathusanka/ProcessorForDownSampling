`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:27 07/28/2016 
// Design Name: 
// Module Name:    DR 
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
module DR(
     input clk, input [19:0] Rin,input [9:0] RinMem, output [19:0] Rout, output [9:0] Rdirect ,input MemWrite,input MemRead, input RDR
    );
	reg [19:0]R;
	assign Rdirect = R[9:0];
	assign Rout = (RDR)?  R : 20'bz;
	initial begin R = 20'b0; end

	always @ (negedge clk) 
	  begin	
		if (MemWrite)begin
			R <= {10'b0 , Rin[9:0] };
		end
		else if (MemRead)begin
			R <= {10'b0 , RinMem};
		end
	  end
endmodule
