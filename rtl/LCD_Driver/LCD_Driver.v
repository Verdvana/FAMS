/*============================================================================
*
*  LOGIC CORE:          TFT驱动模块		
*  MODULE NAME:         tft_driver
*	author:					Verdvana
*  REVISION HISTORY:  
*
*    Revision 1.0  2019/4/12     
*
*  FUNCTIONAL DESCRIPTION:
===========================================================================*/


module LCD_Driver(
							input 				clk,    			//33.3M
							input 				rst_n,
							input 	[23:0] 	data_in,   		//待显示数据
							
							output 	[10:0] 	hcount_1,			//x坐标
							output 	[10:0] 	vcount_1,			//y坐标
							output 	[10:0] 	hcount_2,			//x坐标
							output 	[10:0] 	vcount_2,			//y坐标
							output 	[10:0] 	hcount_theme,			//x坐标
							output 	[10:0] 	vcount_theme,			//y坐标
							output 	[10:0] 	hcount_veneno,			//x坐标
							output 	[10:0] 	vcount_veneno,			//y坐标
							output 	[10:0] 	hcount_body_temp,			//x坐标
							output 	[10:0] 	vcount_body_temp,			//y坐标							
							output 	[10:0] 	hcount_body_temp_int_ten,			//x坐标
							output 	[10:0] 	vcount_body_temp_int_ten,			//y坐标	
							output 	[10:0] 	hcount_body_temp_int_one,			//x坐标
							output 	[10:0] 	vcount_body_temp_int_one,			//y坐标	
							output 	[10:0] 	hcount_body_temp_dp,			//x坐标
							output 	[10:0] 	vcount_body_temp_dp,			//y坐标	
							output 	[10:0] 	hcount_body_temp_dec_ten,			//x坐标
							output 	[10:0] 	vcount_body_temp_dec_ten,			//y坐标		
							output 	[10:0] 	hcount_body_temp_unit,			//x坐标
							output 	[10:0] 	vcount_body_temp_unit,			//y坐标	
							output 	[10:0] 	hcount_heart_rate,			//x坐标
							output 	[10:0] 	vcount_heart_rate,			//y坐标
						   output 	[10:0] 	hcount_heart_rate_hun,			//x坐标
							output 	[10:0] 	vcount_heart_rate_hun,			//y坐标	
							output 	[10:0] 	hcount_heart_rate_ten,			//x坐标
							output 	[10:0] 	vcount_heart_rate_ten,			//y坐标
							output 	[10:0] 	hcount_heart_rate_one,			//x坐标
							output 	[10:0] 	vcount_heart_rate_one,			//y坐标
							output 	[10:0] 	hcount_h2,			//x坐标
							output 	[10:0] 	vcount_h2,			//y坐标
							output 	[10:0] 	hcount_h2_ten,			//x坐标
							output 	[10:0] 	vcount_h2_ten,			//y坐标							
							output 	[10:0] 	hcount_h2_one,			//x坐标
							output 	[10:0] 	vcount_h2_one,			//y坐标
							output 	[10:0] 	hcount_liquefied,			//x坐标
							output 	[10:0] 	vcount_liquefied,			//y坐标
							output 	[10:0] 	hcount_liquefied_ten,			//x坐标
							output 	[10:0] 	vcount_liquefied_ten,			//y坐标							
							output 	[10:0] 	hcount_liquefied_one,			//x坐标
							output 	[10:0] 	vcount_liquefied_one,			//y坐标
							output 	[10:0] 	hcount_natural,			//x坐标
							output 	[10:0] 	vcount_natural,			//y坐标
							output 	[10:0] 	hcount_harmful,			//x坐标
							output 	[10:0] 	vcount_harmful,			//y坐标
							output 	[10:0] 	hcount_oxy,			//x坐标
							output 	[10:0] 	vcount_oxy,			//y坐标
							output 	[10:0] 	hcount_temp,			//x坐标
							output 	[10:0] 	vcount_temp,			//y坐标
							output 	[10:0] 	hcount_hum,			//x坐标
							output 	[10:0] 	vcount_hum,			//y坐标
							output 	[10:0] 	hcount_natural_ten,			//x坐标
							output 	[10:0] 	vcount_natural_ten,			//y坐标							
							output 	[10:0] 	hcount_natural_one,			//x坐标
							output 	[10:0] 	vcount_natural_one,			//y坐标
							output 	[10:0] 	hcount_harmful_ten,			//x坐标
							output 	[10:0] 	vcount_harmful_ten,			//y坐标							
							output 	[10:0] 	hcount_harmful_one,			//x坐标
							output 	[10:0] 	vcount_harmful_one,			//y坐标
							output 	[10:0] 	hcount_oxy_ten,			//x坐标
							output 	[10:0] 	vcount_oxy_ten,			//y坐标							
							output 	[10:0] 	hcount_oxy_one,			//x坐标
							output 	[10:0] 	vcount_oxy_one,			//y坐标
							output 	[10:0] 	hcount_temp_ten,			//x坐标
							output 	[10:0] 	vcount_temp_ten,			//y坐标							
							output 	[10:0] 	hcount_temp_one,			//x坐标
							output 	[10:0] 	vcount_temp_one,			//y坐标
							output 	[10:0] 	hcount_hum_ten,			//x坐标
							output 	[10:0] 	vcount_hum_ten,			//y坐标							
							output 	[10:0] 	hcount_hum_one,			//x坐标
							output 	[10:0] 	vcount_hum_one,			//y坐标
							output 	[10:0] 	hcount_ppm,			//x坐标
							output 	[10:0] 	vcount_ppm,			//y坐标
							output 	[10:0] 	hcount_rh,			//x坐标
							output 	[10:0] 	vcount_rh,			//y坐标
							output 	[10:0] 	hcount_temp_unit,			//x坐标
							output 	[10:0] 	vcount_temp_unit,			//y坐标
							
							
							
							output				lcd_request_1,	//数据请求信号
							output				lcd_request_2,	//数据请求信号
							output				lcd_request_theme,	//数据请求信号
							output				lcd_request_veneno,	//数据请求信号
							output				lcd_request_body_temp,	//数据请求信号
							output				lcd_request_body_temp_int_ten,	//数据请求信号
							output				lcd_request_body_temp_int_one,	//数据请求信号
							output				lcd_request_body_temp_dp,	//数据请求信号
							output				lcd_request_body_temp_dec_ten,	//数据请求信号
							output				lcd_request_body_temp_unit,	//数据请求信号
							output				lcd_request_heart_rate,	//数据请求信号		
							output				lcd_request_heart_rate_hun,	//数据请求信号	
							output				lcd_request_heart_rate_ten,	//数据请求信号	
							output				lcd_request_heart_rate_one,	//数据请求信号	
							output				lcd_request_h2,	//数据请求信号	
							output				lcd_request_h2_ten,	//数据请求信号	
							output				lcd_request_h2_one,	//数据请求信号	
							output				lcd_request_liquefied,	//数据请求信号	
							output				lcd_request_liquefied_ten,	//数据请求信号	
							output				lcd_request_liquefied_one,	//数据请求信号	
							output				lcd_request_natural,	//数据请求信号
							output				lcd_request_harmful,	//数据请求信号
							output				lcd_request_oxy,	//数据请求信号
							output				lcd_request_temp,	//数据请求信号
							output				lcd_request_hum,	//数据请求信号
							output				lcd_request_natural_ten,	//数据请求信号	
							output				lcd_request_natural_one,	//数据请求信号	
							output				lcd_request_harmful_ten,	//数据请求信号	
							output				lcd_request_harmful_one,	//数据请求信号	
							output				lcd_request_oxy_ten,	//数据请求信号	
							output				lcd_request_oxy_one,	//数据请求信号	
							output				lcd_request_temp_ten,	//数据请求信号	
							output				lcd_request_temp_one,	//数据请求信号	
							output				lcd_request_hum_ten,	//数据请求信号	
							output				lcd_request_hum_one,	//数据请求信号	
							output				lcd_request_ppm,	//数据请求信号	
							output				lcd_request_rh,	//数据请求信号
							output				lcd_request_temp_unit,	//数据请求信号
							
							
							output 				lcd_clk,			//驱动时钟
							output				lcd_de,			//使能
							output 				lcd_blank_n,
							output 				lcd_hsync,
							output 				lcd_vsync,	
							output 	[23:0] 	lcd_rgb,   //TFT数据输出
							output 				lcd_pwm

);

//800*480 时序参数	
parameter  H_SYNC   =  11'd2;      //行同步
parameter  H_BACK   =  11'd44;     //行显示后沿
parameter  H_DISP   =  11'd800;    //行有效数据
parameter  H_FRON   =  11'd210;    //行显示前沿
parameter  H_TOTAL  =  11'd1056;   //行扫描周期
   
parameter  V_SYNC   =  11'd2;      //场同步
parameter  V_BACK   =  11'd22;     //场显示后沿
parameter  V_DISP   =  11'd480;    //场有效数据
parameter  V_FRONT  =  11'd22;     //场显示前沿
parameter  V_TOTAL  =  11'd524;    //场扫描周期  


//需要显示区域
parameter	X_START	=	12'd0;
parameter	X_ZOOM	=	12'd800;
parameter	Y_START	=	12'd0;
parameter	Y_ZOOM	=	12'd480; 
//红外
parameter	X_START_1	=	12'd0;
parameter	X_ZOOM_1	=	12'd640;
parameter	Y_START_1	=	12'd0;
parameter	Y_ZOOM_1	=	12'd480; 
//热成像
parameter	X_START_2	=	12'd672;
parameter	X_ZOOM_2	=	12'd128;
parameter	Y_START_2	=	12'd384;
parameter	Y_ZOOM_2	=	12'd96; 
//题目
parameter	X_START_theme	=	12'd648;
parameter	X_ZOOM_theme	=	12'd144;
parameter	Y_START_theme	=	12'd0;
parameter	Y_ZOOM_theme	=	12'd16; 
//veneno
parameter	X_START_veneno	=	12'd740;
parameter	X_ZOOM_veneno	=	12'd48;
parameter	Y_START_veneno	=	12'd30;
parameter	Y_ZOOM_veneno	=	12'd16; 	
//体温
parameter	X_START_body_temp	=	12'd648;
parameter	X_ZOOM_body_temp	=	12'd48;
parameter	Y_START_body_temp	=	12'd60;
parameter	Y_ZOOM_body_temp	=	12'd16; 	
//体温整数十位
parameter	X_START_body_temp_int_ten	=	12'd730;
parameter	X_ZOOM_body_temp_int_ten	=	12'd8;
parameter	Y_START_body_temp_int_ten	=	12'd60;
parameter	Y_ZOOM_body_temp_int_ten	=	12'd16; 
//体温整数个位
parameter	X_START_body_temp_int_one	=	12'd738;
parameter	X_ZOOM_body_temp_int_one	=	12'd8;
parameter	Y_START_body_temp_int_one	=	12'd60;
parameter	Y_ZOOM_body_temp_int_one	=	12'd16; 
//体温小数点
parameter	X_START_body_temp_dp	=	12'd746;
parameter	X_ZOOM_body_temp_dp	=	12'd8;
parameter	Y_START_body_temp_dp	=	12'd60;
parameter	Y_ZOOM_body_temp_dp	=	12'd16; 
//体温小数十位
parameter	X_START_body_temp_dec_ten	=	12'd754;
parameter	X_ZOOM_body_temp_dec_ten	=	12'd8;
parameter	Y_START_body_temp_dec_ten	=	12'd60;
parameter	Y_ZOOM_body_temp_dec_ten	=	12'd16; 

//体温单位
parameter	X_START_body_temp_unit	=	12'd762;
parameter	X_ZOOM_body_temp_unit	=	12'd16;
parameter	Y_START_body_temp_unit	=	12'd60;
parameter	Y_ZOOM_body_temp_unit	=	12'd16; 

//心率
parameter	X_START_heart_rate	=	12'd648;
parameter	X_ZOOM_heart_rate	=	12'd48;
parameter	Y_START_heart_rate	=	12'd90;
parameter	Y_ZOOM_heart_rate	=	12'd16; 
//心率百位
parameter	X_START_heart_rate_hun	=	12'd730;
parameter	X_ZOOM_heart_rate_hun	=	12'd8;
parameter	Y_START_heart_rate_hun	=	12'd90;
parameter	Y_ZOOM_heart_rate_hun	=	12'd16; 
//心率十位
parameter	X_START_heart_rate_ten	=	12'd738;
parameter	X_ZOOM_heart_rate_ten	=	12'd8;
parameter	Y_START_heart_rate_ten	=	12'd90;
parameter	Y_ZOOM_heart_rate_ten	=	12'd16; 
//心率个位
parameter	X_START_heart_rate_one	=	12'd746;
parameter	X_ZOOM_heart_rate_one	=	12'd8;
parameter	Y_START_heart_rate_one	=	12'd90;
parameter	Y_ZOOM_heart_rate_one	=	12'd16; 
//H2
parameter	X_START_h2	=	12'd648;
parameter	X_ZOOM_h2	=	12'd48;
parameter	Y_START_h2	=	12'd120;
parameter	Y_ZOOM_h2	=	12'd16; 
//H2十位
parameter	X_START_h2_ten	=	12'd730;
parameter	X_ZOOM_h2_ten	=	12'd8;
parameter	Y_START_h2_ten	=	12'd120;
parameter	Y_ZOOM_h2_ten	=	12'd16;
//H2个位
parameter	X_START_h2_one	=	12'd738;
parameter	X_ZOOM_h2_one	=	12'd8;
parameter	Y_START_h2_one	=	12'd120;
parameter	Y_ZOOM_h2_one	=	12'd16;
//液化气
parameter	X_START_liquefied	=	12'd648;
parameter	X_ZOOM_liquefied	=	12'd64;
parameter	Y_START_liquefied	=	12'd150;
parameter	Y_ZOOM_liquefied	=	12'd16;
//液化气十位
parameter	X_START_liquefied_ten	=	12'd730;
parameter	X_ZOOM_liquefied_ten	=	12'd8;
parameter	Y_START_liquefied_ten	=	12'd150;
parameter	Y_ZOOM_liquefied_ten	=	12'd16;
//液化气个位
parameter	X_START_liquefied_one	=	12'd738;
parameter	X_ZOOM_liquefied_one	=	12'd8;
parameter	Y_START_liquefied_one	=	12'd150;
parameter	Y_ZOOM_liquefied_one	=	12'd16;
//天然气
parameter	X_START_natural	=	12'd648;
parameter	X_ZOOM_natural	=	12'd64;
parameter	Y_START_natural	=	12'd180;
parameter	Y_ZOOM_natural	=	12'd16;
//有害气
parameter	X_START_harmful	=	12'd648;
parameter	X_ZOOM_harmful	=	12'd80;
parameter	Y_START_harmful	=	12'd210;
parameter	Y_ZOOM_harmful	=	12'd16;
//氧气
parameter	X_START_oxy	=	12'd648;
parameter	X_ZOOM_oxy	=	12'd48;
parameter	Y_START_oxy	=	12'd240;
parameter	Y_ZOOM_oxy	=	12'd16;
//温度
parameter	X_START_temp	=	12'd648;
parameter	X_ZOOM_temp	=	12'd48;
parameter	Y_START_temp	=	12'd270;
parameter	Y_ZOOM_temp =	12'd16;
//湿度
parameter	X_START_hum	=	12'd648;
parameter	X_ZOOM_hum	=	12'd48;
parameter	Y_START_hum	=	12'd300;
parameter	Y_ZOOM_hum	=	12'd16;
//天然气十位
parameter	X_START_natural_ten	=	12'd730;
parameter	X_ZOOM_natural_ten	=	12'd8;
parameter	Y_START_natural_ten	=	12'd180;
parameter	Y_ZOOM_natural_ten	=	12'd16;
//天然气个位
parameter	X_START_natural_one	=	12'd738;
parameter	X_ZOOM_natural_one	=	12'd8;
parameter	Y_START_natural_one	=	12'd180;
parameter	Y_ZOOM_natural_one	=	12'd16;
//有害气十位
parameter	X_START_harmful_ten	=	12'd730;
parameter	X_ZOOM_harmful_ten	=	12'd8;
parameter	Y_START_harmful_ten	=	12'd210;
parameter	Y_ZOOM_harmful_ten	=	12'd16;
//有害气个位
parameter	X_START_harmful_one	=	12'd738;
parameter	X_ZOOM_harmful_one	=	12'd8;
parameter	Y_START_harmful_one	=	12'd210;
parameter	Y_ZOOM_harmful_one	=	12'd16;
//氧气十位
parameter	X_START_oxy_ten	=	12'd730;
parameter	X_ZOOM_oxy_ten	=	12'd8;
parameter	Y_START_oxy_ten	=	12'd240;
parameter	Y_ZOOM_oxy_ten	=	12'd16;
//氧气个位
parameter	X_START_oxy_one	=	12'd738;
parameter	X_ZOOM_oxy_one	=	12'd8;
parameter	Y_START_oxy_one	=	12'd240;
parameter	Y_ZOOM_oxy_one	=	12'd16;
//温度十位
parameter	X_START_temp_ten	=	12'd730;
parameter	X_ZOOM_temp_ten	=	12'd8;
parameter	Y_START_temp_ten	=	12'd270;
parameter	Y_ZOOM_temp_ten	=	12'd16;
//温度个位
parameter	X_START_temp_one	=	12'd738;
parameter	X_ZOOM_temp_one	=	12'd8;
parameter	Y_START_temp_one	=	12'd270;
parameter	Y_ZOOM_temp_one	=	12'd16;
//湿度十位
parameter	X_START_hum_ten	=	12'd730;
parameter	X_ZOOM_hum_ten	=	12'd8;
parameter	Y_START_hum_ten	=	12'd300;
parameter	Y_ZOOM_hum_ten	=	12'd16;
//湿度个位
parameter	X_START_hum_one	=	12'd738;
parameter	X_ZOOM_hum_one	=	12'd8;
parameter	Y_START_hum_one	=	12'd300;
parameter	Y_ZOOM_hum_one	=	12'd16;
//ppm
parameter	X_START_ppm	=	12'd762;
parameter	X_ZOOM_ppm	=	12'd24;
parameter	Y_START_ppm	=	12'd120;
parameter	Y_ZOOM_ppm	=	12'd136;
//rh
parameter	X_START_rh	=	12'd762;
parameter	X_ZOOM_rh	=	12'd16;
parameter	Y_START_rh	=	12'd300;
parameter	Y_ZOOM_rh	=	12'd16;
//温度单位
parameter	X_START_temp_unit	=	12'd762;
parameter	X_ZOOM_temp_unit	=	12'd16;
parameter	Y_START_temp_unit	=	12'd270;
parameter	Y_ZOOM_temp_unit	=	12'd16;
	
assign lcd_clk=clk;
assign lcd_pwm=rst_n;
	
//TFT驱动部分
reg [10:0] hcount_r;   //TFT行扫描计数器
reg [10:0] vcount_r;		//TFT场扫描计数器
//行扫扫描
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		hcount_r<=11'd0;
		
	else if(hcount_r == H_TOTAL)
		hcount_r<=11'd0;
		
	else
		hcount_r<=hcount_r+11'd1;
		
end		
	
//场扫描
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		vcount_r<=11'd0;
		
	else if(hcount_r == H_TOTAL)
		begin
			if(vcount_r==V_TOTAL)
				vcount_r<=11'd0;
				
			else
				vcount_r<=vcount_r+11'd1;
		end
		
	else
		vcount_r<=vcount_r;
end		
	
//数据、同频信号输出
assign lcd_de=((hcount_r>= (H_SYNC + H_BACK)) && (hcount_r< (H_SYNC + H_BACK + H_DISP)))
				&&((vcount_r>= (V_SYNC + V_BACK)) && (vcount_r< (V_SYNC + V_BACK + V_DISP))) ? 1'b1:1'b0;
				
assign lcd_hsync=(hcount_r> H_SYNC -1);
assign lcd_vsync=(vcount_r> V_SYNC -1);
assign lcd_rgb=(lcd_request)?data_in:24'h0000;
assign lcd_blank_n = lcd_de;
					 
assign lcd_request = ((hcount_r>= (H_SYNC + H_BACK + X_START)) && (hcount_r< (H_SYNC + H_BACK  + X_START + X_ZOOM )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START )) && (vcount_r< (V_SYNC + V_BACK  + Y_START + Y_ZOOM)));
				
assign lcd_request_1 = ((hcount_r>= (H_SYNC + H_BACK + X_START_1)) && (hcount_r< (H_SYNC + H_BACK  + X_START_1 + X_ZOOM_1 )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_1 )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_1 + Y_ZOOM_1)));
				
assign lcd_request_2 = ((hcount_r>= (H_SYNC + H_BACK + X_START_2)) && (hcount_r< (H_SYNC + H_BACK  + X_START_2 + X_ZOOM_2 )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_2 )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_2 + Y_ZOOM_2)));

assign lcd_request_theme = ((hcount_r>= (H_SYNC + H_BACK + X_START_theme)) && (hcount_r< (H_SYNC + H_BACK  + X_START_theme + X_ZOOM_theme )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_theme )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_theme + Y_ZOOM_theme)));
				
assign lcd_request_veneno = ((hcount_r>= (H_SYNC + H_BACK + X_START_veneno)) && (hcount_r< (H_SYNC + H_BACK  + X_START_veneno + X_ZOOM_veneno )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_veneno )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_veneno + Y_ZOOM_veneno)));

assign lcd_request_body_temp = ((hcount_r>= (H_SYNC + H_BACK + X_START_body_temp)) && (hcount_r< (H_SYNC + H_BACK  + X_START_body_temp + X_ZOOM_body_temp )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_body_temp )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_body_temp + Y_ZOOM_body_temp)));

assign lcd_request_body_temp_int_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_body_temp_int_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_body_temp_int_ten + X_ZOOM_body_temp_int_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_body_temp_int_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_body_temp_int_ten + Y_ZOOM_body_temp_int_ten)));

assign lcd_request_body_temp_int_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_body_temp_int_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_body_temp_int_one + X_ZOOM_body_temp_int_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_body_temp_int_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_body_temp_int_one + Y_ZOOM_body_temp_int_one)));

assign lcd_request_body_temp_dp = ((hcount_r>= (H_SYNC + H_BACK + X_START_body_temp_dp)) && (hcount_r< (H_SYNC + H_BACK  + X_START_body_temp_dp + X_ZOOM_body_temp_dp )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_body_temp_dp )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_body_temp_dp + Y_ZOOM_body_temp_dp)));

assign lcd_request_body_temp_dec_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_body_temp_dec_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_body_temp_dec_ten + X_ZOOM_body_temp_dec_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_body_temp_dec_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_body_temp_dec_ten + Y_ZOOM_body_temp_dec_ten)));

assign lcd_request_body_temp_unit = ((hcount_r>= (H_SYNC + H_BACK + X_START_body_temp_unit)) && (hcount_r< (H_SYNC + H_BACK  + X_START_body_temp_unit + X_ZOOM_body_temp_unit )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_body_temp_unit )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_body_temp_unit + Y_ZOOM_body_temp_unit)));	
					
assign lcd_request_heart_rate = ((hcount_r>= (H_SYNC + H_BACK + X_START_heart_rate)) && (hcount_r< (H_SYNC + H_BACK  + X_START_heart_rate + X_ZOOM_heart_rate )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_heart_rate )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_heart_rate + Y_ZOOM_heart_rate)));	

assign lcd_request_heart_rate_hun = ((hcount_r>= (H_SYNC + H_BACK + X_START_heart_rate_hun)) && (hcount_r< (H_SYNC + H_BACK  + X_START_heart_rate_hun + X_ZOOM_heart_rate_hun )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_heart_rate_hun )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_heart_rate_hun + Y_ZOOM_heart_rate_hun)));
				
assign lcd_request_heart_rate_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_heart_rate_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_heart_rate_ten + X_ZOOM_heart_rate_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_heart_rate_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_heart_rate_ten + Y_ZOOM_heart_rate_ten)));
				
assign lcd_request_heart_rate_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_heart_rate_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_heart_rate_one + X_ZOOM_heart_rate_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_heart_rate_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_heart_rate_one + Y_ZOOM_heart_rate_one)));
				
assign lcd_request_h2 = ((hcount_r>= (H_SYNC + H_BACK + X_START_h2)) && (hcount_r< (H_SYNC + H_BACK  + X_START_h2 + X_ZOOM_h2 )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_h2 )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_h2 + Y_ZOOM_h2)));

assign lcd_request_h2_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_h2_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_h2_ten + X_ZOOM_h2_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_h2_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_h2_ten + Y_ZOOM_h2_ten)));
				
assign lcd_request_h2_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_h2_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_h2_one + X_ZOOM_h2_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_h2_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_h2_one + Y_ZOOM_h2_one)));
				
assign lcd_request_liquefied = ((hcount_r>= (H_SYNC + H_BACK + X_START_liquefied)) && (hcount_r< (H_SYNC + H_BACK  + X_START_liquefied + X_ZOOM_liquefied )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_liquefied )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_liquefied + Y_ZOOM_liquefied)));
				
assign lcd_request_liquefied_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_liquefied_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_liquefied_ten + X_ZOOM_liquefied_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_liquefied_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_liquefied_ten + Y_ZOOM_liquefied_ten)));
				
assign lcd_request_liquefied_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_liquefied_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_liquefied_one + X_ZOOM_liquefied_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_liquefied_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_liquefied_one + Y_ZOOM_liquefied_one)));

assign lcd_request_natural = ((hcount_r>= (H_SYNC + H_BACK + X_START_natural)) && (hcount_r< (H_SYNC + H_BACK  + X_START_natural + X_ZOOM_natural )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_natural )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_natural + Y_ZOOM_natural)));
		
assign lcd_request_harmful = ((hcount_r>= (H_SYNC + H_BACK + X_START_harmful)) && (hcount_r< (H_SYNC + H_BACK  + X_START_harmful + X_ZOOM_harmful )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_harmful )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_harmful + Y_ZOOM_harmful)));

assign lcd_request_oxy = ((hcount_r>= (H_SYNC + H_BACK + X_START_oxy)) && (hcount_r< (H_SYNC + H_BACK  + X_START_oxy + X_ZOOM_oxy )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_oxy )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_oxy + Y_ZOOM_oxy)));
				
assign lcd_request_temp = ((hcount_r>= (H_SYNC + H_BACK + X_START_temp)) && (hcount_r< (H_SYNC + H_BACK  + X_START_temp + X_ZOOM_temp )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_temp )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_temp + Y_ZOOM_temp)));
				
assign lcd_request_hum = ((hcount_r>= (H_SYNC + H_BACK + X_START_hum)) && (hcount_r< (H_SYNC + H_BACK  + X_START_hum + X_ZOOM_hum )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_hum )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_hum + Y_ZOOM_hum)));
				
				
assign lcd_request_natural_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_natural_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_natural_ten + X_ZOOM_natural_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_natural_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_natural_ten + Y_ZOOM_natural_ten)));
				
assign lcd_request_natural_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_natural_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_natural_one + X_ZOOM_natural_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_natural_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_natural_one + Y_ZOOM_natural_one)));

				
assign lcd_request_harmful_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_harmful_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_harmful_ten + X_ZOOM_harmful_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_harmful_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_harmful_ten + Y_ZOOM_harmful_ten)));
				
assign lcd_request_harmful_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_harmful_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_harmful_one + X_ZOOM_harmful_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_harmful_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_harmful_one + Y_ZOOM_harmful_one)));

				
assign lcd_request_oxy_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_oxy_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_oxy_ten + X_ZOOM_oxy_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_oxy_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_oxy_ten + Y_ZOOM_oxy_ten)));
				
assign lcd_request_oxy_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_oxy_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_oxy_one + X_ZOOM_oxy_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_oxy_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_oxy_one + Y_ZOOM_oxy_one)));

				
assign lcd_request_temp_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_temp_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_temp_ten + X_ZOOM_temp_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_temp_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_temp_ten + Y_ZOOM_temp_ten)));
				
assign lcd_request_temp_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_temp_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_temp_one + X_ZOOM_temp_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_temp_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_temp_one + Y_ZOOM_temp_one)));

				
assign lcd_request_hum_ten = ((hcount_r>= (H_SYNC + H_BACK + X_START_hum_ten)) && (hcount_r< (H_SYNC + H_BACK  + X_START_hum_ten + X_ZOOM_hum_ten )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_hum_ten )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_hum_ten + Y_ZOOM_hum_ten)));
				
assign lcd_request_hum_one = ((hcount_r>= (H_SYNC + H_BACK + X_START_hum_one)) && (hcount_r< (H_SYNC + H_BACK  + X_START_hum_one + X_ZOOM_hum_one )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_hum_one )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_hum_one + Y_ZOOM_hum_one)));	
	
assign lcd_request_ppm = ((hcount_r>= (H_SYNC + H_BACK + X_START_ppm)) && (hcount_r< (H_SYNC + H_BACK  + X_START_ppm + X_ZOOM_ppm )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_ppm )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_ppm + Y_ZOOM_ppm)));

assign lcd_request_rh = ((hcount_r>= (H_SYNC + H_BACK + X_START_rh)) && (hcount_r< (H_SYNC + H_BACK  + X_START_rh + X_ZOOM_rh )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_rh )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_rh + Y_ZOOM_rh)));

assign lcd_request_temp_unit = ((hcount_r>= (H_SYNC + H_BACK + X_START_temp_unit)) && (hcount_r< (H_SYNC + H_BACK  + X_START_temp_unit + X_ZOOM_temp_unit )))
				&&((vcount_r>= (V_SYNC + V_BACK + Y_START_temp_unit )) && (vcount_r< (V_SYNC + V_BACK  + Y_START_temp_unit + Y_ZOOM_temp_unit)));	
			
			
				
assign hcount_1=lcd_request_1 ? (hcount_r - H_SYNC - H_BACK - X_START_1 ):11'd0;  
assign vcount_1=lcd_request_1 ? (vcount_r - V_SYNC - V_BACK - Y_START_1 ):11'd0;
							
assign hcount_2=lcd_request_2 ? (hcount_r - H_SYNC - H_BACK - X_START_2 ):11'd0;  
assign vcount_2=lcd_request_2 ? (vcount_r - V_SYNC - V_BACK - Y_START_2 ):11'd0;	

assign hcount_theme=lcd_request_theme ? (hcount_r - H_SYNC - H_BACK - X_START_theme ):11'd0;  
assign vcount_theme=lcd_request_theme ? (vcount_r - V_SYNC - V_BACK - Y_START_theme ):11'd0;	

assign hcount_veneno=lcd_request_veneno ? (hcount_r - H_SYNC - H_BACK - X_START_veneno ):11'd0;  
assign vcount_veneno=lcd_request_veneno ? (vcount_r - V_SYNC - V_BACK - Y_START_veneno ):11'd0;

assign hcount_body_temp=lcd_request_body_temp ? (hcount_r - H_SYNC - H_BACK - X_START_body_temp ):11'd0;  
assign vcount_body_temp=lcd_request_body_temp ? (vcount_r - V_SYNC - V_BACK - Y_START_body_temp ):11'd0;

assign hcount_body_temp_int_ten=lcd_request_body_temp_int_ten ? (hcount_r - H_SYNC - H_BACK - X_START_body_temp_int_ten ):11'd0;  
assign vcount_body_temp_int_ten=lcd_request_body_temp_int_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_body_temp_int_ten ):11'd0;

assign hcount_body_temp_int_one=lcd_request_body_temp_int_one ? (hcount_r - H_SYNC - H_BACK - X_START_body_temp_int_one ):11'd0;  
assign vcount_body_temp_int_one=lcd_request_body_temp_int_one ? (vcount_r - V_SYNC - V_BACK - Y_START_body_temp_int_one ):11'd0;

assign hcount_body_temp_dp=lcd_request_body_temp_dp ? (hcount_r - H_SYNC - H_BACK - X_START_body_temp_dp ):11'd0;  
assign vcount_body_temp_dp=lcd_request_body_temp_dp ? (vcount_r - V_SYNC - V_BACK - Y_START_body_temp_dp ):11'd0;

assign hcount_body_temp_dec_ten=lcd_request_body_temp_dec_ten ? (hcount_r - H_SYNC - H_BACK - X_START_body_temp_dec_ten ):11'd0;  
assign vcount_body_temp_dec_ten=lcd_request_body_temp_dec_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_body_temp_dec_ten ):11'd0;


assign hcount_body_temp_unit=lcd_request_body_temp_unit ? (hcount_r - H_SYNC - H_BACK - X_START_body_temp_unit ):11'd0;  
assign vcount_body_temp_unit=lcd_request_body_temp_unit ? (vcount_r - V_SYNC - V_BACK - Y_START_body_temp_unit ):11'd0;

assign hcount_heart_rate=lcd_request_heart_rate ? (hcount_r - H_SYNC - H_BACK - X_START_heart_rate ):11'd0;  
assign vcount_heart_rate=lcd_request_heart_rate ? (vcount_r - V_SYNC - V_BACK - Y_START_heart_rate ):11'd0;

assign hcount_heart_rate_one=lcd_request_heart_rate_one ? (hcount_r - H_SYNC - H_BACK - X_START_heart_rate_one ):11'd0;  
assign vcount_heart_rate_one=lcd_request_heart_rate_one ? (vcount_r - V_SYNC - V_BACK - Y_START_heart_rate_one ):11'd0;

assign hcount_heart_rate_ten=lcd_request_heart_rate_ten ? (hcount_r - H_SYNC - H_BACK - X_START_heart_rate_ten ):11'd0;  
assign vcount_heart_rate_ten=lcd_request_heart_rate_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_heart_rate_ten ):11'd0;

assign hcount_heart_rate_hun=lcd_request_heart_rate_hun ? (hcount_r - H_SYNC - H_BACK - X_START_heart_rate_hun ):11'd0;  
assign vcount_heart_rate_hun=lcd_request_heart_rate_hun ? (vcount_r - V_SYNC - V_BACK - Y_START_heart_rate_hun ):11'd0;

assign hcount_h2=lcd_request_h2 ? (hcount_r - H_SYNC - H_BACK - X_START_h2 ):11'd0;  
assign vcount_h2=lcd_request_h2 ? (vcount_r - V_SYNC - V_BACK - Y_START_h2 ):11'd0;

assign hcount_h2_ten=lcd_request_h2_ten ? (hcount_r - H_SYNC - H_BACK - X_START_h2_ten ):11'd0;  
assign vcount_h2_ten=lcd_request_h2_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_h2_ten ):11'd0;

assign hcount_h2_one=lcd_request_h2_one ? (hcount_r - H_SYNC - H_BACK - X_START_h2_one ):11'd0;  
assign vcount_h2_one=lcd_request_h2_one ? (vcount_r - V_SYNC - V_BACK - Y_START_h2_one ):11'd0;

assign hcount_liquefied=lcd_request_liquefied ? (hcount_r - H_SYNC - H_BACK - X_START_liquefied ):11'd0;  
assign vcount_liquefied=lcd_request_liquefied ? (vcount_r - V_SYNC - V_BACK - Y_START_liquefied ):11'd0;

assign hcount_liquefied_ten=lcd_request_liquefied_ten ? (hcount_r - H_SYNC - H_BACK - X_START_liquefied_ten ):11'd0;  
assign vcount_liquefied_ten=lcd_request_liquefied_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_liquefied_ten ):11'd0;

assign hcount_liquefied_one=lcd_request_liquefied_one ? (hcount_r - H_SYNC - H_BACK - X_START_liquefied_one ):11'd0;  
assign vcount_liquefied_one=lcd_request_liquefied_one ? (vcount_r - V_SYNC - V_BACK - Y_START_liquefied_one ):11'd0;

assign hcount_natural=lcd_request_natural ? (hcount_r - H_SYNC - H_BACK - X_START_natural ):11'd0;  
assign vcount_natural=lcd_request_natural ? (vcount_r - V_SYNC - V_BACK - Y_START_natural ):11'd0;

assign hcount_harmful=lcd_request_harmful ? (hcount_r - H_SYNC - H_BACK - X_START_harmful ):11'd0;  
assign vcount_harmful=lcd_request_harmful ? (vcount_r - V_SYNC - V_BACK - Y_START_harmful ):11'd0;

assign hcount_oxy=lcd_request_oxy ? (hcount_r - H_SYNC - H_BACK - X_START_oxy ):11'd0;  
assign vcount_oxy=lcd_request_oxy ? (vcount_r - V_SYNC - V_BACK - Y_START_oxy ):11'd0;

assign hcount_temp=lcd_request_temp ? (hcount_r - H_SYNC - H_BACK - X_START_temp ):11'd0;  
assign vcount_temp=lcd_request_temp ? (vcount_r - V_SYNC - V_BACK - Y_START_temp ):11'd0;

assign hcount_hum=lcd_request_hum ? (hcount_r - H_SYNC - H_BACK - X_START_hum ):11'd0;  
assign vcount_hum=lcd_request_hum ? (vcount_r - V_SYNC - V_BACK - Y_START_hum ):11'd0;

assign hcount_natural_ten=lcd_request_natural_ten ? (hcount_r - H_SYNC - H_BACK - X_START_natural_ten ):11'd0;  
assign vcount_natural_ten=lcd_request_natural_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_natural_ten ):11'd0;

assign hcount_natural_one=lcd_request_natural_one ? (hcount_r - H_SYNC - H_BACK - X_START_natural_one ):11'd0;  
assign vcount_natural_one=lcd_request_natural_one ? (vcount_r - V_SYNC - V_BACK - Y_START_natural_one ):11'd0;

assign hcount_harmful_ten=lcd_request_harmful_ten ? (hcount_r - H_SYNC - H_BACK - X_START_harmful_ten ):11'd0;  
assign vcount_harmful_ten=lcd_request_harmful_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_harmful_ten ):11'd0;

assign hcount_harmful_one=lcd_request_harmful_one ? (hcount_r - H_SYNC - H_BACK - X_START_harmful_one ):11'd0;  
assign vcount_harmful_one=lcd_request_harmful_one ? (vcount_r - V_SYNC - V_BACK - Y_START_harmful_one ):11'd0;

assign hcount_oxy_ten=lcd_request_oxy_ten ? (hcount_r - H_SYNC - H_BACK - X_START_oxy_ten ):11'd0;  
assign vcount_oxy_ten=lcd_request_oxy_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_oxy_ten ):11'd0;

assign hcount_oxy_one=lcd_request_oxy_one ? (hcount_r - H_SYNC - H_BACK - X_START_oxy_one ):11'd0;  
assign vcount_oxy_one=lcd_request_oxy_one ? (vcount_r - V_SYNC - V_BACK - Y_START_oxy_one ):11'd0;

assign hcount_temp_ten=lcd_request_temp_ten ? (hcount_r - H_SYNC - H_BACK - X_START_temp_ten ):11'd0;  
assign vcount_temp_ten=lcd_request_temp_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_temp_ten ):11'd0;

assign hcount_temp_one=lcd_request_temp_one ? (hcount_r - H_SYNC - H_BACK - X_START_temp_one ):11'd0;  
assign vcount_temp_one=lcd_request_temp_one ? (vcount_r - V_SYNC - V_BACK - Y_START_temp_one ):11'd0;

assign hcount_hum_ten=lcd_request_hum_ten ? (hcount_r - H_SYNC - H_BACK - X_START_hum_ten ):11'd0;  
assign vcount_hum_ten=lcd_request_hum_ten ? (vcount_r - V_SYNC - V_BACK - Y_START_hum_ten ):11'd0;

assign hcount_hum_one=lcd_request_hum_one ? (hcount_r - H_SYNC - H_BACK - X_START_hum_one ):11'd0;  
assign vcount_hum_one=lcd_request_hum_one ? (vcount_r - V_SYNC - V_BACK - Y_START_hum_one ):11'd0;

assign hcount_ppm=lcd_request_ppm ? (hcount_r - H_SYNC - H_BACK - X_START_ppm ):11'd0;  
assign vcount_ppm=lcd_request_ppm ? (vcount_r - V_SYNC - V_BACK - Y_START_ppm ):11'd0;

assign hcount_rh=lcd_request_rh ? (hcount_r - H_SYNC - H_BACK - X_START_rh ):11'd0;  
assign vcount_rh=lcd_request_rh ? (vcount_r - V_SYNC - V_BACK - Y_START_rh ):11'd0;

assign hcount_temp_unit=lcd_request_temp_unit ? (hcount_r - H_SYNC - H_BACK - X_START_temp_unit ):11'd0;  
assign vcount_temp_unit=lcd_request_temp_unit ? (vcount_r - V_SYNC - V_BACK - Y_START_temp_unit ):11'd0;
	
endmodule
