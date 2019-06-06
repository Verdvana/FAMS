module DHT11(
		input						clk_50m,
		input						rst_n,
		
		inout						data,
		
		
		output reg [39:0]  	tem_hum
);


//------------------------------------------
//分频，分成1us一个周期
reg [4:0]	cnt_0;
reg			clk_us;
always@(posedge clk_50m or negedge rst_n)
begin
	if(!rst_n)
		cnt_0 <= 5'b00000;
	
	else if(cnt_0 == 25)
		begin
			clk_us <= ~clk_us;
			cnt_0	 <= 5'b00000;
		end
			
	else
		cnt_0 <= cnt_0 + 1;
end


//------------------------------------------
//
reg [3:0]	state;  	//
reg [19:0]	cnt_1;
reg			data_r;		//数据输出输出寄存器
reg			flag;   		//释放总线flag
reg			read_start; //开始读数据指示
reg [5:0]	cnt_data;   //数据计数

reg [39:0]	data_reg;


assign data = flag ? data_r : 1'bz;

always@(posedge clk_us or negedge rst_n)
begin
	if(!rst_n)
		state <= 6'b00000;
	
	else
		begin
			case(state)
				4'd0:
					begin
						if(cnt_1==500000)
							begin
								cnt_1 <= 0;
								state <= 4'd1;
								flag  <= 1;
								read_start <= 0;
								cnt_data <= 6'd0;
							end
						
						else
							begin
								cnt_1<=cnt_1+1;
							end
					end
				
				4'd1:
					begin
						if(cnt_1==20000)   //20ms
							begin
								state <= 4'd2;
								cnt_1 <= 0;
							end
						
						else
							begin
								cnt_1 <= cnt_1 + 1;
								data_r  <= 0;
							end
					end
				
				4'd2:
					begin
						if(cnt_1==200)  //20us
							begin
								flag <= 0;
								cnt_1<= 0;
								state<= 4'd3;
							end
							
						else
							begin
								cnt_1 <= cnt_1+1;
								data_r<= 1;
							end
					end
				
				4'd3:
					begin
						if(data==0)
							state<= 4'd4;
						
						else
							state<= 4'd3;
					end
					
				4'd4:
					begin
						if(data==1)
							state<= 4'd5;
							
						else
							state<= 4'd4;
					end
				
				4'd5:
					begin
						if(data==0)
							state<= 4'd6;
							
						else
							state<= 4'd5;
					end
				
				4'd6:
					begin
						if(data==1)
							begin
								state<= 4'd7;
								read_start <= 1;
							end
						
						else
							state<= 4'd6;
							
					end
				
				4'd7:
					begin
						if(data==1)
							state <= 4'd8;
					
					end
					
				4'd8:
					begin
						if(cnt_1==50)
							begin
								cnt_1 <= 0;
								state <= 4'd9;
							end
						
						else
							begin
								cnt_1 <= cnt_1+1;
								state <= 4'd8;
							end
						
					end
				
				4'd9:
					begin
						if(data==1)
							begin
								data_reg[0] <= 1;
							end
						
						else
							begin
								data_reg[0] <= 0;
							end
							
						state <= 4'd12;
						cnt_data <= cnt_data + 1;						
					end
				
				4'd12:
					begin
						if(cnt_data == 40)
							begin
								cnt_data <= 0;
								state <= 4'd0;
								tem_hum <= data_reg;
							end
						
						else
							begin
								data_reg <= data_reg << 1;
								
								if(data==1)
									state<=4'd10;
								
								else
									state<=4'd11;
							end
					end
					
				4'd10:
					begin
						if(data==1)
							state<=4'd10;
						
						else
							state<=4'd11;
					end
					
				4'd11:
					begin
						if(data==0)
							state<=4'd11;
						
						else
							state<=4'd8;					
					end
					
				default:
					state <= 4'd0;
			endcase
		end
		
end



endmodule


