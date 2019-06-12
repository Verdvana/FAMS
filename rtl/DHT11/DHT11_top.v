module   DHT11_top(                                                          
                    input clk,                                                                                      
                    inout data,
						  output TxD,
						  
						  
						  output [3:0] temperature_one,
						  output [3:0] temperature_ten,
						  output [3:0] humidity_one,   
						  output [3:0] humidity_ten  
					  
);                                                        
 
 
 
wire [7:0] temperature;	
wire [7:0] humidity;    
wire [7:0] TxD_data; 
DHT11_opera DHT11_opera_inst(                                                
                             .clk(clk),                                      
                             .sample_en(sample_en),                          
                             .data(data),                                    
                             .data_rdy(data_rdy),                            
                             .temperature(temperature),                      
                             .humidity(humidity)                             
                            );                                               
                                                                             
                                                                             
DHT11_cmd   DHT11_cmd_inst(                                                  
                           .clk(clk),                                        
                           .sample_en(sample_en),                            
                           .data_rdy(data_rdy),                              
                           .temperature(temperature),                        
                           .humidity(humidity),                               
						                                                                 
									.TxD_busy(TxD_busy),                              
									.Tx_start(Tx_start),                              
									.TxD_data(TxD_data)                                 
                          );                                                 
                                                                             
async_send  async_send_inst(                                                 
                            .clk(clk),                                       
																									 
									 .TxD_start(Tx_start),                            
									 .TxD_data(TxD_data),                             
                            .TxD(TxD),                                       
                            .TxD_busy(TxD_busy)                              
								   );
									

bintobcd bintobcd_3(

	.bin(temperature),  //20位二进制码
						
	.one(temperature_one),  //个位
	.ten(temperature_ten),  //十位
	.hun(),  //百位
	.tho() 

);

bintobcd bintobcd_4(

	.bin(humidity),  //20位二进制码
						
	.one(humidity_one),  //个位
	.ten(humidity_ten),  //十位
	.hun(),  //百位
	.tho() 

);
						 
						 
endmodule						 