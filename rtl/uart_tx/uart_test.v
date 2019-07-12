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
Technology blogs 	: 		www.crazyfpga.com
Email Address 		: 		crazyfpga@vip.qq.com
Filename			:		PC2FPGA_UART_Test.v
Date				:		2013-10-31
Description			:		Test UART Communication between PC and FPGA.
Modification History	:
Date			By			Version			Change Description
=========================================================================
13/10/31		CrazyBingo	1.0				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+------------------------------oooO--(   )-----------------------------+
                              (   )   ) /
                               \ (   (_/
                                \_)
----------------------------------------------------------------------*/   

`timescale 1ns/1ns
module PC2FPGA_UART_Test
(
	//global clock 50MHz
	input				clk_50m,			//50MHz
	input 				rst_n,
	//user interfaces 
	input					txd_start,
	input		[159:0]	input_data,
	output				fpga_txd,	//fpga 2 pc uart transfer
	output				divide_clk
);


/*

wire key_flag;
key
#(.KEY_WIDTH(1))
key_inst
(
	//global clock
	.clk(clk_50m),     
   .rst_n(rst_n),
	
	//key interface
	.key_data(txd_start),
	
	//user interface
	.key_flag(key_flag),
.	key_value()	//H Valid
);
*/

//----------------------------------
//sync global clock and reset signal
//------------------------------------
//Precise clk divider
wire	divide_clken;
precise_divider	
#(
	//DEVIDE_CNT = 42.94967296 * fo
	
//	.DEVIDE_CNT	(32'd175921860)	//256000bps * 16	
//	.DEVIDE_CNT	(32'd87960930)	//128000bps * 16
//	.DEVIDE_CNT	(32'd79164837)	//115200bps * 16
	.DEVIDE_CNT	(32'd13194140)	//9600bps * 16
//	.DEVIDE_CNT (32'd175921860)		//testbench
)
u_precise_divider
(
	//global
	.clk				   (clk_50m),		//50MHz clock
	.rst_n				(rst_n),    //global reset
	
	//user interface
	.divide_clk			(divide_clk),
	.divide_clken		(divide_clken)
);


wire	[175:0] data = {
								8'h5A, 8'h5A, 
								input_data
							};
							
							
wire	txd_flag;

reg 	txd_en;
reg 	[7:0]	txd_data;
reg		[4:0]	txd_cnt;



//
//reg    txd_start;
//reg   [39:0] delay_cnt;
//always@(posedge clk_50m or negedge rst_n)
//begin 
// if(!rst_n)
//  delay_cnt <= 0;
// else if(delay_cnt < 39'd500000000)
//  begin 
//  delay_cnt <= delay_cnt + 1'b1;
//  txd_start <= 1'b0;
//  end 
// else 
//  begin 
//   delay_cnt <= 39'd0;
//   txd_start <= 1'b1;
//  end 
//
//end 





always@(posedge clk_50m or negedge rst_n)
begin 
	if(!rst_n)
		begin
		txd_cnt <= 	5'd21;
		txd_en  <= 	1'b0;
		end 
	else if(txd_start)
		txd_en  <= 1'b1;
	else if(txd_flag)
		begin 
		if(txd_cnt > 5'd0)
			begin 
			txd_cnt <= txd_cnt - 1'b1;
			if(txd_cnt == 5'd1)
				txd_en  <= 1'b0;
			end 
		else 
			txd_cnt <= 5'd21;
		end 
	else 
		txd_cnt <= txd_cnt;
end 


always@(*)
begin 
	case(txd_cnt)
	5'd0:		txd_data <= data[7:0];
	5'd1:		txd_data <= data[15:8];
	5'd2:		txd_data <= data[23:16];
	5'd3:		txd_data <= data[31:24];
	5'd4:		txd_data <= data[39:32];
	5'd5:		txd_data <= data[47:40];
	5'd6:		txd_data <= data[55:48];
	5'd7:		txd_data <= data[63:56];
	5'd8:		txd_data <= data[71:64];
	5'd9:		txd_data <= data[79:72];
	5'd10:	txd_data <= data[87:80];
	5'd11:	txd_data <= data[95:88];
	5'd12:	txd_data <= data[103:96];
	5'd13:	txd_data <= data[111:104];
	5'd14:	txd_data <= data[119:112];
	5'd15:	txd_data <= data[127:120];
	5'd16:	txd_data <= data[135:128];
	5'd17:	txd_data <= data[143:136];
	5'd18:	txd_data <= data[151:144];
	5'd19:	txd_data <= data[159:152];
	5'd20:	txd_data <= data[167:160];
	5'd21:	txd_data <= data[175:168];
	default: txd_data <=	8'hFF;
	endcase 
end 

wire	clken_16bps = divide_clken;
//---------------------------------
//Data receive for PC to FPGA.
uart_transfer	u_uart_transfer
(
	//gobal clock
	.clk			   (clk_50m),
	.rst_n			(rst_n),
	
	//uaer interface
	.clken_16bps	(clken_16bps),	//clk_bps * 16
	.txd				(fpga_txd),  	//uart txd interface
           
	//user interface   
	.txd_en			(txd_en),		//uart data transfer enable
	.txd_data		(txd_data), 	//uart transfer data	
	.txd_flag		(txd_flag) 		//uart data transfer done
);


endmodule

