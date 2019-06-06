/*-----------------------------------------------------------------------
								 \\\|///
							   \\  - -  //
								(  @ @  )
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2012-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		www.crazyfpga.com
Email Address 		: 		crazyfpga@vip.qq.com
Filename			:		Sensor_Image_Zoom.v
Date				:		2017-06-19
Description			:		Sensor_Image_Zoom RAW to RGB888.
Modification History	:
Date			By			Version			Change Description
=========================================================================
17/06/19		CrazyBingo	1.0				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+------------------------------oooO--(   )-----------------------------+
                              (   )   ) /
                               \ (   (_/
                                \_)
----------------------------------------------------------------------*/ 

`timescale 1ns / 1ns
module Sensor_Image_Zoom
#(
	parameter	IMAGE_HSIZE = 640
)
(
	//CMOS Sensor Interface
	input				clk,				//image pixel clock
	input				rst_n,				//system reset
	
	input				image_in_vsync,		//H : Data Valid; L : Frame Sync(Set it by register)
	input				image_in_href,		//H : Data vaild, L : Line Sync
	input		[7:0]	image_in_data,		//8 bits cmos data input
	output	reg			image_out_vsync,	//H : Data Valid; L : Frame Sync(Set it by register)
	output				image_out_href,		//H : Data vaild, L : Line Sync
	output	reg	[7:0]	image_out_data		//8 bits cmos data input	
);


//-----------------------------------
//Image Hsize Zoom
reg	[11:0] image_xpos;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		image_xpos <= 0;
	else if(image_in_href == 1'b1)
		image_xpos <= image_xpos + 1'b1;
	else
		image_xpos <= 0;
end
assign	image_out_href = (image_xpos >= 1'b1 && image_xpos <= IMAGE_HSIZE)? 1'b1 : 1'b0;

//-----------------------------------
//Image Hsize Zoom

//-----------------------------------
//output reg
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		image_out_vsync <= 0;
		image_out_data <= 0;
		end
	else
		begin
		image_out_vsync <= image_in_vsync;
		image_out_data <= image_in_data;
		end
end



endmodule
