module Body_temp_Process(
					input				clk,
					input				rst_n,
					input [14:0]	body_temp_data_in,
					
					output [3:0]  	body_temp_int_one,
					output [3:0]  	body_temp_int_ten,
					output [3:0]  	body_temp_dec_one,
					output [3:0]  	body_temp_dec_ten

);

wire [7:0]  	body_temp_int;
wire [7:0]  	body_temp_dec;

assign  	body_temp_int= 64*body_temp_data_in[14]+32*body_temp_data_in[13]+16*body_temp_data_in[12]
								+8*body_temp_data_in[11]+4*body_temp_data_in[10]+2*body_temp_data_in[9]+1*body_temp_data_in[8];

								
bintobcd bintobcd_1(
	.clk(clk),
	.rst_n(rst_n),
	.bin(body_temp_int),  //20位二进制码
						
	.one(body_temp_int_one),  //个位
	.ten(body_temp_int_ten),  //十位
	.hun(),  //百位
	.tho(),  //千位
	.tth(),  //万位
	.trl()   //兆位

);

endmodule		
