module PC2FPGA_UART_Test
(
	//global clock 50MHz
	input				clk_50m,			//50MHz
	input 				rst_n,
	//user interfaces 
	input		[159:0]	input_data,
	output				fpga_txd,		//fpga 2 pc uart transfer
	output				divide_clk	//precise clock output
);
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

//8 * 22 = 176
wire	[175:0] data = {
								8'h5A, 8'h5A, 
								input_data
							};
wire	txd_flag;
reg 	[7:0]	txd_data;
wire 			txd_en;
assign 			txd_en = 1'b1;
reg		[4:0]	txd_cnt;
always@(posedge clk_50m or negedge rst_n)
begin 
	if(!rst_n)
		txd_cnt <= 5'd21;
	else if(txd_flag)
		begin 
		if(txd_cnt > 5'd0)
			txd_cnt <= txd_cnt -1'b1;
		else 
			txd_cnt <=5'd21;
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
	default: ;
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

