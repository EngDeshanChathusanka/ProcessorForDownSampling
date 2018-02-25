`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:53:52 07/28/2016 
// Design Name: 
// Module Name:    TopModule 
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
module TopModule(
	 input clk,Reset,rx,
	 output reg [7:0] led,
	 output tx
	);

		reg [19:0] AddrsIn2;
		wire [19:0] AddrsInp;
		reg RoW2;        //ena,
		//wire [7:0]MemR;      // from p
		//reg [7:0] count;
		wire s_tick;
		wire tx_done_tick;
		reg [7:0] din;
		reg tx_start, ProsStart;
		//wire [9:0] MemW;
		wire [7:0] dout1;
		reg [1:0] state_reg;
		reg [1:0] state_next;
		//reg [6:0] count;
		wire flg;
		//wire flg1;
		wire [9:0] MemWp;
		wire RoWp;
		//reg [31:0] counter_time;

		localparam [1:0]
			idle	=	2'b00,
			start	=	2'b01,
			data	=	2'b10,
			stop	=	2'b11; 
	 
	 
	 
	 wire [19:0] AddrsIn;
	 wire [9:0] MemW, MemR;
	 wire RoW;
	 
	 
	 
	 baud_rate_generator bdg( clk , Reset , s_tick);

	 uart_rx rcx(clk , Reset , rx , s_tick , rx_done_tick, dout1 );

	 uart_tx uut (.clk(clk), .reset(Reset),.tx_start(tx_start),.s_tick(s_tick), .din(din), .tx_done_tick(tx_done_tick), .tx(tx));
		
	 ProcessorCore processor(clk, MemWp, MemR, ProsStart, RoWp, AddrsInp, flg,Reset);   // MemR from p
	 
	 Memory RAM (clk, MemW, MemR, RoW, AddrsIn);
	 
	 
	 
	 
	 //assign clk1=(state_reg==2'b01)?clk:1'b1;        //------------------- commented, check the importance
	 
	 
    assign MemW =(state_reg==2'b01)? { MemWp } :{2'b0,dout1};
	 assign AddrsIn =(state_reg==2'b01)? { AddrsInp } :{AddrsIn2};
	 assign RoW =(state_reg==2'b01)? { RoWp } :{RoW2};
	 

	initial begin

		//ena=1'b1;
		ProsStart <= 0;
		RoW2 <= 1'b1;
		led <=8'b00000000;
		AddrsIn2 <=20'd1024;         //        start writing from 1024 mem location onwards ( A0 )
		tx_start <=1'b0;
		state_reg <=2'b00;
		//count=7'd0;
		//counter_time=32'd0;
		
	end

	
	always@(posedge clk)          //             , posedge Reset
		begin
			if (Reset)
				begin
					ProsStart <= 0;
					AddrsIn2 <=20'd1024;         //        start writing from 1024 mem location onwards ( A0 )
					RoW2 <= 1'b1;
					state_reg <= 2'b00;
					tx_start <=1'b0;
					led <= 8'b 10000001; 
				end
				
			
			else if(state_reg==2'b00) begin        // not reset and idle
				/*if (ProsStart) begin
					if (flg) begin
						led <= 8'b11111111;
						ProsStart <= 1'b0;
						state_reg<=2'b01;                         // force to start transmission if processing finishes
						
					end
				end
				else*/ if (AddrsIn2 >=20'd17407 && rx_done_tick ) begin    // ---[ Initializing transmiting first data from fpga if writing and processing finish]
					//led<=8'd255;
					RoW2<=1'b0;
					//AddrsIn2<=20'd0;
					//count<=count+8'd1;
					//tx_start<=1'b1;
					din<= MemR[7:0];    // MemR from p
					ProsStart <= 1'b1; 
					led <= 8'b11111111;
					/*AddrsIn2<=20'd1024;     // Processr bypass,,,, deleteeeeeeeeeeeeeeeeeeeeeee
					tx_start<=1'b1;			// // deleteeeeeeeeeeeeeeeeeeeeeee
						RoW2<=1'b0;				// deleteeeeeeeeeeeeeeeeeeeeeee*/
					state_reg<=2'b01;                         // force to start transmission if processing finishes   //should be 01   *****************************************************************************************************************************************************************************************************
				end
				else if (rx_done_tick && RoW2) begin          // receiving data
					AddrsIn2 <= AddrsIn2+20'd1;
					led <= 8'b 11000011;								//led <= MemR;    **************************       
				end
			
			end  // end of line 111 else if 
			
			else if(state_reg==2'b01) begin                  // when started
				//RoW2<=RoWp;
				led<=8'b11111111;
				AddrsIn2<=AddrsInp;
				//counter_time<=counter_time+32'd1;
					if(flg) begin            // to prperly start processor should finish processing, so has to wait until flag turns on
						state_reg<=2'b10;                     // state changed to data
						led<=8'b00111100;     // *******************************
						AddrsIn2<=20'd1025;   //17408;                  // start transmisting from 1 mem location onwards
						tx_start<=1'b1;			// start transmission
						RoW2<=1'b0;
					end
			end  // end of line 128 else if 
			
			else if(state_reg==2'b10) begin          // transmiting
				//AddrsIn2<=20'd1;
				if(tx_done_tick && AddrsIn2>=20'd21504) begin   // finish ************************
					led<=8'b00011000;
					state_reg<=2'b11;                  // I changed it from 00
				end
				else if(tx_done_tick && AddrsIn2<20'd21504 && ~RoW2) begin
										/*if(count==7'd64) begin
											AddrsIn2<=AddrsIn2+20'd130;    // check **********  I comented
											count<=7'd0;
											end
										else begin */
										//RoW2<=1'b0;                     //****************************************************************************
											AddrsIn2<=AddrsIn2+20'd1;   // **********************  I comented
											/*count<=count+7'd1;
											end*/
										din<=MemR[7:0];         // from p
										led<=8'b00111100;       //AddrsIn[13:6];
										// state_reg<=2'b10;      // I comented this coz felt unnecessary
				end   // end of line 148 if 
			
			end   // end of line 142 else if 
	end  // end of posedge clock posedge
 
endmodule
