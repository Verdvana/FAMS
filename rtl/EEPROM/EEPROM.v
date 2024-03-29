/*************************************************************
Title		:	基于I2C通信协议的EEPROM 24LC04设计
Time		:	2019/7/1
Author	:	Eric Ni
Team		:	Veneno
Version	:	V3.0
Statement:	实现循环写10个字节,每10s写一次按键时读取已写入的字符
*************************************************************/
module EEPROM(
			input							clk,				//外部输入时钟
			input							rst_n,
			input							key,				//按键
			input				[79:0]	data_in,			//输入数据
			inout							sda,				//IIC的数据线
			output	reg				scl,				//IIC的时钟线
			output			[79:0]	data_out,		//数据输出
			output						end_o  			//结束信号

);
												
						reg					sda_buffer;		//写入的数据的中间寄存器
						reg					flag;				//控制系统是否占有总线控制权
						reg		[7:0]		count;			//计数器
						reg					clk_sys;			//系统时钟
						
						reg		[6:0]		state;			//状态寄存器
						reg		[20:0]	cnt; 				//发送或接收数据的个数
						reg		[5:0]		cnt_w;			//写入次数
						reg		[5:0]		cnt_r;			//读取次数
						reg		[5:0]		read_cnt;		//需要读取的次数
						reg		[1:0]		temp;				//读/写使能的中间寄存器
						reg 		[7:0]		memory;			//发送或接收数据的中间寄存器（控制字）
						
						reg 		[1:0]		key_data;		//判断读/写
						reg		[7:0]		memory_w;		//控制字（写）
						reg		[7:0]		memory_r;		//控制字（读）
						reg		[7:0]		slave_addr;		//寄存器高8位地址
						reg		[1:0]		num;				//读写次数
						reg		[1:0]		read_num;
						reg 					end_reg;			//结束信号
						reg					key_check;		//判断按键有无按下
						reg					oneoff;			//进入read一次性
						reg		[79:0]	data_r;			//输出数据寄存器	
						wire					read;				//切换到read模式
						
						//wire		[79:0]	data_in;
						
localparam write_t = 2000000;
localparam end_t = 200000;

//assign	data_in = 80'd123456789;
	
//----------------read----------------------------
assign read = (key_check & oneoff) ? 1'b1 : 1'b0;	//1 --read模式
																	//0 --write模式
//----------------sda-----------------------------
assign sda 	 = (flag) ? sda_buffer : 1'bz;	//flag = 1 --系统拥有总线控制权，
															//发送sda_buffer的数据
															//flag = 0 --释放总线
															
//----------------data_out----------------------------															
assign data_out  = (end_reg)? data_r : data_out;	//输出数据

//----------------end_o---------------------------
assign end_o = end_reg;								//结束信号

//----------------key_check-----------------------
always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			key_check	<= 1'b0;
		else if(!key)
			key_check  	<= 1'b1;
	end			
//----------------clk_sys-------------------------
always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				clk_sys <= 1'b0;
				count	<= 8'd0;
			end
		else
			if (count < 61)	//分频成为近400kHz的时钟
				count <= count +1; 
			else
				begin
					count <= 8'd0;
					clk_sys <= ~clk_sys;
				end
	end	

//----------------scl-----------------------------
always @(negedge clk_sys or negedge rst_n)
	begin
		if(!rst_n)
			begin
				scl <= 1'b1;	//复位时，scl为高
			end
		else
			begin
				if (state > 0)	//当总线忙时，scl为近200kHz的时钟
					scl <= ~scl;
				else
					scl <= 1'b1;//空闲时，scl为高
			end
	end	
	
//----------------state---------------------------
always @ (posedge clk_sys or negedge rst_n)
	begin
	 	if (!rst_n)
	 		begin
	 			data_r 		<= 8'd0;
	 			flag 		 	<= 1'b1;		//复位时，系统获得总线的控制权
	 			sda_buffer 	<= 1'b1; 	//向IIC的数据线上发送高电平
	 			state 		<= 7'd0;
	 			temp 			<= 2'b00;
	 			num 			<= 2'b0;
	 			end_reg 		<= 1'b0;
				slave_addr	<= 8'h00;
				cnt			<= 6'd0;
				cnt_w			<= 6'd0;
				cnt_r			<= 6'd0;
				read_num		<= 2'b0;
				read_cnt		<= 6'b0;
				oneoff		<= 1'b1;
	 		end
	 	else
	 		case(state)
	 			0:begin //发送启动信号
						if (scl)
							begin
								if(read)	//由写状态转至读状态
									begin
										if(cnt_w == 6'd0)	//写处于临界状态			
											if(num == 2'd0)	//写处于后半区写完，重新回到前半区写第一个
												begin
													read_num = 2'd1;	//读到后半区
													read_cnt = 6'd15; //读完后半区
												end
											else 					//写处于后半区第一个次写入
												begin
													read_num = 2'd0; 	//读前半区
													read_cnt = 6'd15; //读完前半区
												end
										else					//写未处于临界状态
											begin
													read_num = num;	//将写和读处于同一个半区
													read_cnt = cnt_w - 1'b1;	//读的次数为写的次数减1
											end
										num = 2'd2;
										state <= 1;
										sda_buffer <= 1'b0;	//发送启动信号
										state <= 1;
										flag <= 1'b1;
										temp <= 2'b10;		//将读写信号保存
										memory <= 8'b10100000;	//写控制字
										end_reg <= 1'b0;
										oneoff <= 1'b0;
										slave_addr <= 8'h00;
									end
								else
									begin
										sda_buffer <= 1'b0;	//发送启动信号
										state <= 1;
										flag <= 1'b1;
										temp <= key_data;		//将读写信号保存
										memory <= memory_w;	//写控制字
										end_reg <= 1'b0;
									end
							end
						else 
							state <= 0;
					
	 			end
	 			1:begin //发送8位写控制字
	 				if ((scl == 0) && (cnt < 8))
	 					begin
	 					 	sda_buffer <= memory[7];
	 					 	cnt <= cnt + 1;
	 					 	memory = {memory[6:0],memory[7]};
	 					 	state <= 1;
	 					end 
	 				else 
	 					begin
	 						if ((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								flag <= 0;	//释放总线控制权
	 								state <= 2;
	 							end
	 						else 
	 							begin
	 								state <= 1;
	 							end
	 					end
	 			end	 			
	 			2:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 3;
	 						memory <= slave_addr; //寄存器8位地址
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			3:begin //发送寄存器8位地址
	 				if((scl == 0) && (cnt < 8)) 
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 3;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
									state <= 4;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 3;
	 					 		end
	 					end 
	 			end
	 			4:begin //判断读/写信号
	 				if(!sda)
	 					begin
	 						if(temp == 2'b01)				//判断写信号
	 							begin
	 								state <= 5;
	 								memory <= data_in[79:72]; //写数据
	 							end
	 						if(temp == 2'b10)				//判断读信号
	 							state <= 27;
	 					end
	 				else 
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			5:begin //写入一字节数据1
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 5;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 6;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 5;
	 					 		end
	 					end 
	 			end
	 			6:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 7;
							memory <= data_in[71:64];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				7:begin //写入一字节数据2
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 7;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 8;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 7;
	 					 		end
	 					end 
	 			end
	 			8:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 9;
							memory <= data_in[63:56];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				9:begin //写入一字节数据3
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 9;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 10;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 9;
	 					 		end
	 					end 
	 			end
	 			10:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 11;
							memory <= data_in[55:48];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				11:begin //写入一字节数据4
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 11;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 12;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 11;
	 					 		end
	 					end 
	 			end
	 			12:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 13;
							memory <= data_in[47:40];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				13:begin //写入一字节数据5
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 13;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 14;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 13;
	 					 		end
	 					end 
	 			end
	 			14:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 15;
							memory <= data_in[39:32];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				15:begin //写入一字节数据6
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 15;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 16;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 15;
	 					 		end
	 					end 
	 			end
	 			16:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 17;
							memory <= data_in[31:24];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				17:begin //写入一字节数据7
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 17;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 18;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 17;
	 					 		end
	 					end 
	 			end
	 			18:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 19;
							memory <= data_in[23:16];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				19:begin //写入一字节数据8
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 19;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 20;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 19;
	 					 		end
	 					end 
	 			end
	 			20:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 21;
							memory <= data_in[15:8];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				21:begin //写入一字节数据9
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 21;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 22;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 21;
	 					 		end
	 					end 
	 			end
	 			22:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 23;
							memory <= data_in[7:0];
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
				23:begin //写入一字节数据10
	 				if((scl == 0) && (cnt < 8)) //发送数据
	 					begin
	 						flag <= 1;
	 						sda_buffer <= memory[7];
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],memory[7]};
	 						state <= 23;
	 					end
	 				else
	 					begin
	 					 	if((scl == 0) && (cnt == 8))
	 					 		begin
	 					 			cnt <= 0;
	 					 			flag <= 0;
	 					 			state <= 24;
	 					 		end
	 					 	else 
	 					 		begin
	 					 			state <= 23;
	 					 		end
	 					end 
	 			end
	 			24:begin //检测应答信号
	 				if (!sda)
	 					begin
	 						state <= 25;
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			25:begin //准备发送停止信号
	 				if(scl == 0)
	 					begin
	 						flag <= 1;
	 						sda_buffer <= 0; 	//拉低IIC的数据线
													//为发送停止信号做准备
	 						state <= 26;
	 					end
	 				else 
	 					state <= 25;
	 			end
	 			26:begin //发送停止信号
	 				if(scl == 1)
	 					begin
	 						sda_buffer <= 1; 	//发送停止信号
	 						if(cnt_w == 6'd15)
								begin
									cnt_w <= 6'd0;
									slave_addr <= 8'h00;	//寄存器地址清零
									state <= 54;
									if(num == 2'd1)	//若写完后半区，则重新开始写前半区
										num <= 2'd0;
									else 					//若写完前半区，则开始写后半区
										num <= 2'd1;
								end
							else
								begin
									cnt_w <= cnt_w + 1'b1;	//写次数+1
									slave_addr	<= slave_addr + 8'd16;		//寄存器地址+16
									state <= 54; 	  	//每写一次进入一次延时
								end
	 					end
	 				else
	 					state <= 26;
	 			end

	 			//------------------------------------------------

	 			27: begin //准备发送启动信号
	 				flag <= 1;
	 				sda_buffer <= 1; 		//拉高IIC数据线
												//为发送启动信号做准备
	 				state <= 28;
	 			end
	 			28:begin //发送启动信号
	 				sda_buffer <= 0; 		//发送启动信号
	 				state <= 29;
	 				memory <= memory_r; 	//读控制字
	 			end
	 			29:begin //发送8位读控制字
	 				if ((scl == 0) && (cnt < 8))
	 					begin
	 						flag <= 1;
	 					 	sda_buffer <= memory[7];
	 					 	cnt <= cnt + 1;
	 					 	memory = {memory[6:0],memory[7]};
	 					 	state <= 29;
	 					end 
	 				else 
	 					begin
	 						if ((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								flag <= 0;	//释放总线控制权
	 								state <= 30;
	 							end
	 						else 
	 							begin
	 								state <= 29;
	 							end
	 					end
	 			end
	 			30:begin //检测应答信号
	 				if(!sda)
	 					begin
	 						state <= 31;
	 					end
	 				else 
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			31:begin //读取第1个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 31;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[79:72] <= memory; 					//输出数据1
	 								flag <= 1;
	 								state <= 32;
	 								sda_buffer <= 0;
	 							end
	 						else 
	 							state <= 31;
	 					end
	 			end
	 			32:begin  //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 32;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 33;
							flag <= 0;
						end
				end
	 			33:begin //读取第2个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 33;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[71:64] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 34;
	 							end
	 						else 
	 							state <= 33;
	 					end
	 			end
	 			34:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 34;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 35;
							flag <= 0;
						end
				end
				35:begin //读取第3个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 35;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[63:56] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 36;
	 							end
	 						else 
	 							state <= 35;
	 					end
	 			end
	 			36:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 36;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 37;
							flag <= 0;
						end
				end
				37:begin //读取第4个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 37;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[55:48] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 38;
	 							end
	 						else 
	 							state <= 37;
	 					end
	 			end
	 			38:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 38;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 39;
							flag <= 0;
						end
				end
				39:begin //读取第5个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 39;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[47:40] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 40;
	 							end
	 						else 
	 							state <= 39;
	 					end
	 			end
	 			40:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 40;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 41;
							flag <= 0;
						end
				end
				41:begin //读取第6个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 41;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[39:32] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 42;
	 							end
	 						else 
	 							state <= 41;
	 					end
	 			end
	 			42:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 42;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 43;
							flag <= 0;
						end
				end
				43:begin //读取第7个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 43;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[31:24] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 44;
	 							end
	 						else 
	 							state <= 43;
	 					end
	 			end
	 			44:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 44;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 45;
							flag <= 0;
						end
				end
				45:begin //读取第8个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 45;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[23:16] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 46;
	 							end
	 						else 
	 							state <= 45;
	 					end
	 			end
	 			46:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 46;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 47;
							flag <= 0;
						end
				end
				47:begin //读取第9个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 47;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[15:8] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 0;
	 								state <= 48;
	 							end
	 						else 
	 							state <= 47;
	 					end
	 			end
	 			48:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 48;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 49;
							flag <= 0;
						end
				end
				49:begin //读取第10个字节数据
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 49;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								data_r[7:0] <= memory; //输出数据2
									flag <= 1;
									sda_buffer <= 1;
	 								state <= 50;
	 							end
	 						else 
	 							state <= 49;
	 					end
	 			end
	 			50:begin //发送应答信号
					if((scl == 1) && (cnt < 1))
						begin
							cnt <= 0;
							state <= 50;
							flag <= 1;
						end
					else if(scl == 0)
						begin
							cnt <= 0;
							state <= 51;
							flag <= 0;
						end
				end
	 			51:begin //准备发送停止信号
	 				if(scl == 0)
	 					begin
	 						sda_buffer <= 0;	//拉低IIC，准备停止信号
	 						state <= 52;
	 					end
	 				else 
	 					state <= 51;
	 			end
	 			52:begin //发送停止信号
	 				if(scl == 1)
	 					begin
	 						sda_buffer <= 1;
							end_reg	  <= 1'b1;
							if(read_num == 2'd0)	//只需要读前半区或前半区读完，开始读后半区
								begin
									if(cnt_r == read_cnt)	//读到read_cnt次为止
										begin
											//cnt_r <= 6'd0;
											slave_addr <= 8'h00;	//寄存器地址清零
											state <= 56;
											//num <= 2'd0;
										end
									else
										begin
											cnt_r <= cnt_r + 1'b1;	//读次数+1
											slave_addr	<= slave_addr + 8'd16;		//寄存器地址+16
											state <= 55;
										end
								end
							else if(read_num == 2'd1) //需要读前半区和后半区
								begin
									if(cnt_r == 6'd15) //读完前半区
										begin
											cnt_r <= 6'd0;	//读次数清零
											slave_addr <= 8'h00;	//寄存器地址清零
											state <= 55;	
											read_num <= 2'd0; //读完前半区，开始读后半区
											num <= 2'd3;	//num转到后半区
										end
									else
										begin
											cnt_r <= cnt_r + 1'b1;	//读次数+1
											slave_addr	<= slave_addr + 8'd16;		//寄存器地址+16
											state <= 55;
										end
								end
	 					end
	 				else 
	 					state <= 52;
	 			end
				53:begin	//终止进程
					end_reg <= 1'b0;
					state <= 53;
				end
				54:begin	//延时10秒
	 					if((scl == 1) && (cnt < write_t))
	 						begin
	 							cnt <= cnt + 1;
	 							state <= 54;
	 						end
	 					else 
	 						begin
	 							if((scl == 1) && (cnt == write_t))
									begin
										cnt <= 0;
										state <= 0;		
									end
								else 
									state <= 54;
	 						end
	 			end
				55:begin	//延时10秒
	 					if((scl == 1) && (cnt < end_t))
	 						begin
								end_reg	  <= 1'b0;
	 							cnt <= cnt + 1;
	 							state <= 55;
	 						end
	 					else 
	 						begin
	 							if((scl == 1) && (cnt == end_t))
									begin
										cnt <= 0;
										state <= 0;		
									end
								else 
									state <= 55;
	 						end
	 			end
				56:begin	//延时10秒
	 					if((scl == 1) && (cnt < end_t))
	 						begin
								end_reg	  <= 1'b0;
	 							cnt <= cnt + 1;
	 							state <= 56;
	 						end
	 					else 
	 						begin
	 							if((scl == 1) && (cnt == end_t))
									begin
										cnt <= 0;
										state <= 53;		
									end
								else 
									state <= 56;
	 						end
	 			end
	 			default : state <= 0;
	 		endcase
	 end 

//----------------num----------------------------
always @(*)
	begin
		case(num)
				2'd0:	
					begin
						key_data		= 2'b01;	//写数据1~16次 前半区
						memory_w		= 8'b10100000;	
					end 
				2'd1:	
					begin
						key_data		= 2'b01;	//写数据17~32次 后半区
						memory_w		= 8'b10100010;	
					end 
				2'd2:	
					begin
						key_data		= 2'b10;	//读数据1~16次 前半区
						memory_w		= 8'b10100000;	
						memory_r		= 8'b10100001;	
					end  
				2'd3:	
					begin 
						key_data		= 2'b10;	//读数据17~32次 后半区
						memory_w		= 8'b10100010;	
						memory_r		= 8'b10100011;	
					end  
				default :;
		endcase
	end


endmodule