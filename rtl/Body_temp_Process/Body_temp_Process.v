module Body_temp_Process(
					input [14:0]	body_temp_data_in,
					
					output [3:0]  	body_temp_int_one,
					output [3:0]  	body_temp_int_ten,
					output [3:0]  	body_temp_dec_one,
					output [3:0]  	body_temp_dec_ten,
					output [7:0]  	body_temp_int,
					output [7:0]	body_temp_dec

);


assign  	body_temp_int= 64*body_temp_data_in[14]+32*body_temp_data_in[13]+16*body_temp_data_in[12]
								+8*body_temp_data_in[11]+4*body_temp_data_in[10]+2*body_temp_data_in[9]+1*body_temp_data_in[8];

assign  	body_temp_dec= 50*body_temp_data_in[7]+25*body_temp_data_in[6]+12*body_temp_data_in[5]
								+6*body_temp_data_in[4]+3*body_temp_data_in[3]+2*body_temp_data_in[2]+1*body_temp_data_in[1];

wire [13:0] int_bin	;	
wire [13:0] dec_bin	;

assign int_bin={6'b0,body_temp_int};
assign dec_bin={6'b0,body_temp_dec};
						
bintobcd bintobcd_1(

	.bin(int_bin),  //20位二进制码
						
	.one(body_temp_int_one),  //个位
	.ten(body_temp_int_ten),  //十位
	.hun(),  //百位
	.tho() 

);

bintobcd bintobcd_2(
	.bin(dec_bin),  //20位二进制码
						
	.one(body_temp_dec_one),  //个位
	.ten(body_temp_dec_ten),  //十位
	.hun(),  //百位
	.tho()   //百位

);

endmodule		
