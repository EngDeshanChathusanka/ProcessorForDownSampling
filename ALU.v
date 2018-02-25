`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:06 07/28/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    //input clk,
    input [19:0]AC,
    input [19:0] InputBus,
	 output [19:0] OutputBus,
	 input [3:0]ControlSignal,
    output Z,
	 output N
    //output O             //Account later
    );
	 
	 assign OutputBus = (ControlSignal == 4'b0)? InputBus:                // pass InputBus
							  (ControlSignal == 4'b1)? AC:						// pass AC
							  (ControlSignal == 4'b10)? AC + InputBus :		// Add Ac and Input Bus
					  	     (ControlSignal == 4'b11)? AC - InputBus :		// Sub Ac and Input Bus
				    		  (ControlSignal == 4'b100)? AC >> 6 :							  // Devide by 64
							  (ControlSignal == 4'b101)? AC + 1'b1 :
							  (ControlSignal == 4'b110)? InputBus <<10 :
							  (ControlSignal == 4'b111)? AC - 1'b1 :				//ac-1    new
							  (ControlSignal == 4'b1000)? AC & InputBus :
							  (ControlSignal == 4'b1001)? AC | InputBus :
							  (ControlSignal == 4'b1010)? AC ^ InputBus :
							  (ControlSignal == 4'b1011)?  ~AC :
							  (ControlSignal == 4'b1100)? InputBus >> 10:
							  (ControlSignal == 4'b1101)? AC >> 10:
							  (ControlSignal == 4'b1110)? 20'b0:
							  (ControlSignal == 4'b1111)? AC*3					//*3     new
							  
							   
							   20'bz;
	assign Z = (OutputBus == 20'b0 )? 1'b1: 1'b0;
	assign N = (OutputBus[19] == 1'b1 )? 1'b1: 1'b0;
	
endmodule
