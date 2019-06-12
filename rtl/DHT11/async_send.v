///////////////////////////////////////////
module async_send(
                  input			   clk,
					   input			   TxD_start,
					   input [7:0]	 TxD_data,					  
                  output reg   TxD,
					   output 		   TxD_busy	  
					  );
					 
				 
parameter Clk_Freq              = 50000000;	//50M
parameter Baud                  = 115200;  //波特率
parameter BaudGeneAccWidth      = 16;	
reg [BaudGeneAccWidth:0] BaudGeneAcc;	
	                                      /* 这里是为了避免超过32bit数出错 */
wire [BaudGeneAccWidth:0] BaudGeneInc = ((Baud<<(BaudGeneAccWidth-4))+(Clk_Freq>>5))/(Clk_Freq>>4);//constant	
wire BaudTick = BaudGeneAcc[BaudGeneAccWidth];	
/**********************************************************************************************************
时钟产生思想：类似计数器cnt从0开始计数，每次递增step = 3，则经过4个周期就计数到12，超出10两个计数
0 3 6 9 12 5 8 11 4 7 10 3 6 9 12 5 8 11
0 0 0 0 1  0 0 1  0 0 1  0 0 0 1  0 0 1大于等于10则输出高电平
***********************************************************************************************************/

reg [3:0] state;
wire TxD_ready = (state == 0);
assign TxD_busy = ~TxD_ready;	
always @(posedge clk) 
begin
   if(TxD_busy)    
	    BaudGeneAcc <= BaudGeneAcc[BaudGeneAccWidth-1:0] + BaudGeneInc;	
	else if(TxD_start)
       BaudGeneAcc <= {BaudGeneAccWidth{1'b1}};	//目的是使接收到触发信号后即刻启动发送
end	
///////////////////////////	
reg TxD_start_tmp1;
reg TxD_start_tmp2;
always @(posedge clk) 
begin
   TxD_start_tmp1 <= TxD_start;
	TxD_start_tmp2 <= TxD_start_tmp1;
end

wire TxD_start_pulse = (~TxD_start_tmp2) & TxD_start_tmp1;


reg [7:0] TxD_dataReg;
always @(posedge clk) 
begin
   if(TxD_ready & TxD_start_pulse) //TxD_ready is necessary!
	   TxD_dataReg <= TxD_data;
end

//state change part	
always @(posedge clk)
case(state)                                          
	4'd0 : if(TxD_start_pulse) state <= 4'd1;              
	4'd1 : if(BaudTick)  state <= 4'd2;                
	4'd2 : if(BaudTick)  state <= 4'd3;  // start      
	4'd3 : if(BaudTick)  state <= 4'd4;  // bit 0      
	4'd4 : if(BaudTick)  state <= 4'd5;  // bit 1      
	4'd5 : if(BaudTick)  state <= 4'd6;  // bit 2      
	4'd6 : if(BaudTick)  state <= 4'd7;  // bit 3      
	4'd7 : if(BaudTick)  state <= 4'd8;  // bit 4      
	4'd8 : if(BaudTick)  state <= 4'd9;  // bit 5      
	4'd9 : if(BaudTick)  state <= 4'd10; // bit 6      
	4'd10: if(BaudTick)  state <= 4'd11; // bit 7  	
	4'd11: if(BaudTick)  state <= 4'd0;  // stop1            
	default:             state <= 4'd0;            
endcase	                                             

//output part	
reg muxbit;	
always @(posedge clk)
case(state)                                         
	4'd0 :  muxbit <= 1'b1;                           
	4'd1 :  muxbit <= 1'b1;                           
	4'd2 :  muxbit <= 1'b0;            // start          
	4'd3 :  muxbit <= TxD_dataReg[0];  // bit 0       
	4'd4 :  muxbit <= TxD_dataReg[1];  // bit 1       
	4'd5 :  muxbit <= TxD_dataReg[2];  // bit 2       
	4'd6 :  muxbit <= TxD_dataReg[3];  // bit 3       
	4'd7 :  muxbit <= TxD_dataReg[4];  // bit 4       
	4'd8 :  muxbit <= TxD_dataReg[5];  // bit 5       
	4'd9 :  muxbit <= TxD_dataReg[6];  // bit 6       
	4'd10:  muxbit <= TxD_dataReg[7];  // bit 7       
	4'd11:  muxbit <= 1'b1;            // stop1                
	default:muxbit <= 1'b1;                           
endcase	                                   	        

		
always @(posedge clk) 
begin
  	TxD <= muxbit;
end	
	
		
endmodule 			