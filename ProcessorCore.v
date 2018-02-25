`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:33:11 08/02/2016 
// Design Name: 
// Module Name:    ProcessorCore 
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
module ProcessorCore(
		input   clk,
		output [9:0] MemW, 
		input  [9:0] MemR, 
		input start,
		output  RoW, 
		output [19:0] AddrsIn,
		output flag,
		input reset
    );
   assign flag = Jump;
	reg [23:0] Controller;	 
	wire  ResetIncCounter;
	//wire [19:0] AddrsIn;
	wire [19:0] BusA , BusB, ACin; 	   
	wire [9:0] AddrsInL, IRout,   AddrsInH;		//MemR, MemW,
	wire [3:0] ALUcontrol, CounterOut; 			
	wire [2:0] WriteBusA;
	wire Z,PCE,N;		
	wire RR , RPC,RMAR,MemRead,Unused1,Unused2, Unused3,Unused4;
	wire WAC,WR,WPCL,WPCH,WMARL,WMARH,WIR,MemWrite;
	wire IncPCH,IncPCL,IncMARH,IncMARL;
	wire  RDR ;				//RoW,
	wire JumpU;   
	wire ofMAR, ofPC, ground, ofMARH, ofPCH;
	
	reg Jump;
   reg  Jumpz ;	
	reg Jumpp;
	reg [0:6]unused;
	reg gnd;
	assign AddrsIn = {AddrsInH, AddrsInL};
	assign ground = gnd;

	assign ResetIncCounter = Controller[23];
	assign JumpU=Controller[22];
	assign ALUcontrol = Controller[21:18];
	assign IncPCH = Controller[17];
	assign IncPCL = Controller[16];
	assign IncMARH = Controller[15];
	assign IncMARL = Controller[14];
	assign WMARH = Controller[13];
	assign WMARL = Controller[12];
	assign WPCH = Controller[11];
	assign WPCL = Controller[10];
	assign WR = Controller[9];
	assign WAC = Controller[8];
	assign RoW = Controller[7];
	assign MemWrite = Controller[6];
	assign MemRead = Controller[5];
	assign WIR = Controller[4];
	assign PCE = Controller[3];
	assign WriteBusA = Controller[2:0];
	
	Decoder decodeWriteBusA (WriteBusA,RR,RPC,Unused3,RMAR,Unused4,RDR,Unused1,Unused2);

	ALU alu (ACin, BusA, BusB, ALUcontrol, Z,N);

	RegEnWrite AC (clk, BusB, ACin,WAC);
	Register R (clk, BusB, BusA, WR, RR);

	RegPC PCH (clk , BusB[19:10], BusA[19:10],AddrsInH,WPCH,RPC,~PCE, IncPCH, ofPC ,  ofPCH);
	RegPC PCL (clk , BusB[9:0],   BusA[9:0],  AddrsInL,WPCL,RPC,~PCE, IncPCL, ground, ofPC );
	
	//assign IncPCH = 0;
	

	RegPC MARH (clk , BusB[19:10], BusA[19:10],AddrsInH,WMARH,RMAR,PCE,IncMARH, ofMAR,ofMARH);
	RegPC MARL (clk , BusB[9:0],   BusA[9:0],  AddrsInL,WMARL,RMAR,PCE,IncMARL,ground, ofMAR);

	//Register DR (clk, BusB, BusA,WDR,RDR);
	//Register TR (clk, BusB, BusA,WTR,RTR);

	InstructionnReg IR (clk, MemR, IRout, WIR);
	DR DR1 (clk, BusB, MemR,BusA, MemW, MemWrite, MemRead, RDR);

	//Memory RAM (clk, MemW, MemR, RoW, AddrsIn);

	Counter counter (clk, ResetIncCounter, ~ResetIncCounter, CounterOut);   // Redundency in ResetIncCounter
	initial begin 
		Jump <= 0;            //changed--------------------------------------------------------------------------------------------------------------------
		gnd <= 1'b0;
		Controller <= 24'b1000_00000_00000_00000_10101;	//WIR, PC -> MemRead , Reset Counter
	   Jumpz <= 1'b0;
		Jumpp <= 1'b0;
	end
	always @ (posedge clk)
		begin
			if (reset) begin
				Jump <= 0; 
				Controller <= 24'b1011_10000_00011_00000_00000;	//WIR, PC -> MemRead , Reset Counter
				Jumpz <= 1'b0;
				Jumpp <= 1'b0;
			end
			else if (Jump || ~start) begin
				end
			else begin
					case (CounterOut)
						0 : Controller <= 24'b10_00000_00000_10101 ;		//fetch1 -InPCL,RDR,WIR  
						1 : Controller <= 24'b0; 	//fetch2
						2 : case (IRout)
								0: Controller <= 24'b1000_00000_00000_00000_00000 ;						// No operation  (reset counter)
								1: Controller <= 24'b10_00000_00001_00101; 			//LDAC1
								2: Controller <= 24'b10_00000_00001_00101; 			//STAC1
								3: Controller <= 24'b1001_01000_00000_01000_00000; //INCAC
								4: Controller <= 24'b1000_01000_00000_10000_00101;	//MVAC
								5: Controller <= 24'b0000_01000_00000_00000_00000;	//MVR
								6: Controller <= 24'b1100_00000_00001;					//JUMP
								7: Controller <= 24'b11000_00000_00000_00000;	//JUMPZ
								8: Controller <= 24'b11000_00000_00000_00000;	//JMNZ
								9: Controller <= 24'b11000_00000_00000_00000;	//JUMPP
								10:Controller <= 24'b1000_10000_00000_01000_00000;	//ADD
								11:Controller <= 24'b1000_11000_00000_01000_00000;	//SUB
								12:Controller <= 24'b1001_11000_00000_01000_00000;	//CLAC
								13:Controller <= 24'b1010_00000_00000_01000_00000;	//AND
								14:Controller <= 24'b1010_01000_00000_01000_00000; 	//OR
								15:Controller <= 24'b1010_10000_00000_01000_00000;	//XOR
								16:Controller <= 24'b1010_11000_00000_01000_00000;	//NOT
								17:Controller <= 24'b10_00000_00001_00101;	//STMAC
								18:Controller <= 24'b10_00000_00001_00101;	//LDMAC
								19:Controller <= 24'b1001_00000_00000_01000_00000;//DIV
								20:begin 
										Controller <= 24'b1100_00000_00000_00000_00000;     // Process Finished
										Jump <= 1'b1;
									end
								default : Controller <= 24'b1000_00000_00000_00000_00000;
								21:Controller <= 24'b1001_11000_00000_01000_00000; //DECAC
								22:Controller <= 24'b1011_11000_00000_01000_00000;	//MUL
							endcase
						3 : case (IRout)
								1: Controller <= 24'b1_10000_01000_00000_00101;			//LDAC2
								2: Controller <= 24'b1_10000_01000_00000_00101;			//STAC2
								5: Controller <= 24'b1000_01000_00000_10000_00000;
								6 : Controller <= 24'b1101;
								7: case(Z)
										1: Jumpz <= 1'b1;
										0: Jumpz <= 1'b0;
									endcase 
								8: case(~Z)
										1: Jumpz <= 1'b1;
										0: Jumpz <= 1'b0;
									endcase
								9: case(~Z&&~N)
										 1:Jumpp <= 1'b1;
										 0:Jumpp <= 1'b0;
									endcase
								17:Controller <= 24'b1_10000_01000_00000_00101; 
								18:Controller <= 24'b1_10000_01000_00000_00101;
								default : Controller <= 24'b1000_00000_00000_00000_00000 ;
							 endcase
						4 : case (IRout)
								1: Controller <= 24'b10_00000_00001_00101;			//LDAC3
								2: Controller <= 24'b10_00000_00001_00101; 			//STAC3
								6: Controller <= 24'b10000_00001_00101;
								7:case(Jumpz)
									  1: Controller <= 24'b1100_00000_00001;
									  0: Controller <= 24'b10_00000_00000_00000;
								  endcase
								8: case(Jumpz)
									  1: Controller <= 24'b1100_00000_00001; 
									  0:Controller <= 24'b10_00000_00000_00000;
									endcase
								9:case(Jumpp)
									  1: Controller <= 24'b1100_00000_00001;
									  0: Controller <= 24'b10_00000_00000_00000;
								  endcase
								17:Controller <= 24'b10_00000_00001_00101; 
								18:Controller <= 24'b10_00000_00001_00101;
								default : Controller <= 24'b1000_00000_00000_00000_00000 ;
							 endcase
						5 : case (IRout)
								1: Controller <= 24'b100_00000_00101;				//LDAC4
								2: Controller <= 24'b100_00000_00101; 				//STAC4
								6: Controller <= 24'b1_10000_00010_00000_01101;
								7: case(Jumpz)
										1:Controller <= 24'b1101; 
										0:Controller <= 24'b1000_00010_00000_00000_00000;
									endcase
								8:  case(Jumpz)
										1:Controller <= 24'b1101; 
										0:Controller <= 24'b1000_00010_00000_00000_00000;		
									 endcase
								9: case(Jumpp)
										1:Controller <= 24'b1101; 
										0:Controller <= 24'b1000_00010_00000_00000_00000; 
									endcase
								17:Controller <= 24'b100_00000_00101; 
								18:Controller <= 24'b100_00000_00101;
								default : Controller <= 24'b1000_00000_00000_00000_00000;
							 endcase
						6 : case (IRout)
								1: Controller <= 24'b1101;											//LDAC5
								2: Controller <= 24'b1000_00000_00010_00101; 				//STAC5 
								6: Controller <= 24'b1_00101;
								7: Controller <= 24'b10000_00001_00101; 
								8: Controller <= 24'b10000_00001_00101; 
								9:Controller <= 24'b10000_00001_00101; 
								17:Controller <= 24'b11_01000_00000_00010_00000;
								18:Controller <= 24'b1101;
								default : Controller <= 24'b1000_00000_00000_00000_00000 ;
							 endcase
						7 : case (IRout)
								1: Controller <= 24'b1_01101;//LDAC6
								2: Controller <= 24'b100_01000; 
								6: Controller <= 24'b1000_00000_00001_00000_00101;
								7: Controller <= 24'b1_10000_00010_00000_01101;
								8: Controller <= 24'b1_10000_00010_00000_01101;		
								9: Controller <= 24'b1_10000_00010_00000_01101;	
								17:Controller <= 24'b10000_00100_01000;
								18:Controller <=24'b10000_00001_01000;
								default : Controller <= 24'b1000_00000_00000_00000_00000 ;
							 endcase
						8 : case (IRout)
								1: Controller <= 24'b1000_00000_00000_01000_00101;//LDAC7
								2: Controller <= 24'b1000_00000_00000_00000_00000; 
								7: Controller <= 24'b1_00101;//*24'b1_01101;
								8: Controller <= 24'b1_00101;//*
								9: Controller <= 24'b1_00101;//*
								17: Controller <= 24'b1000_00000_00010_01000;
								18:Controller <= 24'b1_10000_00000_01000_01101;
								default : Controller <= 24'b1000_00000_00000_00000_00000 ;
							 endcase
						9 : case (IRout) 	
								 						
								 7: Controller <= 24'b1000_00000_00001_00000_00101;
								 8: Controller <= 24'b1000_00000_00001_00000_00101;//24'b1000_00000_00001_00000_01101;
								 9: Controller <= 24'b1000_00000_00001_00000_00101;//24'b1000_00000_00001_00000_01101;
								 17: Controller <= 24'b0000_00000_00000_00101_01000;
								 18:Controller <=24'b1_01000;
								 default : Controller <= 24'b1000_00000_00000_00000_00000 ;
							endcase
						10 : case(IRout)
								  17:Controller <= 24'b1000_00000_00000_00000_00000;
							     18:Controller <= 24'b1010_01000_00000_01000_00101;
							  endcase
						
						default : Controller <= 24'b1000_00000_00000_00000_00000 ;
					endcase
					unused <= {JumpU, Unused1, Unused2 , Unused3, Unused4, ofMARH, ofPCH};
			end // end, when not Jump
		end  // end of always block


endmodule
