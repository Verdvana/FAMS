module Oxygen(
			input				clk,		//外部输入时钟
			input				rst_n,
			input				int,
			output	reg			scl,		//IIC的时钟线
			inout				sda,			//IIC的数据线
			output			menb        //拉低选中
);
					reg			sda_buffer;	//写入的数据的中间寄存器
					reg			flag;		//控制系统是否占有总线控制权
assign sda = (flag) ? sda_buffer :1'bz;		//flag = 1 --系统拥有总线控制权，
													   //发送sda_buffer的数据
											//flag = 0 --释放总线
assign menb = menb_r;											
											
//--------------------------------------------clk_sys
					reg	[7:0]	count;		//计数器
					reg			clk_sys;	//系统时钟
					reg [1:0]	key_data;
					reg	[7:0]	slave_addr;
					reg	[7:0]	word_data;
					reg	[3:0]	num;
					reg			menb_r;
always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				clk_sys <= 1'b0;
				count	<= 8'd0;
			end
		else
			if (count < 121)	//分频成为近200kHz的时钟
				count <= count + 1; 
			else
				begin
					count <= 8'd0;
					clk_sys <= ~clk_sys;
				end
	end	
	
//--------------------------------------------scl
					reg	[5:0]	state;		//状态寄存器
always @(negedge clk_sys or negedge rst_n)
	begin
		if(!rst_n)
			begin
				scl <= 1'b1;	//复位时，scl为高
			end
		else
			begin
				if (state > 0)	//当总线忙时，scl为近100kHz的时钟
					scl <= ~scl;
				else
					scl <= 1'b1;//空闲时，scl为高
			end
	end	
	
//--------------------------------------------state
					reg		[9:0]	cnt; 	//发送或接收数据的个数
					reg		[1:0]	temp;	//读/写使能的中间寄存器
					reg 	[7:0]	memory;	//发送或接收数据的中间寄存器（控制字）

always @ (posedge clk_sys or negedge rst_n)
	begin
	 	if (!rst_n)
	 		begin
	 			flag <= 1'b1;		//复位时，系统获得总线的控制权
	 			sda_buffer <= 1'b1; //向IIC的数据线上发送高电平
	 			state <= 0;
	 			temp <= 2'b00;
				num <= 4'b0;
				menb_r <= 1'b1;
	 		end
	 	else
	 		case(state)
	 			0:begin //发送启动信号
	 				if (scl)
	 					begin
	 						sda_buffer <= 1'b0;//发送启动信号
	 						state <= 1;
	 						flag <= 1'b1;
	 						temp <= key_data;//将读写信号保存
	 						memory <= 8'h90;//控制字
							menb_r <= 1'b0;
	 					end
	 				else 
	 					state <= 0;
	 			end

	 			1:begin //发送8位控制字
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
	 								state <= 4;
	 							end
	 						else 
	 							begin
	 								state <= 1;
	 							end
	 					end
	 			end
	 			4:begin
	 				if (!sda)//检测应答信号
	 					begin
	 						state <= 5;
	 						memory <= slave_addr; //SLAVE ADDRESS低位
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			5:begin
	 				if((scl == 0) && (cnt < 8)) //发送SLAVE ADDRESS
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
	 			6:begin 
	 				if(!sda)
	 					begin
	 						if(temp == 2'b01)//判断是否为写信号
	 							begin
	 								state <= 7;
	 								memory <= word_data;
	 							end
	 						if(temp == 2'b10)//判断是否为读信号
	 							state <= 11;
	 					end
	 				else 
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			7:begin
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
	 			8:begin
	 				if (!sda)//检测应答信号
	 					begin
	 						state <= 9;
	 					end
	 				else
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			9:begin
	 				if(scl == 0)
	 					begin
	 						flag <= 1;
	 						sda_buffer <= 0; //拉低IIC的数据线
	 										 //为发送停止信号做准备
	 						state <= 10;
	 					end
	 				else 
	 					state <= 9;
	 			end
	 			10:begin
	 				if(scl == 1)
	 					begin
	 						sda_buffer <= 1; //发送停止信号
							menb_r <= 1'b1;
	 						if (num == 4'd5)
	 							state <= 18;
	 						else 	
	 							begin
	 								num <= num + 1; 
	 								state <= 0;
	 							end
	 					end
	 				else
	 					state <= 10;
	 			end

	 			//------------------------------------------------

	 			11: begin 
	 				flag <= 1;
	 				sda_buffer <= 1; //拉高IIC数据线
	 								 //为发送启动信号做准备
	 				state <= 12;
	 			end
	 			12:begin
	 				sda_buffer <= 0; //发送启动信号
	 				state <= 13;
	 				memory <= 8'hAF; //控制字
	 			end
	 			13:begin //发送8位控制字
	 				if ((scl == 0) && (cnt < 8))
	 					begin
	 						flag <= 1;
	 					 	sda_buffer <= memory[7];
	 					 	cnt <= cnt + 1;
	 					 	memory = {memory[6:0],memory[7]};
	 					 	state <= 13;
	 					end 
	 				else 
	 					begin
	 						if ((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								flag <= 0;	//释放总线控制权
	 								state <= 14;
	 							end
	 						else 
	 							begin
	 								state <= 13;
	 							end
	 					end
	 			end
	 			14:begin
	 				if(!sda)
	 					begin
	 						state <= 15;
	 					end
	 				else 
	 					begin
	 						state <= 0;
	 					end
	 			end
	 			15:begin
	 				if((scl == 1) && (cnt < 8))
	 					begin
	 						cnt <= cnt + 1;
	 						memory <= {memory[6:0],sda};
	 						state <= 15;
	 					end
	 				else 
	 					begin
	 						if((scl == 0) && (cnt == 8))
	 							begin
	 								cnt <= 0;
	 								state <= 16;
	 							end
	 						else 
	 							state <= 15;
	 					end
	 			end
	 			16:begin 
	 				if(scl == 0)
	 					begin
	 						sda_buffer <= 0;//拉低IIC，准备停止信号
	 						state <= 17;
	 					end
	 				else 
	 					state <= 16;
	 			end
	 			17:begin //发送停止信号
	 				if(scl == 1)
	 					begin
	 						sda_buffer <= 1;
	 						if (num == 4'd5)
	 							state <= 18;
	 						else 	
	 							begin
	 								num <= num + 1; 
	 								state <= 0;
	 							end
	 					end
	 				else 
	 					state <= 17;
	 			end
	 			18:begin
	 				state <= 18;
	 			end
	 			default : state <= 0;
	 			endcase
	 end 

always @(*)
	begin
		case(num)
				4'd0:	
					begin
						key_data   = 2'b01;	//写
						slave_addr = 8'h12;	//MODECN--Mode Control Register
						word_data  = 8'h03; 
					end 
				4'd2:	
					begin
						key_data   = 2'b01;	//写
						slave_addr = 8'h01;	//LOCK--Protection Register
						word_data  = 8'h00;
						
					end
				4'd1:
					begin
					 	key_data   = 2'b01;	//写
						slave_addr = 8'h11;	//REFCN--Reference Control Register
						word_data  = 8'hB0;
					 end
				4'd3:
					begin
						key_data   = 2'b01;	//写
						slave_addr = 8'h10;	//TIACN--TIA Control Register
						word_data  = 8'h1F; 
					end
				4'd4:
					begin
					 	key_data   = 2'b01;	//写
						slave_addr = 8'h01;	//LOCK--Protection Register
						word_data  = 8'h01;
					end
				4'd5:
					begin
						key_data   = 2'b01;	//写
						slave_addr = 8'h12;	//MODECN--Mode Control Register
						word_data  = 8'h07; 
					end 
				default :;
		endcase
	end

endmodule
