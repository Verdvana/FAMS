/*============================================================================
*
*  LOGIC CORE:          GY_MCU90640驱动模块		
*  MODULE NAME:         GY_MCU90640
*	author:					Verdvana
*  REVISION HISTORY:  
*
*    Revision 1.0  2019/5/12     
*
*  FUNCTIONAL DESCRIPTION:
===========================================================================*/


module Process(
				input				clk_50m,
				input				rst_n,
				
				input  [7:0]  	data_in,
				input				uart_done,
				
				output			en_data,
				output			clk_out,
				
				output [2:0] 	Threshold,
				output reg [9:0]	 data_cnt,
				output [15:0]  data_out
);


//-------------------------------------
//uart_done信号边缘检测，让其只维持一个时钟周期

reg donebuf, donerise;

always @(posedge clk_50m)
begin
   donebuf <= uart_done;
   donerise <= (~donebuf) & uart_done;  
end
//-------------------------------



//-----------------------------------
//帧头检测状态机

reg [1:0] state;

wire flag ;

assign Threshold = (cnt==2)? 3'b000 : data_r[15:12];

always@(posedge clk_50m)
begin
	if(donerise)
		case(state)
			2'b00:
				begin
					if(data_in==8'h5A)
						state <= 2'b01;
				
					else
						state <= 2'b00;
					
				end
		
			2'b01:
				begin
					if(data_in==8'h5A)
						state <= 2'b10;
				
					else
						state <= 2'b00;
					
				end
			
			2'b10:
				begin
					if(data_in==8'h5A)
						state <= 2'b01;
				
					else
						state <= 2'b11;
				end
					
			2'b11:
				begin
					if(cnt==1538)
						state <= 2'b01;
				
					else
						state <= 2'b11;					
				end
		endcase
	
	else
		state<=state;
end

assign flag = state[0] && state[1]; 
//--------------------------------------



//--------------------------------------
//有效数据计数器
//一共1538个有效数据，前两个为固定值，第一个像素点的温度数据为第三四个数据的组合
reg [11:0] cnt;

always@(posedge uart_done)
begin
	if(flag)
		if(cnt==1541)
			cnt<=0;
		
		else
			cnt <= cnt +1;
	
	else
		cnt<=0;
end

assign en_data = (cnt >= 3 && cnt <= 1538)?1:0;
//--------------------------------------------------------------


//--------------------------------------------------
//分频
reg	clk_data=1;
always@(posedge uart_done)
begin
	if(!rst_n)
		clk_data <= 0;
	else
		clk_data <= ~clk_data;
		
end
//-------------------------------------------------------


//--------------------------------------------------
//数据组合，将两个八位数据组合为16为数据

reg [15:0] data_out_r;
always@(posedge clk_50m)
begin	
	if(!rst_n)
		data_out_r<=0;
			
	else
		if(donerise)
			data_out_r<={data_in,data_out_r[15:8]};	
		
		else
			data_out_r<=data_out_r;
end
//--------------------------------------------------

assign  clk_out = clk_data;

wire [15:0] data_out_reg;

assign  data_out_reg = (uart_done&& clk_data)? data_out_r:data_out_reg ;


//--------------------------------------------------
//延迟一个时钟
reg [15:0] data_r;
always@(posedge clk_data)
begin
	if(!rst_n)
		data_r <= 0;
	
	else 
		data_r <= data_out_reg ;
		
end
//--------------------------------------------------

//--------------------------------------------------
//温度值转化为RGB
parameter i=1;

wire [4:0] result_1;
wire [5:0] result_2;

assign result_1 = 5'b11111  - data_r[12:6];
assign result_2 = 6'b111111 - data_r[14:9];

assign data_out = ( data_r> 16'b0000_1111_1111_1111)? 
						((data_r> 16'b0001_1111_1111_1111)?
						((data_r> 16'b0011_1111_1111_1111)?
						
						({5'b11111,result_2,5'b00000}):
						({data_r[13:9],6'b111111,5'b00000})):
						({5'b00000,6'b111111,result_1}) ) : 
						({5'b00000,data_r[11:6],5'b11111});
//--------------------------------------------------


//--------------------------------------------------
//像素计数器
always@(posedge clk_data)
begin
	if(!rst_n)
		data_cnt <= 0;
	
	else if(en_data)
		begin
			if(data_cnt == 767)
				data_cnt <= 0;
			else
				data_cnt <= data_cnt+1;
		end
		
	else 
		data_cnt <= 0;		
end
//--------------------------------------------------
endmodule

