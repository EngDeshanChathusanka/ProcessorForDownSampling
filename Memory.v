`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:04 07/28/2016 
// Design Name: 
// Module Name:    Memory 
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
module Memory(
    input clk,
    input [9:0] DataIn,
    output [9:0] DataOut,
    input RoW,
	 //input Read,
	 //input Write,	 
    input [19:0] Address
	 //input finish
    //input clk
    );
	 
	
	 //reg finish_reg;
	 /*always@ (posedge clk)
	 begin
		finish_reg=finish;
	 end*/
	 reg [9:0] ram[21503:0];   //16777215   , 21503
	 reg [9:0] Data_out;
	
	assign DataOut=Data_out;
	 
	 	 
	 always @(posedge clk) begin
		if (~RoW)begin
			Data_out <= ram[Address];
		end
		else begin
			Data_out <=  10'bz;
		end
	end
	 
	 
	 initial begin
	 	
	   //$readmemb("input.txt",ram,1024,17407);
		ram[1007]=10'b1;				//A initial 1153
		ram[1008]=10'd129;
		ram[1009]=10'b1;				//A0 = 1153
		ram[1010]=10'd129;
		ram[1011]=10'b1;				//A0+kh-2 initial 1279
		ram[1012]=10'd255;
		ram[1013]=10'b100_00000;	//H = 128
		ram[1014]=10'b100_00000;	//W = 128
		ram[1015]=10'b10001;			//A00+HW-1 = 17407
		ram[1016]=10'b1;
		ram[1017]=10'b10001;				//X = 17408 initially    (1024+128*128)
		ram[1018]=10'b0;
		
		ram[480]=10'b1;				//Initial A = 1153
		ram[481]=10'd129;
		ram[482]=10'b1;				//Initial A0+ kh-2   1279
		ram[483]=10'd255;
		ram[484]=10'b10001;			//X = 17408 initially    (1024+128*128)
		ram[485]=10'b0;
		//ram[21505]=10'd253;
		//ram[21504]=10'd214;

		ram[0]=10'd6;				//JUMP
		ram[1]=10'b0;
		ram[2]=10'd500;		//500
		
		ram[500]=10'd18;				//LDMAC
		ram[501]=10'b0;
		ram[502]=10'd480;		//480
		ram[503]=10'd17;				//STMAC
		ram[504]=10'b0;
		ram[505]=10'd1007;		//1007
		
		ram[506]=10'd18;				//LDMAC
		ram[507]=10'b0;
		ram[508]=10'd482;		//482
		ram[509]=10'd17;				//STMAC
		ram[510]=10'b0;
		ram[511]=10'd1011;		//1011
		
		ram[512]=10'd18;				//LDMAC
		ram[513]=10'b0;
		ram[514]=10'd484;		//484
		ram[515]=10'd17;				//STMAC
		ram[516]=10'b0;
		ram[517]=10'd1017;		//1017
		
		ram[518]=10'd18;				//LDMAC
		ram[519]=10'b0;
		ram[520]=10'd1017;		//1017
		
		ram[521]=10'd6;				//JUMP
		ram[522]=10'b0;
		ram[523]=10'd3;		//3
		
	
		ram[3]=10'b10001;				//STMAC
		ram[4]=10'b0; 		//***PC0
		ram[5]=10'd;			
		
		ram[6]=10'b1;				//LDAC
		ram[7]=10'b0;				//1013
		ram[8]=10'd1013;
		
		ram[9]=10'b100;			//MVAC
		
		ram[10]=10'b10010;			//LDMAC
		ram[11]=10'b0;
		ram[12]=10'd1007;		//1007
		
		ram[13]=10'b10001;			//STMAC
		   
		ram[14]=10'b0;   //***PC1	
		ram[15]=10'd76;
		
		ram[16]=10'b1010;			//ADD
		
		ram[17]=10'b10001;		//STMAC
		
		ram[18]=10'b0;				//***PC2
		ram[19]=10'd81;
		
		ram[20]=10'b11;			//INCAC
		
		ram[21]=10'b10001;		//STMAC
		ram[22]=10'b0;		//***PC3
		ram[23]=10'd88;
		
		ram[24]=10'b1011;		//SUB

		ram[25]=10'b10001;		//STMAC
		ram[26]=10'b0;			//***PC4
		ram[27]=10'd95;
		
		ram[28]=10'd11;		//SUB	
		
		ram[29]=10'b10001;		//STMAC
		ram[30]=10'b0;			//***PC5
		ram[31]=10'd102;	
		
		ram[32]=10'd21;		//DECAC
		
		ram[33]=10'b10001;		//STMAC
		ram[34]=10'b0;			//***PC6
		ram[35]=10'd108;
		
		ram[36]=10'd21;		//DECAC
		
		ram[37]=10'b10001;		//STMAC
		ram[38]=10'b0;			//***PC7
		ram[39]=10'd114;
		
		ram[40]=10'd10;		//ADD
		
		ram[41]=10'd17;			//STMAC
		ram[42]=10'd0;			//***PC8
		ram[43]=10'd120;
		
		ram[44]=10'd10;		//ADD
		
		ram[45]=10'd17;			//STMAC
		ram[46]=10'd0;			//***PC9
		ram[47]=10'd126;
		
		ram[48]=10'd10;		//ADD
		
		ram[49]=10'd17;			//STMAC
		ram[50]=10'd0			//***PC10
		ram[51]=10'd132;
		
		
		ram[52]=10'd3;			//INCAC
		
		ram[53]=10'd17;			//STMAC
		ram[54]=10'd0;			//***PC11
		ram[55]=10'd137;
		
		ram[56]=10'd3;			//INCAC
		
		ram[57]=10'd17;			//STMAC
		ram[58]=10'd0;			//***PC12
		ram[59]=10'd143;
		
		ram[60]=10'd3;			//INCAC
		
		ram[61]=10'd17;			//STMAC
		ram[62]=10'd0;			//***PC13
		ram[63]=10'd150;
		
		ram[64]=10'd11;			//SUB
		
		ram[65]=10'd17;			//STMAC
		ram[66]=10'd0;			//***PC14
		ram[67]=10'd154;
		
		ram[68]=10'd11;			//SUB
		
		ram[69]=10'd17;			//STMAC
		ram[70]=10'd0;			//***PC15
		ram[71]=10'd160;
		
		ram[72]=10'd11;			//SUB
		
		ram[73]=10'd17;			//STMAC
		ram[74]=10'd0;			//***PC16
		ram[74]=10'd166;		
		
		
		ram[75]=10'b1;			//LDAC
		ram[78]=10'd22;		//MUL
		ram[78]=10'd22;		//MUL
		ram[79]=10'b100;		//MVAC
		
		ram[80]=10'b1;			//LDAC
		ram[83]=10'd22;		//MUL
		ram[84]=10'd22;		//MUL		
		ram[85]=10'b1010;		//ADD
		ram[86]=10'b100;		//MVAC
		
		ram[87]=10'b1;			//LDAC
		ram[90]=10'd22;		//MUL
		ram[91]=10'd22;		//MUL
		ram[92]=10'b1010;		//ADD
		ram[93]=10'b100; 		//MVAC
		
		ram[94]=10'b1;			//LDAC
		ram[97]=10'd22;		//MUL
		ram[98]=10'd22;		//MUL
		ram[99]=10'b1010;		//ADD
		ram[100]=10'b100; 	//MVAC
		
		ram[101]=10'b1;			//LDAC
		ram[104]=10'd22;		//MUL
		ram[105]=10'b1010;		//ADD
		ram[106]=10'b100; 	//MVAC
		
		ram[107]=10'b1;			//LDAC
		ram[110]=10'd22;		//MUL
		ram[111]=10'b1010;		//ADD
		ram[112]=10'b100; 		//MVAC
		
		ram[113]=10'b1;			//LDAC
		ram[116]=10'd22;		//MUL
		ram[117]=10'b1010;		//ADD
		ram[118]=10'b100; 	//MVAC
		
		ram[119]=10'b1;			//LDAC
		ram[122]=10'd22;		//MUL
		ram[123]=10'b1010;		//ADD
		ram[124]=10'b100; 	//MVAC
		
		ram[125]=10'b1;			//LDAC
		ram[128]=10'd22;		//MUL
		ram[129]=10'b1010;		//ADD
		ram[130]=10'b100; 	//MVAC
		
		ram[131]=10'b1;			//LDAC
		ram[134]=10'b1010;		//ADD
		ram[135]=10'b100; 	//MVAC
		
		ram[136]=10'b1;			//LDAC
		ram[139]=10'd22;		//MUL
		ram[140]=10'b1010;		//ADD
		ram[141]=10'b100; 	//MVAC
		
		ram[142]=10'b1;			//LDAC
		ram[145]=10'd22;		//MUL
		ram[146]=10'b1010;		//ADD
		ram[147]=10'b100; 	//MVAC
		
		ram[148]=10'b1;			//LDAC
		ram[151]=10'b1010;		//ADD
		ram[152]=10'b100; 	//MVAC
		
		ram[153]=10'b1;			//LDAC
		ram[156]=10'd22;		//MUL
		ram[157]=10'b1010;		//ADD
		ram[158]=10'b100; 	//MVAC
		
		ram[159]=10'b1;			//LDAC
		ram[162]=10'd22;		//MUL
		ram[163]=10'b1010;		//ADD
		ram[164]=10'b100; 	//MVAC
		
		ram[165]=10'b1;			//LDAC
		ram[168]=10'b1010;		//ADD
		ram[169]=10'b100; 	//MVAC
	
		
		ram[170]=10'b10011;		//DIV

		ram[171]=10'b10;			//STAC
		
		ram[172]=10'b10010;		//LDMAC
		ram[173]=10'b0;				//1017
		ram[174]=10'd1017;
		
		ram[175]=10'b11;		//INCAC
		
		ram[176]=10'b10001;		//STMAC
		ram[177]=10'b0;				//1017
		ram[178]=10'd1017;
		
		ram[179]=10'b10010;		//LDMAC
		ram[180]=10'b0;
		ram[181]=10'd1007;	//1007
		
		ram[182]=10'b11;		//INCAC
		ram[183]=10'b11;		//INCAC
		
		ram[184]=10'b10001;	//STMAC
		ram[185]=10'b0;
		ram[186]=10'd1007;	//1007
		
		ram[187]=10'b100;		//MVAC
		
		ram[188]=10'b10010;		//LDMAC
		ram[189]=10'b0;
		ram[190]=10'b11111_10011;	//1011
		
		ram[191]=10'b1001;			//JMPP							LOOP1
		ram[192]=10'b0;
		ram[193]=10'd518;		//518
		//*****************************//
		
		
		ram[194]=10'b1;			//LDAC
		ram[195]=10'b0;			//1013
		ram[196]=10'd1013;
		
		ram[197]=10'b100;		//MVAC
		
		ram[198]=10'b10010;		//LDMAC
		ram[199]=10'b0;
		ram[200]=10'd1011;	//1011
		
		
		ram[201]=10'b1010;		//ADD
		ram[202]=10'b1010;		//ADD
		
		ram[203]=10'b100;		//MVAC
		
		ram[204]=10'b10010;		//LDMAC
		ram[205]=10'b0;				//1015
		ram[206]=10'd1015;
		
		ram[207]=10'b1001;			//JMPP
		ram[208]=10'b0;
		ram[209]=10'd212;		//212
	
		ram[210]=10'd20;          //IRout = 20;             ***************************** changed  **************
		ram[211]=10'b110;		//JUMP
		ram[212]=10'b0;
		ram[213]=10'd211;
	/*	ram[87]=10'b110;		//JUMP
		ram[88]=10'b0;
		ram[89]=10'b1011010;		//90
		
		ram[90]=10'b110;		//JUMP
		ram[91]=10'b0;
		ram[92]=10'b1010111;	//87               */
		
		ram[212]=10'b1;		//LDAC
		ram[213]=10'b0;		//1013
		ram[214]=10'd1013;
		
		ram[215]=10'b100;		//MVAC
		
		ram[216]=10'b10010;//LDMAC
		ram[217]=10'b0;
		ram[218]=10'd1011;	//1011
		
		ram[219]=10'b1010;		//ADD
		
		ram[220]=10'd3;			//INCAC
		ram[221]=10'd3;			//INCAC
		
		ram[222]=10'b10001;		//STMAC
		ram[223]=10'b0;
		ram[224]=10'd1007;	//1007;
		
		ram[225]=10'b1010;		//ADD
		
		ram[226]=10'd21;			//DECAC
		ram[227]=10'd21;			//DECAC
		
		ram[228]=10'b10001;		//STMAC
		ram[229]=10'b0;
		ram[230]=10'd1011;	//1011
		
		ram[231]=10'b110;		//JUMP
		ram[232]=10'b0;
		ram[233]=10'd518;           
									 

	 end
	 
	 always @(negedge clk) begin
		if (RoW)begin
			ram[Address] <= DataIn;
		end
		//assign ram[Address] = (Write)? DataIn : 10'bz;
	 end


endmodule




/*ram[0]=10'b10010;
		ram[1]=10'b0;
		ram[2]=10'b11111_11001;
		ram[3]=10'b10001;
		
		ram[4]=10'b0;
		ram[5]=10'b1_01100;
		
		ram[6]=10'b1;
		ram[7]=10'b0;
		ram[8]=10'b11111_10101;
		ram[9]=10'b100;
		ram[10]=10'b10010;
		ram[11]=10'b0;
		ram[12]=10'b11111_01111;
		ram[13]=10'b10001;
		
		ram[14]=10'b0;
		ram[15]=10'b11101;
		
		ram[16]=10'b1010;
		ram[17]=10'b10001;
		
		ram[18]=10'b0;
		ram[19]=10'b100000;
		
		ram[20]=10'b11;
		ram[21]=10'b10001;
		
		ram[22]=10'b0;
		ram[23]=10'b100100;
		
		ram[24]=10'b1011;
		ram[25]=10'b1001;
		
		ram[26]=10'b0;
		ram[27]=10'b1_01000;
		
		ram[28]=10'b1;
		
		ram[30]=10'b100;
		ram[31]=10'b1;
		
		ram[33]=10'b1010;
		ram[34]=10'b100;
		ram[35]=10'b1;
		
		ram[37]=10'b1010;
		ram[38]=10'b100;
		ram[39]=10'b1;
		
		ram[41]=10'b1010;
		
		ram[42]=10'b10011;
		ram[43]=10'b10;
		
		ram[45]=10'b10010;
		ram[46]=10'b0;
		ram[47]=10'b11111_11001;
		ram[48]=10'b11;
		ram[49]=10'b10001;
		ram[50]=10'b0;
		ram[51]=10'b11111_11001;
		ram[52]=10'b10010;
		ram[53]=10'b0;
		ram[54]=10'b11111_01111;
		ram[55]=10'b11;
		ram[56]=10'b11;
		ram[57]=10'b10001;
		ram[58]=10'b0;
		ram[59]=10'b11111_01111;
		ram[60]=10'b100;
		ram[61]=10'b10010;
		ram[62]=10'b0;
		ram[63]=10'b11111_10011;
		ram[64]=10'b1001;
		ram[65]=10'b0;
		ram[66]=10'b0;
		ram[67]=10'b10010;
		ram[68]=10'b0;
		ram[69]=10'b11111_10011;
		ram[70]=10'b100;
		ram[71]=10'b1;
		ram[72]=10'b0;
		ram[73]=10'b11111_10101;
		ram[74]=10'b1010;
		ram[75]=10'b100;
		ram[76]=10'b10010;
		ram[77]=10'b0;
		ram[78]=10'b11111_10111;
		ram[79]=10'b1001;
		//jumpp
		ram[80]=10'b0;
		ram[81]=10'b10_11010;
		//finish
		ram[82]=10'b10100;
		ram[85]=10'b10100;
		ram[86]=10'b110;
		ram[87]=10'b0;
		ram[88]=10'b10_10010;
		
		//loop2
		ram[90]=10'b10010;
		ram[91]=10'b0;
		ram[92]=10'b11111_10101;
		ram[93]=10'b100;
		ram[94]=10'b10010;
		ram[95]=10'b0;
		ram[96]=10'b11111_10011;
		ram[97]=10'b1010;
		ram[98]=10'b10001;
		ram[99]=10'b0;
		ram[100]=10'b11111_01111;//m0
		ram[101]=10'b1010;
		ram[102]=10'b10001;
		ram[103]=10'b0;
		ram[104]=10'b11111_10011;//m2
		ram[105]=10'b110;
		ram[106]=10'b0;
		ram[107]=10'b0;
		*/
		
	
	
		/*ram[1007]=10'b1;				//A initial 1024
		ram[1008]=10'b0;
		
		ram[1009]=10'b1;				//A0 = 1024
		ram[1010]=10'b0;
		
		ram[1011]=10'b1;				//A0+w - initial 1032
		ram[1012]=10'b1000;
		
		ram[1013]=10'b1000;	//w = 8
		ram[1014]=10'b1000;	//h = 8
		
		ram[1015]=10'b1;				//A0+HW = 1088
		ram[1016]=10'b1000000;
		
		ram[1017]=10'b1001;				//X = 10000 initially
		ram[1018]=10'b1100010000;*/
		
/*
ram[0]=10'b1;//LDAC
ram[1]=10'b1;//1024
ram[2]=10'b0;

ram[3]=10'b101;//MVR
ram[4]=10'b1;//LDAC
ram[5]=10'b1;//1025
ram[6]=10'b1;

ram[7]=10'b1001;//JMPP
ram[8]=10'b0;
ram[9]=10'b10100;

ram[20]=10'b10;
ram[21]=10'b0;
ram[22]=10'b10111;*/
	