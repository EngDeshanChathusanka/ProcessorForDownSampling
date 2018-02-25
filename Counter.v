`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:34 07/28/2016 
// Design Name: 
// Module Name:    Counter 
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
module Counter(
    input clk,
    input reset,
    input inc,
    output [3:0] out
    );
	 reg [3:0] out_reg; 
	 assign out = out_reg;
	 initial begin
		out_reg <= 3'b0;
	 end
	 always @(negedge clk) begin
		if (reset) begin
			out_reg <= 4'b0 ;
		end 
		else if (inc) begin
			out_reg <= out_reg + 4'b1;
		end
		
	end
endmodule
