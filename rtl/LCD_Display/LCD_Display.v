module LCD_Display(
    input   clk_vga,
    input   rst_n,

	 input	sys_rd1,
	 input	sys_rd2,
    input   lcd_request_theme,     
    input   lcd_request_veneno,    
	 input   lcd_request_body_temp,           
	 input   lcd_request_heart_rate,            
	 input   lcd_request_h2,                  
	 input   lcd_request_liquefied,	         
	 input   lcd_request_natural,             
	 input   lcd_request_harmful,               
	 input   lcd_request_oxy,	                
	 input   lcd_request_temp,	               
	 input   lcd_request_hum,	               
    
	 input   lcd_request_body_temp_dp,          
	 input   lcd_request_body_temp_unit,        
	 input   lcd_request_ppm,	                
	 input   lcd_request_rh,                    
	 input   lcd_request_temp_unit,	           
     
	 input   lcd_request_body_temp_int_ten,      
	 input   lcd_request_body_temp_int_one,      
	 input   lcd_request_body_temp_dec_ten,      
	 input   lcd_request_heart_rate_hun,         
	 input   lcd_request_heart_rate_ten,         
	 input   lcd_request_heart_rate_one,         
	 input   lcd_request_h2_ten,                 
	 input   lcd_request_h2_one,                 
	 input   lcd_request_liquefied_ten,          
	 input   lcd_request_liquefied_one,          
	 input   lcd_request_natural_ten,            
	 input   lcd_request_natural_one,            
	 input   lcd_request_harmful_ten,            
	 input   lcd_request_harmful_one,            
	 input   lcd_request_oxy_ten,                
	 input   lcd_request_oxy_one,                
	 input   lcd_request_temp_ten,              
	 input   lcd_request_temp_one,               
	 input   lcd_request_hum_ten,               
	 input   lcd_request_hum_one,   
	 

	 input     [10:0]   hcount_theme,			//x坐标
	 input     [10:0]   vcount_theme,			//y坐标
	 input     [10:0]   hcount_veneno,			//x坐标
	 input     [10:0]   vcount_veneno,			//y坐标
	 input     [10:0]   hcount_body_temp,			//x坐标
	 input     [10:0]   vcount_body_temp,			//y坐标
	 input     [10:0]   hcount_body_temp_int_ten,		
	 input     [10:0]   vcount_body_temp_int_ten,		
	 input     [10:0]   hcount_body_temp_int_one,		
	 input     [10:0]   vcount_body_temp_int_one,		
	 input     [10:0]   hcount_body_temp_dp,			//x
	 input     [10:0]   vcount_body_temp_dp,			//y
	 input     [10:0]   hcount_body_temp_dec_ten,		
	 input     [10:0]   vcount_body_temp_dec_ten,		
	 input     [10:0]   hcount_body_temp_unit,			
	 input     [10:0]   vcount_body_temp_unit,			
	 input     [10:0]   hcount_heart_rate,			//x
	 input     [10:0]   vcount_heart_rate,			//y
	 input     [10:0]   hcount_heart_rate_hun,			
	 input     [10:0]   vcount_heart_rate_hun,			
	 input     [10:0]   hcount_heart_rate_ten,			
	 input     [10:0]   vcount_heart_rate_ten,			
	 input     [10:0]   hcount_heart_rate_one,			
	 input     [10:0]   vcount_heart_rate_one,			
	 input     [10:0]   hcount_h2,			//x坐标
	 input     [10:0]   vcount_h2,			//y坐标
	 input     [10:0]   hcount_h2_ten,			//x坐标
	 input     [10:0]   vcount_h2_ten,			//y坐标	
	 input     [10:0]   hcount_h2_one,			//x坐标
	 input     [10:0]   vcount_h2_one,			//y坐标
	 input     [10:0]   hcount_liquefied,			//x坐标
	 input     [10:0]   vcount_liquefied,			//y坐标
	 input     [10:0]   hcount_liquefied_ten,			
	 input     [10:0]   vcount_liquefied_ten,			
	 input     [10:0]   hcount_liquefied_one,			
	 input     [10:0]   vcount_liquefied_one,			
	 input     [10:0]   hcount_natural,			//x坐标
	 input     [10:0]   vcount_natural,			//y坐标
	 input     [10:0]   hcount_harmful,			//x坐标
	 input     [10:0]   vcount_harmful,			//y坐标
	 input     [10:0]   hcount_oxy,			//x坐标
	 input     [10:0]   vcount_oxy,			//y坐标
	 input     [10:0]   hcount_temp,			//x坐标
	 input     [10:0]   vcount_temp,			//y坐标
	 input     [10:0]   hcount_hum,			//x坐标
	 input     [10:0]   vcount_hum,			//y坐标
	 input     [10:0]   hcount_natural_ten,			//x
	 input     [10:0]   vcount_natural_ten,			//y
	 input     [10:0]   hcount_natural_one,			//x
	 input     [10:0]   vcount_natural_one,			//y
	 input     [10:0]   hcount_harmful_ten,			//x
	 input     [10:0]   vcount_harmful_ten,			//y
	 input     [10:0]   hcount_harmful_one,			//x
	 input     [10:0]   vcount_harmful_one,			//y
	 input     [10:0]   hcount_oxy_ten,			//x坐标
	 input     [10:0]   vcount_oxy_ten,			//y坐标
	 input     [10:0]   hcount_oxy_one,			//x坐标
	 input     [10:0]   vcount_oxy_one,			//y坐标
	 input     [10:0]   hcount_temp_ten,			//x坐标
	 input     [10:0]   vcount_temp_ten,			//y坐标
	 input     [10:0]   hcount_temp_one,			//x坐标
	 input     [10:0]   vcount_temp_one,			//y坐标
	 input     [10:0]   hcount_hum_ten,			//x坐标
	 input     [10:0]   vcount_hum_ten,			//y坐标
	 input     [10:0]   hcount_hum_one,			//x坐标
	 input     [10:0]   vcount_hum_one,			//y坐标
	 input     [10:0]   hcount_ppm,			//x坐标
	 input     [10:0]   vcount_ppm,			//y坐标
	 input     [10:0]   hcount_rh,			//x坐标
	 input     [10:0]   vcount_rh,			//y坐标
	 input     [10:0]   hcount_temp_unit,			//x坐标
	 input     [10:0]   vcount_temp_unit,			//y坐标
		
				
	 input  	  [3:0] 	  body_temp_int_one,
    input     [3:0]    body_temp_int_ten,
	 input	  [3:0]    body_temp_dec_one,
	 input	  [3:0]    body_temp_dec_ten,
	 
	 input     [3:0]    heart_rate_hun,
	 input     [3:0]    heart_rate_ten,
	 input     [3:0]    heart_rate_one,
	         
	 input     [3:0]    h2_one,       
	 input     [3:0]    h2_ten ,      
	 input     [3:0]    liquefied_one,
	 input     [3:0]    liquefied_ten,
	 input     [3:0]    natural_one  ,
	 input     [3:0]    natural_ten , 
	 input     [3:0]    harmful_one  ,
	 input     [3:0]    harmful_ten  ,
	 input     [3:0]    oxy_one    ,   
	 input     [3:0]    oxy_ten   ,   
	 input     [3:0]    temp_one   ,   
	 input     [3:0]    temp_ten  ,     
	 input     [3:0]    hum_one   ,     
	 input     [3:0]    hum_ten   ,    
	
		input  [23:0]   lcd_data_in,
		input	 [23:0]	 gymcu_data,	
	 
	 
    
				
	output  reg [23:0] lcd_driver_data_in			
	         


);



reg [13:0] rdaddress_chinese;
wire data_chinese;
ROM_chinese  ROM_chinese_inst (
	.address ( rdaddress_chinese ),
	.clock ( clk_vga ),
	.q ( data_chinese )
	);
	
	


wire [13:0] rdaddress_theme;
//wire        data_theme;
assign rdaddress_theme = hcount_theme[10:0] + vcount_theme[10:0]*144;




	

wire [13:0] rdaddress_veneno;
//wire        data_veneno;
assign rdaddress_veneno = hcount_veneno[10:0] + vcount_veneno[10:0]*48 + 2304;



	

wire [13:0] rdaddress_body_temp;
//wire        data_body_temp;
assign rdaddress_body_temp = hcount_body_temp[10:0] + vcount_body_temp[10:0]*48 + 3072;

	

	
	

wire [13:0] rdaddress_heart_rate;
assign rdaddress_heart_rate = hcount_heart_rate[10:0] + vcount_heart_rate[10:0]*48 + 3840;

	

wire [13:0] rdaddress_h2;
assign rdaddress_h2 = hcount_h2[10:0] + vcount_h2[10:0]*48 + 4608;



wire [13:0] rdaddress_liquefied;
assign rdaddress_liquefied = hcount_liquefied[10:0] + vcount_liquefied[10:0]*64 + 5376;

	

wire [13:0] rdaddress_natural;
assign rdaddress_natural = hcount_natural[10:0] + vcount_natural[10:0]*64 + 6400;



wire [13:0] rdaddress_harmful;
assign rdaddress_harmful = hcount_harmful[10:0] + vcount_harmful[10:0]*80 + 7424;



wire [13:0] rdaddress_oxy;
assign rdaddress_oxy = hcount_oxy[10:0] + vcount_oxy[10:0]*48 + 8704;



wire [13:0] rdaddress_temp;
assign rdaddress_temp = hcount_temp[10:0] + vcount_temp[10:0]*48 + 9472;



wire [13:0] rdaddress_hum;
assign rdaddress_hum = hcount_hum[10:0] + vcount_hum[10:0]*48 + 10240;

	
always@(*)
begin
	case({lcd_request_theme,lcd_request_veneno,lcd_request_body_temp,lcd_request_heart_rate,lcd_request_h2,lcd_request_liquefied,lcd_request_natural,lcd_request_harmful,lcd_request_oxy,lcd_request_temp,lcd_request_hum})
		11'b10000000000: rdaddress_chinese = rdaddress_theme;
		11'b01000000000: rdaddress_chinese = rdaddress_veneno;
		11'b00100000000: rdaddress_chinese = rdaddress_body_temp;
		11'b00010000000: rdaddress_chinese = rdaddress_heart_rate;
      11'b00001000000: rdaddress_chinese = rdaddress_h2;
		11'b00000100000: rdaddress_chinese = rdaddress_liquefied;
		11'b00000010000: rdaddress_chinese = rdaddress_natural;
		11'b00000001000: rdaddress_chinese = rdaddress_harmful;
		11'b00000000100: rdaddress_chinese = rdaddress_oxy;
		11'b00000000010: rdaddress_chinese = rdaddress_temp;
		11'b00000000001: rdaddress_chinese = rdaddress_hum;
	endcase
end	
	
//-------------------------------------------------------------------------------------------------
	
	

wire [11:0] rdaddress_body_temp_dp;
wire        data_body_temp_dp;
assign rdaddress_body_temp_dp = hcount_body_temp_dp[10:0] + vcount_body_temp_dp[10:0]*8;
ROM_dp 	ROM_dp_inst (
	.address ( rdaddress_body_temp_dp ),
	.clock ( clk_vga ),
	.q ( data_body_temp_dp )
	);	

	

wire [11:0] rdaddress_body_temp_unit;
wire        data_body_temp_unit;
assign rdaddress_body_temp_unit = hcount_body_temp_unit[10:0] + vcount_body_temp_unit[10:0]*16;
ROM_temp_unit 	ROM_unit (
	.address ( rdaddress_body_temp_unit ),
	.clock ( clk_vga ),
	.q ( data_body_temp_unit )
	);	
	


wire [11:0] rdaddress_ppm;
wire        data_ppm;
assign rdaddress_ppm = hcount_ppm[10:0] + vcount_ppm[10:0]*24;
ROM_ppm 	ROM_ppm_inst (
	.address ( rdaddress_ppm ),
	.clock ( clk_vga ),
	.q ( data_ppm )
	);	
	
	

wire [11:0] rdaddress_rh;
wire        data_rh;
assign rdaddress_rh = hcount_rh[10:0] + vcount_rh[10:0]*16;
ROM_rh 	ROM_rh_inst (
	.address ( rdaddress_rh ),
	.clock ( clk_vga ),
	.q ( data_rh )
	);
	


wire [11:0] rdaddress_temp_unit;
wire        data_temp_unit;
assign rdaddress_temp_unit = hcount_temp_unit[10:0] + vcount_temp_unit[10:0]*16;
ROM_temp_unit 	ROM_temp_unit (
	.address ( rdaddress_temp_unit ),
	.clock ( clk_vga ),
	.q ( data_temp_unit )
	);	

//-----------------------------------------------------------------------------------------------


wire [11:0] rdaddress_body_temp_int_ten;
reg        data_body_temp_int_ten;
assign rdaddress_body_temp_int_ten = hcount_body_temp_int_ten[10:0] + vcount_body_temp_int_ten[10:0]*8;



wire [11:0] rdaddress_body_temp_int_one;
reg        data_body_temp_int_one;
assign rdaddress_body_temp_int_one = hcount_body_temp_int_one[10:0] + vcount_body_temp_int_one[10:0]*8;



wire [11:0] rdaddress_body_temp_dec_ten;
reg        data_body_temp_dec_ten;
assign rdaddress_body_temp_dec_ten = hcount_body_temp_dec_ten[10:0] + vcount_body_temp_dec_ten[10:0]*8;



wire [11:0] rdaddress_heart_rate_hun;
reg        data_heart_rate_hun;
assign rdaddress_heart_rate_hun = hcount_heart_rate_hun[10:0] + vcount_heart_rate_hun[10:0]*8;



wire [11:0] rdaddress_heart_rate_ten;
reg        data_heart_rate_ten;
assign rdaddress_heart_rate_ten = hcount_heart_rate_ten[10:0] + vcount_heart_rate_ten[10:0]*8;



wire [11:0] rdaddress_heart_rate_one;
reg        data_heart_rate_one;
assign rdaddress_heart_rate_one = hcount_heart_rate_one[10:0] + vcount_heart_rate_one[10:0]*8;



wire [11:0] rdaddress_h2_ten;
reg        data_h2_ten;
assign rdaddress_h2_ten = hcount_h2_ten[10:0] + vcount_h2_ten[10:0]*8;



wire [11:0] rdaddress_h2_one;
reg        data_h2_one;
assign rdaddress_h2_one = hcount_h2_one[10:0] + vcount_h2_one[10:0]*8;



wire [11:0] rdaddress_liquefied_ten;
reg        data_liquefied_ten;
assign rdaddress_liquefied_ten = hcount_liquefied_ten[10:0] + vcount_liquefied_ten[10:0]*8;



wire [11:0] rdaddress_liquefied_one;
reg        data_liquefied_one;
assign rdaddress_liquefied_one = hcount_liquefied_one[10:0] + vcount_liquefied_one[10:0]*8;



wire [11:0] rdaddress_natural_ten;
reg        data_natural_ten;
assign rdaddress_natural_ten = hcount_natural_ten[10:0] + vcount_natural_ten[10:0]*8;


wire [11:0] rdaddress_natural_one;
reg        data_natural_one;
assign rdaddress_natural_one = hcount_natural_one[10:0] + vcount_natural_one[10:0]*8;



wire [11:0] rdaddress_harmful_ten;
reg        data_harmful_ten;
assign rdaddress_harmful_ten = hcount_harmful_ten[10:0] + vcount_harmful_ten[10:0]*8;



wire [11:0] rdaddress_harmful_one;
reg        data_harmful_one;
assign rdaddress_harmful_one = hcount_harmful_one[10:0] + vcount_harmful_one[10:0]*8;



wire [11:0] rdaddress_oxy_ten;
reg        data_oxy_ten;
assign rdaddress_oxy_ten = hcount_oxy_ten[10:0] + vcount_oxy_ten[10:0]*8;



wire [11:0] rdaddress_oxy_one;
reg        data_oxy_one;
assign rdaddress_oxy_one = hcount_oxy_one[10:0] + vcount_oxy_one[10:0]*8;



wire [11:0] rdaddress_temp_ten;
reg        data_temp_ten;
assign rdaddress_temp_ten = hcount_temp_ten[10:0] + vcount_temp_ten[10:0]*8;



wire [11:0] rdaddress_temp_one;
reg        data_temp_one;
assign rdaddress_temp_one = hcount_temp_one[10:0] + vcount_temp_one[10:0]*8;



wire [11:0] rdaddress_hum_ten;
reg        data_hum_ten;
assign rdaddress_hum_ten = hcount_hum_ten[10:0] + vcount_hum_ten[10:0]*8;



wire [11:0] rdaddress_hum_one;
reg        data_hum_one;
assign rdaddress_hum_one = hcount_hum_one[10:0] + vcount_hum_one[10:0]*8;


always@(*)
begin
	case(body_temp_int_ten)
		4'd0: data_body_temp_int_ten =  data_0_body_temp_int_ten;
		4'd1: data_body_temp_int_ten =  data_1_body_temp_int_ten;
		4'd2: data_body_temp_int_ten =  data_2_body_temp_int_ten;
		4'd3: data_body_temp_int_ten =  data_3_body_temp_int_ten;
		4'd4: data_body_temp_int_ten =  data_4_body_temp_int_ten;
		4'd5: data_body_temp_int_ten =  data_5_body_temp_int_ten;
		4'd6: data_body_temp_int_ten =  data_6_body_temp_int_ten;
		4'd7: data_body_temp_int_ten =  data_7_body_temp_int_ten;
		4'd8: data_body_temp_int_ten =  data_8_body_temp_int_ten;
		4'd9: data_body_temp_int_ten =  data_9_body_temp_int_ten;	
	endcase
	
		case(body_temp_int_one)
		4'd0: data_body_temp_int_one =  data_0_body_temp_int_one;
		4'd1: data_body_temp_int_one =  data_1_body_temp_int_one;
		4'd2: data_body_temp_int_one =  data_2_body_temp_int_one;
		4'd3: data_body_temp_int_one =  data_3_body_temp_int_one;
		4'd4: data_body_temp_int_one =  data_4_body_temp_int_one;
		4'd5: data_body_temp_int_one =  data_5_body_temp_int_one;
		4'd6: data_body_temp_int_one =  data_6_body_temp_int_one;
		4'd7: data_body_temp_int_one =  data_7_body_temp_int_one;
		4'd8: data_body_temp_int_one =  data_8_body_temp_int_one;
		4'd9: data_body_temp_int_one =  data_9_body_temp_int_one;
	endcase

	case(body_temp_dec_ten)
		4'd0: data_body_temp_dec_ten =  data_0_body_temp_dec_ten;
		4'd1: data_body_temp_dec_ten =  data_1_body_temp_dec_ten;
		4'd2: data_body_temp_dec_ten =  data_2_body_temp_dec_ten;
		4'd3: data_body_temp_dec_ten =  data_3_body_temp_dec_ten;
		4'd4: data_body_temp_dec_ten =  data_4_body_temp_dec_ten;
		4'd5: data_body_temp_dec_ten =  data_5_body_temp_dec_ten;
		4'd6: data_body_temp_dec_ten =  data_6_body_temp_dec_ten;
		4'd7: data_body_temp_dec_ten =  data_7_body_temp_dec_ten;
		4'd8: data_body_temp_dec_ten =  data_8_body_temp_dec_ten;
		4'd9: data_body_temp_dec_ten =  data_9_body_temp_dec_ten;
	endcase

	case(heart_rate_hun)
		4'd0: data_heart_rate_hun =  data_0_heart_rate_hun;
		4'd1: data_heart_rate_hun =  data_1_heart_rate_hun;
		4'd2: data_heart_rate_hun =  data_2_heart_rate_hun;
		4'd3: data_heart_rate_hun =  data_3_heart_rate_hun;
		4'd4: data_heart_rate_hun =  data_4_heart_rate_hun;
		4'd5: data_heart_rate_hun =  data_5_heart_rate_hun;
		4'd6: data_heart_rate_hun =  data_6_heart_rate_hun;
		4'd7: data_heart_rate_hun =  data_7_heart_rate_hun;
		4'd8: data_heart_rate_hun =  data_8_heart_rate_hun;
		4'd9: data_heart_rate_hun =  data_9_heart_rate_hun;
	endcase

	case(heart_rate_ten)
		4'd0: data_heart_rate_ten =  data_0_heart_rate_ten;
		4'd1: data_heart_rate_ten =  data_1_heart_rate_ten;
		4'd2: data_heart_rate_ten =  data_2_heart_rate_ten;
		4'd3: data_heart_rate_ten =  data_3_heart_rate_ten;
		4'd4: data_heart_rate_ten =  data_4_heart_rate_ten;
		4'd5: data_heart_rate_ten =  data_5_heart_rate_ten;
		4'd6: data_heart_rate_ten =  data_6_heart_rate_ten;
		4'd7: data_heart_rate_ten =  data_7_heart_rate_ten;
		4'd8: data_heart_rate_ten =  data_8_heart_rate_ten;
		4'd9: data_heart_rate_ten =  data_9_heart_rate_ten;
	endcase

	case(heart_rate_one)
		4'd0: data_heart_rate_one =  data_0_heart_rate_one;
		4'd1: data_heart_rate_one =  data_1_heart_rate_one;
		4'd2: data_heart_rate_one =  data_2_heart_rate_one;
		4'd3: data_heart_rate_one =  data_3_heart_rate_one;
		4'd4: data_heart_rate_one =  data_4_heart_rate_one;
		4'd5: data_heart_rate_one =  data_5_heart_rate_one;
		4'd6: data_heart_rate_one =  data_6_heart_rate_one;
		4'd7: data_heart_rate_one =  data_7_heart_rate_one;
		4'd8: data_heart_rate_one =  data_8_heart_rate_one;
		4'd9: data_heart_rate_one =  data_9_heart_rate_one;
	endcase
	
	case(h2_ten)
		4'd0: data_h2_ten =  data_0_h2_ten;
		4'd1: data_h2_ten =  data_1_h2_ten;
		4'd2: data_h2_ten =  data_2_h2_ten;
		4'd3: data_h2_ten =  data_3_h2_ten;
		4'd4: data_h2_ten =  data_4_h2_ten;
		4'd5: data_h2_ten =  data_5_h2_ten;
		4'd6: data_h2_ten =  data_6_h2_ten;
		4'd7: data_h2_ten =  data_7_h2_ten;
		4'd8: data_h2_ten =  data_8_h2_ten;
		4'd9: data_h2_ten =  data_9_h2_ten;
	endcase
	
	case(h2_one)
		4'd0: data_h2_one =  data_0_h2_one;
		4'd1: data_h2_one =  data_1_h2_one;
		4'd2: data_h2_one =  data_2_h2_one;
		4'd3: data_h2_one =  data_3_h2_one;
		4'd4: data_h2_one =  data_4_h2_one;
		4'd5: data_h2_one =  data_5_h2_one;
		4'd6: data_h2_one =  data_6_h2_one;
		4'd7: data_h2_one =  data_7_h2_one;
		4'd8: data_h2_one =  data_8_h2_one;
		4'd9: data_h2_one =  data_9_h2_one;
	endcase
	
	case(liquefied_ten)
		4'd0: data_liquefied_ten =  data_0_liquefied_ten;
		4'd1: data_liquefied_ten =  data_1_liquefied_ten;
		4'd2: data_liquefied_ten =  data_2_liquefied_ten;
		4'd3: data_liquefied_ten =  data_3_liquefied_ten;
		4'd4: data_liquefied_ten =  data_4_liquefied_ten;
		4'd5: data_liquefied_ten =  data_5_liquefied_ten;
		4'd6: data_liquefied_ten =  data_6_liquefied_ten;
		4'd7: data_liquefied_ten =  data_7_liquefied_ten;
		4'd8: data_liquefied_ten =  data_8_liquefied_ten;
		4'd9: data_liquefied_ten =  data_9_liquefied_ten;
	endcase
	
	case(liquefied_one)
		4'd0: data_liquefied_one =  data_0_liquefied_one;
		4'd1: data_liquefied_one =  data_1_liquefied_one;
		4'd2: data_liquefied_one =  data_2_liquefied_one;
		4'd3: data_liquefied_one =  data_3_liquefied_one;
		4'd4: data_liquefied_one =  data_4_liquefied_one;
		4'd5: data_liquefied_one =  data_5_liquefied_one;
		4'd6: data_liquefied_one =  data_6_liquefied_one;
		4'd7: data_liquefied_one =  data_7_liquefied_one;
		4'd8: data_liquefied_one =  data_8_liquefied_one;
		4'd9: data_liquefied_one =  data_9_liquefied_one;
	endcase
	
	case(natural_ten)
		4'd0: data_natural_ten =  data_0_natural_ten;
		4'd1: data_natural_ten =  data_1_natural_ten;
		4'd2: data_natural_ten =  data_2_natural_ten;
		4'd3: data_natural_ten =  data_3_natural_ten;
		4'd4: data_natural_ten =  data_4_natural_ten;
		4'd5: data_natural_ten =  data_5_natural_ten;
		4'd6: data_natural_ten =  data_6_natural_ten;
		4'd7: data_natural_ten =  data_7_natural_ten;
		4'd8: data_natural_ten =  data_8_natural_ten;
		4'd9: data_natural_ten =  data_9_natural_ten;
	endcase
	
	case(natural_one)
		4'd0: data_natural_one =  data_0_natural_one;
		4'd1: data_natural_one =  data_1_natural_one;
		4'd2: data_natural_one =  data_2_natural_one;
		4'd3: data_natural_one =  data_3_natural_one;
		4'd4: data_natural_one =  data_4_natural_one;
		4'd5: data_natural_one =  data_5_natural_one;
		4'd6: data_natural_one =  data_6_natural_one;
		4'd7: data_natural_one =  data_7_natural_one;
		4'd8: data_natural_one =  data_8_natural_one;
		4'd9: data_natural_one =  data_9_natural_one;
	endcase
	case(harmful_ten)
		4'd0: data_harmful_ten =  data_0_harmful_ten;
		4'd1: data_harmful_ten =  data_1_harmful_ten;
		4'd2: data_harmful_ten =  data_2_harmful_ten;
		4'd3: data_harmful_ten =  data_3_harmful_ten;
		4'd4: data_harmful_ten =  data_4_harmful_ten;
		4'd5: data_harmful_ten =  data_5_harmful_ten;
		4'd6: data_harmful_ten =  data_6_harmful_ten;
		4'd7: data_harmful_ten =  data_7_harmful_ten;
		4'd8: data_harmful_ten =  data_8_harmful_ten;
		4'd9: data_harmful_ten =  data_9_harmful_ten;
	endcase
	
	case(harmful_one)
		4'd0: data_harmful_one =  data_0_harmful_one;
		4'd1: data_harmful_one =  data_1_harmful_one;
		4'd2: data_harmful_one =  data_2_harmful_one;
		4'd3: data_harmful_one =  data_3_harmful_one;
		4'd4: data_harmful_one =  data_4_harmful_one;
		4'd5: data_harmful_one =  data_5_harmful_one;
		4'd6: data_harmful_one =  data_6_harmful_one;
		4'd7: data_harmful_one =  data_7_harmful_one;
		4'd8: data_harmful_one =  data_8_harmful_one;
		4'd9: data_harmful_one =  data_9_harmful_one;
	endcase
	case(oxy_ten)
		4'd0: data_oxy_ten =  data_0_oxy_ten;
		4'd1: data_oxy_ten =  data_1_oxy_ten;
		4'd2: data_oxy_ten =  data_2_oxy_ten;
		4'd3: data_oxy_ten =  data_3_oxy_ten;
		4'd4: data_oxy_ten =  data_4_oxy_ten;
		4'd5: data_oxy_ten =  data_5_oxy_ten;
		4'd6: data_oxy_ten =  data_6_oxy_ten;
		4'd7: data_oxy_ten =  data_7_oxy_ten;
		4'd8: data_oxy_ten =  data_8_oxy_ten;
		4'd9: data_oxy_ten =  data_9_oxy_ten;
	endcase
	
	case(oxy_one)
		4'd0: data_oxy_one =  data_0_oxy_one;
		4'd1: data_oxy_one =  data_1_oxy_one;
		4'd2: data_oxy_one =  data_2_oxy_one;
		4'd3: data_oxy_one =  data_3_oxy_one;
		4'd4: data_oxy_one =  data_4_oxy_one;
		4'd5: data_oxy_one =  data_5_oxy_one;
		4'd6: data_oxy_one =  data_6_oxy_one;
		4'd7: data_oxy_one =  data_7_oxy_one;
		4'd8: data_oxy_one =  data_8_oxy_one;
		4'd9: data_oxy_one =  data_9_oxy_one;
	endcase
	case(temp_ten)
		4'd0: data_temp_ten =  data_0_temp_ten;
		4'd1: data_temp_ten =  data_1_temp_ten;
		4'd2: data_temp_ten =  data_2_temp_ten;
		4'd3: data_temp_ten =  data_3_temp_ten;
		4'd4: data_temp_ten =  data_4_temp_ten;
		4'd5: data_temp_ten =  data_5_temp_ten;
		4'd6: data_temp_ten =  data_6_temp_ten;
		4'd7: data_temp_ten =  data_7_temp_ten;
		4'd8: data_temp_ten =  data_8_temp_ten;
		4'd9: data_temp_ten =  data_9_temp_ten;
	endcase
	
	case(temp_one)
		4'd0: data_temp_one =  data_0_temp_one;
		4'd1: data_temp_one =  data_1_temp_one;
		4'd2: data_temp_one =  data_2_temp_one;
		4'd3: data_temp_one =  data_3_temp_one;
		4'd4: data_temp_one =  data_4_temp_one;
		4'd5: data_temp_one =  data_5_temp_one;
		4'd6: data_temp_one =  data_6_temp_one;
		4'd7: data_temp_one =  data_7_temp_one;
		4'd8: data_temp_one =  data_8_temp_one;
		4'd9: data_temp_one =  data_9_temp_one;
	endcase
	case(hum_ten)
		4'd0: data_hum_ten =  data_0_hum_ten;
		4'd1: data_hum_ten =  data_1_hum_ten;
		4'd2: data_hum_ten =  data_2_hum_ten;
		4'd3: data_hum_ten =  data_3_hum_ten;
		4'd4: data_hum_ten =  data_4_hum_ten;
		4'd5: data_hum_ten =  data_5_hum_ten;
		4'd6: data_hum_ten =  data_6_hum_ten;
		4'd7: data_hum_ten =  data_7_hum_ten;
		4'd8: data_hum_ten =  data_8_hum_ten;
		4'd9: data_hum_ten =  data_9_hum_ten;
	endcase
	
	case(hum_one)
		4'd0: data_hum_one =  data_0_hum_one;
		4'd1: data_hum_one =  data_1_hum_one;
		4'd2: data_hum_one =  data_2_hum_one;
		4'd3: data_hum_one =  data_3_hum_one;
		4'd4: data_hum_one =  data_4_hum_one;
		4'd5: data_hum_one =  data_5_hum_one;
		4'd6: data_hum_one =  data_6_hum_one;
		4'd7: data_hum_one =  data_7_hum_one;
		4'd8: data_hum_one =  data_8_hum_one;
		4'd9: data_hum_one =  data_9_hum_one;
	endcase

end


always@(*)
begin
	case({sys_rd1,sys_rd2,lcd_request_theme,lcd_request_veneno,lcd_request_body_temp,lcd_request_body_temp_int_ten,lcd_request_body_temp_int_one,lcd_request_body_temp_dp,lcd_request_body_temp_dec_ten,lcd_request_body_temp_unit,lcd_request_heart_rate,lcd_request_heart_rate_hun,lcd_request_heart_rate_ten,lcd_request_heart_rate_one,lcd_request_h2,lcd_request_h2_ten,lcd_request_h2_one,lcd_request_liquefied,lcd_request_liquefied_ten,lcd_request_liquefied_one,lcd_request_natural,lcd_request_harmful,lcd_request_oxy,lcd_request_temp,lcd_request_hum,lcd_request_natural_ten,lcd_request_natural_one,lcd_request_harmful_ten,lcd_request_harmful_one,lcd_request_oxy_ten,lcd_request_oxy_one,lcd_request_temp_ten,lcd_request_temp_one,lcd_request_hum_ten,lcd_request_hum_one,lcd_request_ppm,lcd_request_rh,lcd_request_temp_unit})
		38'b00000000000000000000000000000000000000:lcd_driver_data_in = 24'b0;
		38'b10000000000000000000000000000000000000:lcd_driver_data_in = lcd_data_in;
		38'b01000000000000000000000000000000000000:lcd_driver_data_in = gymcu_data;
		38'b00100000000000000000000000000000000000:lcd_driver_data_in = {8'b0,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00010000000000000000000000000000000000:lcd_driver_data_in = {8'b0,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00001000000000000000000000000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000100000000000000000000000000000000:lcd_driver_data_in = {data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten,data_body_temp_int_ten};
		38'b00000010000000000000000000000000000000:lcd_driver_data_in = {data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one,data_body_temp_int_one};
		38'b00000001000000000000000000000000000000:lcd_driver_data_in = {data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp,data_body_temp_dp};
		38'b00000000100000000000000000000000000000:lcd_driver_data_in = {data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten,data_body_temp_dec_ten};
		38'b00000000010000000000000000000000000000:lcd_driver_data_in = {data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit,data_body_temp_unit};
		38'b00000000001000000000000000000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000100000000000000000000000000:lcd_driver_data_in = {data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun,data_heart_rate_hun};
		38'b00000000000010000000000000000000000000:lcd_driver_data_in = {data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten,data_heart_rate_ten};
		38'b00000000000001000000000000000000000000:lcd_driver_data_in = {data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one,data_heart_rate_one};
		38'b00000000000000100000000000000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000000010000000000000000000000:lcd_driver_data_in = {data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten,data_h2_ten};
		38'b00000000000000001000000000000000000000:lcd_driver_data_in = {data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one,data_h2_one};
		38'b00000000000000000100000000000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000000000010000000000000000000:lcd_driver_data_in = {data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten,data_liquefied_ten};
		38'b00000000000000000001000000000000000000:lcd_driver_data_in = {data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one,data_liquefied_one};
		38'b00000000000000000000100000000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000000000000010000000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000000000000001000000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000000000000000100000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000000000000000010000000000000:lcd_driver_data_in = {data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,data_chinese,8'b0};
		38'b00000000000000000000000001000000000000:lcd_driver_data_in = {data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten,data_natural_ten};
		38'b00000000000000000000000000100000000000:lcd_driver_data_in = {data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one,data_natural_one};
		38'b00000000000000000000000000010000000000:lcd_driver_data_in = {data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten,data_harmful_ten};
		38'b00000000000000000000000000001000000000:lcd_driver_data_in = {data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one,data_harmful_one};
		38'b00000000000000000000000000000100000000:lcd_driver_data_in = {data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten,data_oxy_ten};
		38'b00000000000000000000000000000010000000:lcd_driver_data_in = {data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one,data_oxy_one};
		38'b00000000000000000000000000000001000000:lcd_driver_data_in = {data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten,data_temp_ten};
		38'b00000000000000000000000000000000100000:lcd_driver_data_in = {data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one,data_temp_one};
		38'b00000000000000000000000000000000010000:lcd_driver_data_in = {data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten,data_hum_ten};
		38'b00000000000000000000000000000000001000:lcd_driver_data_in = {data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one,data_hum_one};
		38'b00000000000000000000000000000000000100:lcd_driver_data_in = {data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm,data_ppm};
		38'b00000000000000000000000000000000000010:lcd_driver_data_in = {data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh,data_rh};
		38'b00000000000000000000000000000000000001:lcd_driver_data_in = {data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit,data_temp_unit};
		
		default:lcd_driver_data_in = 24'b0;
		
	endcase
end


	wire     		 	 data_0_body_temp_int_ten;
	wire     		 	 data_1_body_temp_int_ten;
	wire     		 	 data_2_body_temp_int_ten;
	wire     		 	 data_3_body_temp_int_ten;
	wire     		 	 data_4_body_temp_int_ten;
	wire     		 	 data_5_body_temp_int_ten;
	wire     		 	 data_6_body_temp_int_ten;
	wire     		 	 data_7_body_temp_int_ten;
	wire     		 	 data_8_body_temp_int_ten;
	wire     		 	 data_9_body_temp_int_ten; 	
ROM_0  ROM_0_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_0_body_temp_int_ten )
);

ROM_1  ROM_1_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_1_body_temp_int_ten )
);

ROM_2  ROM_2_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_2_body_temp_int_ten )
);

ROM_3  ROM_3_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_3_body_temp_int_ten )
);

ROM_4  ROM_4_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_4_body_temp_int_ten )
);

ROM_5  ROM_5_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_5_body_temp_int_ten )
);

ROM_6  ROM_6_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_6_body_temp_int_ten )
);

ROM_7  ROM_7_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_7_body_temp_int_ten )
);

ROM_8  ROM_8_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_8_body_temp_int_ten )
);

ROM_9  ROM_9_body_temp_int_ten (
.address ( rdaddress_body_temp_int_ten ),
.clock ( clk_vga ),
.q ( data_9_body_temp_int_ten )
);


	wire     		 	 data_0_body_temp_int_one;
	wire     		 	 data_1_body_temp_int_one;
	wire     		 	 data_2_body_temp_int_one;
	wire     		 	 data_3_body_temp_int_one;
	wire     		 	 data_4_body_temp_int_one;
	wire     		 	 data_5_body_temp_int_one;
	wire     		 	 data_6_body_temp_int_one;
	wire     		 	 data_7_body_temp_int_one;
	wire     		 	 data_8_body_temp_int_one;
	wire     		 	 data_9_body_temp_int_one; 	
ROM_0  ROM_0_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_0_body_temp_int_one )
);

ROM_1  ROM_1_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_1_body_temp_int_one )
);

ROM_2  ROM_2_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_2_body_temp_int_one )
);

ROM_3  ROM_3_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_3_body_temp_int_one )
);

ROM_4  ROM_4_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_4_body_temp_int_one )
);

ROM_5  ROM_5_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_5_body_temp_int_one )
);

ROM_6  ROM_6_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_6_body_temp_int_one )
);

ROM_7  ROM_7_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_7_body_temp_int_one )
);

ROM_8  ROM_8_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_8_body_temp_int_one )
);

ROM_9  ROM_9_body_temp_int_one (
.address ( rdaddress_body_temp_int_one ),
.clock ( clk_vga ),
.q ( data_9_body_temp_int_one )
);

	wire     		 	 data_0_body_temp_dec_ten;
	wire     		 	 data_1_body_temp_dec_ten;
	wire     		 	 data_2_body_temp_dec_ten;
	wire     		 	 data_3_body_temp_dec_ten;
	wire     		 	 data_4_body_temp_dec_ten;
	wire     		 	 data_5_body_temp_dec_ten;
	wire     		 	 data_6_body_temp_dec_ten;
	wire     		 	 data_7_body_temp_dec_ten;
	wire     		 	 data_8_body_temp_dec_ten;
	wire     		 	 data_9_body_temp_dec_ten; 	
ROM_0  ROM_0_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_0_body_temp_dec_ten )
);

ROM_1  ROM_1_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_1_body_temp_dec_ten )
);

ROM_2  ROM_2_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_2_body_temp_dec_ten )
);

ROM_3  ROM_3_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_3_body_temp_dec_ten )
);

ROM_4  ROM_4_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_4_body_temp_dec_ten )
);

ROM_5  ROM_5_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_5_body_temp_dec_ten )
);

ROM_6  ROM_6_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_6_body_temp_dec_ten )
);

ROM_7  ROM_7_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_7_body_temp_dec_ten )
);

ROM_8  ROM_8_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_8_body_temp_dec_ten )
);

ROM_9  ROM_9_body_temp_dec_ten (
.address ( rdaddress_body_temp_dec_ten ),
.clock ( clk_vga ),
.q ( data_9_body_temp_dec_ten )
);

	wire     		 	 data_0_heart_rate_hun;
	wire     		 	 data_1_heart_rate_hun;
	wire     		 	 data_2_heart_rate_hun;
	wire     		 	 data_3_heart_rate_hun;
	wire     		 	 data_4_heart_rate_hun;
	wire     		 	 data_5_heart_rate_hun;
	wire     		 	 data_6_heart_rate_hun;
	wire     		 	 data_7_heart_rate_hun;
	wire     		 	 data_8_heart_rate_hun;
	wire     		 	 data_9_heart_rate_hun; 	
ROM_0  ROM_0_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_0_heart_rate_hun )
);

ROM_1  ROM_1_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_1_heart_rate_hun )
);

ROM_2  ROM_2_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_2_heart_rate_hun )
);

ROM_3  ROM_3_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_3_heart_rate_hun )
);

ROM_4  ROM_4_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_4_heart_rate_hun )
);

ROM_5  ROM_5_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_5_heart_rate_hun )
);

ROM_6  ROM_6_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_6_heart_rate_hun )
);

ROM_7  ROM_7_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_7_heart_rate_hun )
);

ROM_8  ROM_8_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_8_heart_rate_hun )
);

ROM_9  ROM_9_heart_rate_hun (
.address ( rdaddress_heart_rate_hun ),
.clock ( clk_vga ),
.q ( data_9_heart_rate_hun )
);

	wire     		 	 data_0_heart_rate_ten;
	wire     		 	 data_1_heart_rate_ten;
	wire     		 	 data_2_heart_rate_ten;
	wire     		 	 data_3_heart_rate_ten;
	wire     		 	 data_4_heart_rate_ten;
	wire     		 	 data_5_heart_rate_ten;
	wire     		 	 data_6_heart_rate_ten;
	wire     		 	 data_7_heart_rate_ten;
	wire     		 	 data_8_heart_rate_ten;
	wire     		 	 data_9_heart_rate_ten; 	
ROM_0  ROM_0_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_0_heart_rate_ten )
);

ROM_1  ROM_1_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_1_heart_rate_ten )
);

ROM_2  ROM_2_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_2_heart_rate_ten )
);

ROM_3  ROM_3_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_3_heart_rate_ten )
);

ROM_4  ROM_4_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_4_heart_rate_ten )
);

ROM_5  ROM_5_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_5_heart_rate_ten )
);

ROM_6  ROM_6_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_6_heart_rate_ten )
);

ROM_7  ROM_7_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_7_heart_rate_ten )
);

ROM_8  ROM_8_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_8_heart_rate_ten )
);

ROM_9  ROM_9_heart_rate_ten (
.address ( rdaddress_heart_rate_ten ),
.clock ( clk_vga ),
.q ( data_9_heart_rate_ten )
);


	wire     		 	 data_0_heart_rate_one;
	wire     		 	 data_1_heart_rate_one;
	wire     		 	 data_2_heart_rate_one;
	wire     		 	 data_3_heart_rate_one;
	wire     		 	 data_4_heart_rate_one;
	wire     		 	 data_5_heart_rate_one;
	wire     		 	 data_6_heart_rate_one;
	wire     		 	 data_7_heart_rate_one;
	wire     		 	 data_8_heart_rate_one;
	wire     		 	 data_9_heart_rate_one; 	
ROM_0  ROM_0_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_0_heart_rate_one )
);

ROM_1  ROM_1_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_1_heart_rate_one )
);

ROM_2  ROM_2_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_2_heart_rate_one )
);

ROM_3  ROM_3_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_3_heart_rate_one )
);

ROM_4  ROM_4_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_4_heart_rate_one )
);

ROM_5  ROM_5_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_5_heart_rate_one )
);

ROM_6  ROM_6_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_6_heart_rate_one )
);

ROM_7  ROM_7_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_7_heart_rate_one )
);

ROM_8  ROM_8_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_8_heart_rate_one )
);

ROM_9  ROM_9_heart_rate_one (
.address ( rdaddress_heart_rate_one ),
.clock ( clk_vga ),
.q ( data_9_heart_rate_one )
);

	wire     		 	 data_0_h2_ten;
	wire     		 	 data_1_h2_ten;
	wire     		 	 data_2_h2_ten;
	wire     		 	 data_3_h2_ten;
	wire     		 	 data_4_h2_ten;
	wire     		 	 data_5_h2_ten;
	wire     		 	 data_6_h2_ten;
	wire     		 	 data_7_h2_ten;
	wire     		 	 data_8_h2_ten;
	wire     		 	 data_9_h2_ten; 	
ROM_0  ROM_0_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_0_h2_ten )
);

ROM_1  ROM_1_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_1_h2_ten )
);

ROM_2  ROM_2_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_2_h2_ten )
);

ROM_3  ROM_3_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_3_h2_ten )
);

ROM_4  ROM_4_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_4_h2_ten )
);

ROM_5  ROM_5_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_5_h2_ten )
);

ROM_6  ROM_6_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_6_h2_ten )
);

ROM_7  ROM_7_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_7_h2_ten )
);

ROM_8  ROM_8_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_8_h2_ten )
);

ROM_9  ROM_9_h2_ten (
.address ( rdaddress_h2_ten ),
.clock ( clk_vga ),
.q ( data_9_h2_ten )
);

	wire     		 	 data_0_h2_one;
	wire     		 	 data_1_h2_one;
	wire     		 	 data_2_h2_one;
	wire     		 	 data_3_h2_one;
	wire     		 	 data_4_h2_one;
	wire     		 	 data_5_h2_one;
	wire     		 	 data_6_h2_one;
	wire     		 	 data_7_h2_one;
	wire     		 	 data_8_h2_one;
	wire     		 	 data_9_h2_one; 	
ROM_0  ROM_0_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_0_h2_one )
);

ROM_1  ROM_1_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_1_h2_one )
);

ROM_2  ROM_2_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_2_h2_one )
);

ROM_3  ROM_3_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_3_h2_one )
);

ROM_4  ROM_4_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_4_h2_one )
);

ROM_5  ROM_5_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_5_h2_one )
);

ROM_6  ROM_6_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_6_h2_one )
);

ROM_7  ROM_7_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_7_h2_one )
);

ROM_8  ROM_8_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_8_h2_one )
);

ROM_9  ROM_9_h2_one (
.address ( rdaddress_h2_one ),
.clock ( clk_vga ),
.q ( data_9_h2_one )
);

	wire     		 	 data_0_liquefied_ten;
	wire     		 	 data_1_liquefied_ten;
	wire     		 	 data_2_liquefied_ten;
	wire     		 	 data_3_liquefied_ten;
	wire     		 	 data_4_liquefied_ten;
	wire     		 	 data_5_liquefied_ten;
	wire     		 	 data_6_liquefied_ten;
	wire     		 	 data_7_liquefied_ten;
	wire     		 	 data_8_liquefied_ten;
	wire     		 	 data_9_liquefied_ten; 	
ROM_0  ROM_0_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_0_liquefied_ten )
);

ROM_1  ROM_1_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_1_liquefied_ten )
);

ROM_2  ROM_2_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_2_liquefied_ten )
);

ROM_3  ROM_3_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_3_liquefied_ten )
);

ROM_4  ROM_4_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_4_liquefied_ten )
);

ROM_5  ROM_5_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_5_liquefied_ten )
);

ROM_6  ROM_6_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_6_liquefied_ten )
);

ROM_7  ROM_7_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_7_liquefied_ten )
);

ROM_8  ROM_8_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_8_liquefied_ten )
);

ROM_9  ROM_9_liquefied_ten (
.address ( rdaddress_liquefied_ten ),
.clock ( clk_vga ),
.q ( data_9_liquefied_ten )
);

	wire     		 	 data_0_liquefied_one;
	wire     		 	 data_1_liquefied_one;
	wire     		 	 data_2_liquefied_one;
	wire     		 	 data_3_liquefied_one;
	wire     		 	 data_4_liquefied_one;
	wire     		 	 data_5_liquefied_one;
	wire     		 	 data_6_liquefied_one;
	wire     		 	 data_7_liquefied_one;
	wire     		 	 data_8_liquefied_one;
	wire     		 	 data_9_liquefied_one; 	
ROM_0  ROM_0_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_0_liquefied_one )
);

ROM_1  ROM_1_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_1_liquefied_one )
);

ROM_2  ROM_2_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_2_liquefied_one )
);

ROM_3  ROM_3_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_3_liquefied_one )
);

ROM_4  ROM_4_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_4_liquefied_one )
);

ROM_5  ROM_5_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_5_liquefied_one )
);

ROM_6  ROM_6_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_6_liquefied_one )
);

ROM_7  ROM_7_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_7_liquefied_one )
);

ROM_8  ROM_8_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_8_liquefied_one )
);

ROM_9  ROM_9_liquefied_one (
.address ( rdaddress_liquefied_one ),
.clock ( clk_vga ),
.q ( data_9_liquefied_one )
);

	wire     		 	 data_0_natural_ten;
	wire     		 	 data_1_natural_ten;
	wire     		 	 data_2_natural_ten;
	wire     		 	 data_3_natural_ten;
	wire     		 	 data_4_natural_ten;
	wire     		 	 data_5_natural_ten;
	wire     		 	 data_6_natural_ten;
	wire     		 	 data_7_natural_ten;
	wire     		 	 data_8_natural_ten;
	wire     		 	 data_9_natural_ten; 	
ROM_0  ROM_0_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_0_natural_ten )
);

ROM_1  ROM_1_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_1_natural_ten )
);

ROM_2  ROM_2_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_2_natural_ten )
);

ROM_3  ROM_3_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_3_natural_ten )
);

ROM_4  ROM_4_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_4_natural_ten )
);

ROM_5  ROM_5_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_5_natural_ten )
);

ROM_6  ROM_6_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_6_natural_ten )
);

ROM_7  ROM_7_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_7_natural_ten )
);

ROM_8  ROM_8_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_8_natural_ten )
);

ROM_9  ROM_9_natural_ten (
.address ( rdaddress_natural_ten ),
.clock ( clk_vga ),
.q ( data_9_natural_ten )
);

	wire     		 	 data_0_natural_one;
	wire     		 	 data_1_natural_one;
	wire     		 	 data_2_natural_one;
	wire     		 	 data_3_natural_one;
	wire     		 	 data_4_natural_one;
	wire     		 	 data_5_natural_one;
	wire     		 	 data_6_natural_one;
	wire     		 	 data_7_natural_one;
	wire     		 	 data_8_natural_one;
	wire     		 	 data_9_natural_one; 	
ROM_0  ROM_0_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_0_natural_one )
);

ROM_1  ROM_1_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_1_natural_one )
);

ROM_2  ROM_2_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_2_natural_one )
);

ROM_3  ROM_3_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_3_natural_one )
);

ROM_4  ROM_4_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_4_natural_one )
);

ROM_5  ROM_5_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_5_natural_one )
);

ROM_6  ROM_6_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_6_natural_one )
);

ROM_7  ROM_7_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_7_natural_one )
);

ROM_8  ROM_8_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_8_natural_one )
);

ROM_9  ROM_9_natural_one (
.address ( rdaddress_natural_one ),
.clock ( clk_vga ),
.q ( data_9_natural_one )
);

	wire     		 	 data_0_harmful_ten;
	wire     		 	 data_1_harmful_ten;
	wire     		 	 data_2_harmful_ten;
	wire     		 	 data_3_harmful_ten;
	wire     		 	 data_4_harmful_ten;
	wire     		 	 data_5_harmful_ten;
	wire     		 	 data_6_harmful_ten;
	wire     		 	 data_7_harmful_ten;
	wire     		 	 data_8_harmful_ten;
	wire     		 	 data_9_harmful_ten; 	
ROM_0  ROM_0_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_0_harmful_ten )
);

ROM_1  ROM_1_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_1_harmful_ten )
);

ROM_2  ROM_2_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_2_harmful_ten )
);

ROM_3  ROM_3_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_3_harmful_ten )
);

ROM_4  ROM_4_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_4_harmful_ten )
);

ROM_5  ROM_5_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_5_harmful_ten )
);

ROM_6  ROM_6_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_6_harmful_ten )
);

ROM_7  ROM_7_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_7_harmful_ten )
);

ROM_8  ROM_8_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_8_harmful_ten )
);

ROM_9  ROM_9_harmful_ten (
.address ( rdaddress_harmful_ten ),
.clock ( clk_vga ),
.q ( data_9_harmful_ten )
);

	wire     		 	 data_0_harmful_one;
	wire     		 	 data_1_harmful_one;
	wire     		 	 data_2_harmful_one;
	wire     		 	 data_3_harmful_one;
	wire     		 	 data_4_harmful_one;
	wire     		 	 data_5_harmful_one;
	wire     		 	 data_6_harmful_one;
	wire     		 	 data_7_harmful_one;
	wire     		 	 data_8_harmful_one;
	wire     		 	 data_9_harmful_one; 	
ROM_0  ROM_0_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_0_harmful_one )
);

ROM_1  ROM_1_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_1_harmful_one )
);

ROM_2  ROM_2_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_2_harmful_one )
);

ROM_3  ROM_3_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_3_harmful_one )
);

ROM_4  ROM_4_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_4_harmful_one )
);

ROM_5  ROM_5_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_5_harmful_one )
);

ROM_6  ROM_6_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_6_harmful_one )
);

ROM_7  ROM_7_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_7_harmful_one )
);

ROM_8  ROM_8_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_8_harmful_one )
);

ROM_9  ROM_9_harmful_one (
.address ( rdaddress_harmful_one ),
.clock ( clk_vga ),
.q ( data_9_harmful_one )
);

	wire     		 	 data_0_oxy_ten;
	wire     		 	 data_1_oxy_ten;
	wire     		 	 data_2_oxy_ten;
	wire     		 	 data_3_oxy_ten;
	wire     		 	 data_4_oxy_ten;
	wire     		 	 data_5_oxy_ten;
	wire     		 	 data_6_oxy_ten;
	wire     		 	 data_7_oxy_ten;
	wire     		 	 data_8_oxy_ten;
	wire     		 	 data_9_oxy_ten; 	
ROM_0  ROM_0_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_0_oxy_ten )
);

ROM_1  ROM_1_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_1_oxy_ten )
);

ROM_2  ROM_2_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_2_oxy_ten )
);

ROM_3  ROM_3_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_3_oxy_ten )
);

ROM_4  ROM_4_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_4_oxy_ten )
);

ROM_5  ROM_5_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_5_oxy_ten )
);

ROM_6  ROM_6_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_6_oxy_ten )
);

ROM_7  ROM_7_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_7_oxy_ten )
);

ROM_8  ROM_8_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_8_oxy_ten )
);

ROM_9  ROM_9_oxy_ten (
.address ( rdaddress_oxy_ten ),
.clock ( clk_vga ),
.q ( data_9_oxy_ten )
);

	wire     		 	 data_0_oxy_one;
	wire     		 	 data_1_oxy_one;
	wire     		 	 data_2_oxy_one;
	wire     		 	 data_3_oxy_one;
	wire     		 	 data_4_oxy_one;
	wire     		 	 data_5_oxy_one;
	wire     		 	 data_6_oxy_one;
	wire     		 	 data_7_oxy_one;
	wire     		 	 data_8_oxy_one;
	wire     		 	 data_9_oxy_one; 	
ROM_0  ROM_0_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_0_oxy_one )
);

ROM_1  ROM_1_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_1_oxy_one )
);

ROM_2  ROM_2_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_2_oxy_one )
);

ROM_3  ROM_3_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_3_oxy_one )
);

ROM_4  ROM_4_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_4_oxy_one )
);

ROM_5  ROM_5_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_5_oxy_one )
);

ROM_6  ROM_6_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_6_oxy_one )
);

ROM_7  ROM_7_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_7_oxy_one )
);

ROM_8  ROM_8_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_8_oxy_one )
);

ROM_9  ROM_9_oxy_one (
.address ( rdaddress_oxy_one ),
.clock ( clk_vga ),
.q ( data_9_oxy_one )
);

	wire     		 	 data_0_temp_ten;
	wire     		 	 data_1_temp_ten;
	wire     		 	 data_2_temp_ten;
	wire     		 	 data_3_temp_ten;
	wire     		 	 data_4_temp_ten;
	wire     		 	 data_5_temp_ten;
	wire     		 	 data_6_temp_ten;
	wire     		 	 data_7_temp_ten;
	wire     		 	 data_8_temp_ten;
	wire     		 	 data_9_temp_ten; 	
ROM_0  ROM_0_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_0_temp_ten )
);

ROM_1  ROM_1_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_1_temp_ten )
);

ROM_2  ROM_2_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_2_temp_ten )
);

ROM_3  ROM_3_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_3_temp_ten )
);

ROM_4  ROM_4_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_4_temp_ten )
);

ROM_5  ROM_5_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_5_temp_ten )
);

ROM_6  ROM_6_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_6_temp_ten )
);

ROM_7  ROM_7_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_7_temp_ten )
);

ROM_8  ROM_8_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_8_temp_ten )
);

ROM_9  ROM_9_temp_ten (
.address ( rdaddress_temp_ten ),
.clock ( clk_vga ),
.q ( data_9_temp_ten )
);

	wire     		 	 data_0_temp_one;
	wire     		 	 data_1_temp_one;
	wire     		 	 data_2_temp_one;
	wire     		 	 data_3_temp_one;
	wire     		 	 data_4_temp_one;
	wire     		 	 data_5_temp_one;
	wire     		 	 data_6_temp_one;
	wire     		 	 data_7_temp_one;
	wire     		 	 data_8_temp_one;
	wire     		 	 data_9_temp_one; 	
ROM_0  ROM_0_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_0_temp_one )
);

ROM_1  ROM_1_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_1_temp_one )
);

ROM_2  ROM_2_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_2_temp_one )
);

ROM_3  ROM_3_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_3_temp_one )
);

ROM_4  ROM_4_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_4_temp_one )
);

ROM_5  ROM_5_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_5_temp_one )
);

ROM_6  ROM_6_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_6_temp_one )
);

ROM_7  ROM_7_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_7_temp_one )
);

ROM_8  ROM_8_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_8_temp_one )
);

ROM_9  ROM_9_temp_one (
.address ( rdaddress_temp_one ),
.clock ( clk_vga ),
.q ( data_9_temp_one )
);

	wire     		 	 data_0_hum_ten;
	wire     		 	 data_1_hum_ten;
	wire     		 	 data_2_hum_ten;
	wire     		 	 data_3_hum_ten;
	wire     		 	 data_4_hum_ten;
	wire     		 	 data_5_hum_ten;
	wire     		 	 data_6_hum_ten;
	wire     		 	 data_7_hum_ten;
	wire     		 	 data_8_hum_ten;
	wire     		 	 data_9_hum_ten; 	
ROM_0  ROM_0_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_0_hum_ten )
);

ROM_1  ROM_1_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_1_hum_ten )
);

ROM_2  ROM_2_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_2_hum_ten )
);

ROM_3  ROM_3_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_3_hum_ten )
);

ROM_4  ROM_4_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_4_hum_ten )
);

ROM_5  ROM_5_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_5_hum_ten )
);

ROM_6  ROM_6_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_6_hum_ten )
);

ROM_7  ROM_7_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_7_hum_ten )
);

ROM_8  ROM_8_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_8_hum_ten )
);

ROM_9  ROM_9_hum_ten (
.address ( rdaddress_hum_ten ),
.clock ( clk_vga ),
.q ( data_9_hum_ten )
);

	wire     		 	 data_0_hum_one;
	wire     		 	 data_1_hum_one;
	wire     		 	 data_2_hum_one;
	wire     		 	 data_3_hum_one;
	wire     		 	 data_4_hum_one;
	wire     		 	 data_5_hum_one;
	wire     		 	 data_6_hum_one;
	wire     		 	 data_7_hum_one;
	wire     		 	 data_8_hum_one;
	wire     		 	 data_9_hum_one; 	
ROM_0  ROM_0_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_0_hum_one )
);

ROM_1  ROM_1_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_1_hum_one )
);

ROM_2  ROM_2_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_2_hum_one )
);

ROM_3  ROM_3_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_3_hum_one )
);

ROM_4  ROM_4_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_4_hum_one )
);

ROM_5  ROM_5_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_5_hum_one )
);

ROM_6  ROM_6_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_6_hum_one )
);

ROM_7  ROM_7_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_7_hum_one )
);

ROM_8  ROM_8_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_8_hum_one )
);

ROM_9  ROM_9_hum_one (
.address ( rdaddress_hum_one ),
.clock ( clk_vga ),
.q ( data_9_hum_one )
);

endmodule
