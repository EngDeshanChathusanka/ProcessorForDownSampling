`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:11:36 08/02/2016 
// Design Name: 
// Module Name:    baud_rate_generator 
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
module baud_rate_generator

#(
	parameter	 N =2,
					 M =4
						)
	(
		input wire clk, reset,
		output wire max_tick,
		output wire [N-1:0] q
		);
		
	reg [N-1:0] r_reg;
	wire [N-1:0] r_next;
	
	always@(posedge clk, posedge reset)
		if(reset)
			r_reg <=0;
		else
			r_reg <= r_next;
			
	assign r_next = (r_reg==(M-1)) ? 1'b0 : r_reg +1'b1;
	assign q = r_reg;
	assign max_tick = (r_reg==(M-1)) ? 1'b1 : 1'b0;
	
endmodule
					

