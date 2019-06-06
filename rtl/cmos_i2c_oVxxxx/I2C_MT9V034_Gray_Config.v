/*-----------------------------------------------------------------------
								 \\\|///
							   \\  - -  //
								(  @ @  )
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2013-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		http://blog.chinaaet.com/crazybingo
Email Address 		: 		thereturnofbingo@gmail.com
Filename			:		I2C_MT9V022_Gray_Config.v
Data				:		2014-05-11
Description			:		The Register of MT9V022
Modification History	:
Data			By			Version			Change Description
=========================================================================
14/05/11		CrazyBingo	1.0				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/
`timescale 1ns/1ns
module	I2C_MT9V034_Gray_Config
(
	input		[7:0]	LUT_INDEX,
	output	reg	[23:0]	LUT_DATA,
	output		[7:0]	LUT_SIZE
);

assign	LUT_SIZE = 8'd7;

//-----------------------------------------------------------------
/////////////////////	Config Data LUT	  //////////////////////////	
always@(*)
begin
	case(LUT_INDEX)
//	MT9V034 Register
	//Read Data Index
	0	:	LUT_DATA	=	{8'hFE, 16'hBEEF};	//Register Lock Code(0xBEEF: unlocked, 0xDEAD: locked)
	1	:	LUT_DATA	=	{8'h00, 16'h1313};	//Chip Verision (Read only)
	//Write Data Index
	//[Reset Registers]
	2	: 	LUT_DATA	= 	{8'h0C, 16'h0001};	// BIT[1:0]-Reset the Registers, At least 15 clocks
	3 	: 	LUT_DATA	= 	{8'h0C, 16'h0000};	// BIT[1:0]-Reset the Registers
	//[Vertical/Hortical Mirror]
	4	:	LUT_DATA	= 	{8'h0D, 16'h0000};	// BIT[4] : ROW Flip;	BIT[5]:	Column Flip									
	5	:	LUT_DATA	= 	{8'h0F, 16'h0001};	// High Dynamic Range Context A
	6  :	LUT_DATA =  {8'h70, 16'h0003};   // Enable Noise Correction
	default:LUT_DATA	=	{8'h00, 16'h1313};	//Chip Verision (Read only)
	endcase
end

endmodule
