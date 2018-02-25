`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:15 07/28/2016 
// Design Name: 
// Module Name:    RegPC 
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
module RegPC(
    input clk, 
	 input [9:0] Rin, 
	 output [9:0] Rout, output [9:0] Rdirect ,
	 input EnWrite, 
	 input EnRead , input EnDirectRead, input inc,
	 input overflowin,
	 output overflowout
    );
	reg ofBit;
	reg [9:0]R;
	assign overflowout = ofBit;
	assign Rdirect =(EnDirectRead)? R: 10'bz;
	assign Rout = (EnRead )?  R : 10'bz;
	initial begin 
		R = 10'b0; 
		ofBit = 0;
		end
	
	always @ (negedge clk) begin
		if (ofBit==1'b1) begin
			ofBit <= 0;
		end
		if (EnWrite)begin
			R <= Rin;
		end
		else if (inc || overflowin )begin
			{ofBit,R} <= R + 1;
		end
		end
		
		endmodule
