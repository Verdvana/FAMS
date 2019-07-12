module FAMS
(
	//global clock 50MHz
	input				clk_50m,			//50MHz
	input				rst_n,			//global reset
	
	//sdram control
	output				sdram_clk,		//sdram clock
	output				sdram_cke,		//sdram clock enable
	output				sdram_cs_n,		//sdram chip select
	output				sdram_we_n,		//sdram write enable
	output				sdram_cas_n,	//sdram column address strobe
	output				sdram_ras_n,	//sdram row address strobe
	output	 [1:0]	sdram_dqm,		//sdram data enable
	output	 [1:0]	sdram_ba,		//sdram bank address
	output	 [12:0]	sdram_addr,		//sdram address
	inout		 [15:0]	sdram_dq,		//sdram data
	
	
	//rgblcd interafce
	output				lcd_clk,		//lcd pixel clock			
	output				lcd_hsync,		//lcd horizontal sync 
	output				lcd_vsync,		//lcd vertical sync
	output				lcd_de,		//lcd data enable
	output		[7:0]	lcd_red,		//lcd red data
	output		[7:0]	lcd_green,		//lcd green data
	output		[7:0]	lcd_blue,		//lcd blue data
	output				lcd_pwm,		//lcd bright pwm control
	output				lcd_reset,		//lcd disp reset
	output				lcd_blank_n,
	
	

	input					key_led,
	input					key_sensor,
	input					key_eeprom,
	output				led_p,
	output				bz,
	output				sensor_en,
	
	//key
	input  	[1:0]		key_data,
	//cmos interface
	output				cmos_sclk,		//cmos i2c clock
	inout				cmos_sdat,		//cmos i2c data
	input				cmos_pclk,		//cmos pxiel clock
	output				cmos_xclk,		//cmos externl clock
	input				cmos_vsync,		//cmos vsync
	input				cmos_href,		//cmos hsync refrence
	input		[7:0]	cmos_data,		//cmos data
	output				cmos_ctl0,		//Unused
	output				cmos_ctl1,		//Sensor exposure
	output				cmos_ctl2, 		//Sensor Standby
	
	output				scl,
	inout					sda,
	input					int,
	
					input                adc_dout,     //adc输出（串行）
					output               adc_din,      //adc输入
					output               adc_sclk,     //adc时钟
					output               adc_cs_n,     //adc片选信号
					
					output					menb,
					
					output					o2_scl,
					inout						o2_sda,
					
					output					eeprom_scl,
					inout			   		eeprom_sda,
					
					
					inout						dht11,
					
					input				gy_mcu90640_txd,
					output			hc06_rxd
					
					

);




//cmos control port
assign	cmos_ctl0 = 1'bz;
assign	cmos_ctl1 = 1'b0;	//Sensor exposure
assign	cmos_ctl2 = 1'b0;   //Sensor Standby


//---------------------------------------------
//system global clock control
wire	sys_rst_n;		//global reset
wire	clk_ref;		//sdram ctrl clock
wire	clk_refout;		//sdram clock output
wire	clk_vga;		//vga clock
wire	clk_cmos;		//24MHz cmos clock
wire	clk_adc;		//4MHz ADC clock
system_ctrl_pll	u_system_ctrl_pll
(
	.clk				(clk_50m),			//global clock
	.rst_n				(rst_n),		//external reset
	
	.sys_rst_n			(sys_rst_n),	//global reset
	.clk_c0				(clk_ref),		//100MHz 
	.clk_c1				(clk_refout),	//100MHz -90deg
	.clk_c2				(clk_vga),		//30MHz
	.clk_c3				(clk_cmos),		//24MHz
	.clk_c4				(clk_adc)		//
);

assign	cmos_xclk = clk_cmos;
assign	sdram_clk=clk_refout;

//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
//cmos video image capture
wire			cmos_init_done;
wire			cmos_zoom_vsync;	//cmos frame data vsync valid signal
wire			cmos_zoom_href;		//cmos frame data href vaild  signal
wire	[7:0]	cmos_zoom_Gray;		//cmos frame data output: 8 Bit raw data	
wire	[7:0]	cmos_fps_rate;		//cmos image output rate

SingleSensorDriver_MT9V034 
#(
	.CLOCK_MAIN		(100_000000),
	.CLOCK_I2C		(100_000)
 )
u_SingleSensorDriver_MT9V034
(
	//global clock 
	.clk_ref	(clk_ref),
	.clk_cmos	(clk_cmos),
	.rst_n		(sys_rst_n),
	//cmos interface
	.cmos_sclk  (cmos_sclk),	//cmos i2c clock
	.cmos_sdat	(cmos_sdat),	//cmos i2c data 
	.cmos_pclk  (cmos_pclk),	//cmos pxiel clock
	.cmos_xclk  (cmos_xclk),	//cmos extern1 clock 
	.cmos_vsync (cmos_vsync), 	//cmos vsync 
	.cmos_href	(cmos_href),	//cmos hsync refrence 
	.cmos_data  (cmos_data),	//cmos data 
	
	//sensor data capture output 
	.cmos_zoom_vsync		(cmos_zoom_vsync), //cmos frame data vsync valid signal
	.cmos_zoom_href		(cmos_zoom_href),	 //cmos frame data href valid signal
	.cmos_zoom_Gray		(cmos_zoom_Gray),	 //cmos frame data output: 8 Bit raw data 
	.cmos_fps_rate 		(cmos_fps_rate),	 //cmos image output rate 
	
	//User Interface	
	.i2c_config_done		(cmos_init_done) 
);
//----------------------------------------------------
//Video Image processor module.
//Image data prepred to be processd
wire	  per_frame_vsync =  cmos_zoom_vsync;
wire    per_frame_href 	=  cmos_zoom_href;
wire    per_frame_clken =  cmos_zoom_href;
wire  [7:0] per_img_G	=  cmos_zoom_Gray;

wire 	post_frame_vsync;
wire    post_frame_href;
wire	post_frame_clken;
wire 	[7:0] post_img_G;
Video_Image_Processor u_Video_Image_Processor
(
	.clk    	(cmos_pclk), 	//24MHz CMOS Driver clock input
	.rst_n  	(sys_rst_n),    //global rst_n
	//Image data prepared to be processed
	.per_frame_vsync	(per_frame_vsync), //cmos frame data vsync valid signal
	.per_frame_href		(per_frame_href),  //cmos frame data href vaild  signal
	.per_frame_clken    (per_frame_clken),  //cmos frame data output: 8 Bit raw data
	.per_img_G          (per_img_G),			//cmos frame data output/capture enable clock),
	
	//Image data has been processd
	.post_frame_vsync	(post_frame_vsync), //Processed Image data vsync valid signal 
	.post_frame_href	(post_frame_href),  //Processed Image data href valid signal 
	.post_frame_clken   (post_frame_clken), //Processed Image data output enable clock 
	.post_img_G 		(post_img_G)        //Processed Image Gray output    		
);


//--------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
//Sdram_Control_2Port module 	
//sdram write port
wire			clk_write	=	cmos_pclk;	//Change with input signal											
wire	[7:0]	sys_data_in = 	post_img_G;
wire			sys_we 		= 	post_frame_clken;
//sdram read port
wire			clk_read	=	clk_vga;	//Change with vga timing	
wire	[7:0]	sys_data_out1;
wire 	[7:0]	sys_data_out2;
wire			sys_rd1;
wire			sys_rd2;
wire			sdram_init_done = cmos_init_done;			//sdram init done

Sdram_Control_2Port Sdram_Control_2Port(
		//	HOST Side
		.CTRL_CLK(clk_ref),	//输入参考时钟，默认100M，如果为其他频率，请修改sdram_pll核设置
		.RESET_N(sys_rst_n),	//复位输入，低电平复位

		//	FIFO Write Side 1
		.WR1_DATA(sys_data_in),			//写入端口1的数据输入端，16bit
		.WR1(sys_we),					//写输入请求信号
		.WR1_MIN_ADDR(0),			//写入端口1的写起始地址
		.WR1_MAX_ADDR(22'd640 * 22'd480 * 2'd2),		//写入端口1的写入最大地址
		.WR1_LENGTH(128),			//一次性写入数据长度
		.WR1_LOAD(~sys_rst_n),			//写入端口1清零请求，高电平清零写入地址和fifo
		.WR1_CLK(clk_write),				//写入端口1 fifo写入时钟
		.WR1_FULL(),			//写入端口1 fifo写满信号
		.WR1_USE(),				//写入端口1 fifo已经写入的数据长度
		
		//	FIFO Read Side 1
		.RD1_DATA(sys_data_out1),			//读出端口1的数据输出端，16bit
		.RD1(sys_rd1),					//读出端口1的读使能端，高电平读出
		.RD1_MIN_ADDR(0),			//读出端口1的读起始地址
		.RD1_MAX_ADDR(22'd640 * 22'd480),		//读出端口1的读出最大地址
		.RD1_LENGTH(128),			//一次性读出数据长度
		.RD1_LOAD(~sys_rst_n),			//读出端口1 清零请求，高电平清零读出地址和fifo
		.RD1_CLK(clk_vga),				//读出端口1 fifo读取时钟
		.RD1_EMPTY(),			//读出端口1 fifo读空信号
		.RD1_USE(),				//读出端口1 fifo已经还可以读取的数据长度

	   
		//	FIFO Read Side 2
		.RD2_DATA(sys_data_out2),			//读出端口1的数据输出端，16bit
		.RD2(sys_rd1),			 		//读出端口1的读使能端，高电平读出
		.RD2_MIN_ADDR(22'd640 * 22'd480),			//读出端口1的读起始地址
		.RD2_MAX_ADDR(22'd640 * 22'd480 * 2'd2),		//读出端口1的读出最大地址
		.RD2_LENGTH(128),			//一次性读出数据长度
		.RD2_LOAD(~sys_rst_n),			//读出端口1 清零请求，高电平清零读出地址和fifo
		.RD2_CLK(clk_vga),				//读出端口1 fifo读取时钟
		.RD2_EMPTY(),			//读出端口1 fifo读空信号
		.RD2_USE(),				//读出端口1 fifo已经还可以读取的数据长度
		
		//	SDRAM Side
		.SA(sdram_addr),		//SDRAM 地址线，
		.BA(sdram_ba),		//SDRAM bank地址线
		.CS_N(sdram_cs_n),		//SDRAM 片选信号
		.CKE(sdram_cke),		//SDRAM 时钟使能
		.RAS_N(sdram_ras_n),	//SDRAM 行选中信号
		.CAS_N(sdram_cas_n),	//SDRAM 列选中信号
		.WE_N(sdram_we_n),		//SDRAM 写请求信号
		.DQ(sdram_dq),		//SDRAM 双向数据总线
		.DQM(sdram_dqm)		//SDRAM 数据总线高低字节屏蔽信号
	);
	
/*	
wire			key_flag;
wire	[1:0]	key_value;
key_counter_scan
#(
	.KEY_WIDTH	(2)
)
u_key_counter_scan
(
	//global
	.clk					(clk_50m),
	.rst_n				(sys_rst_n),
	
	//key interface
	.key_data			(key_data),		
	
	//user interface
	.key_flag			(key_flag),
	.key_value			(key_value)	
);
*/

/*
wire [7:0]	Threshold;  
Threshold_Adj u_Threshold_Adj
(
	.clk					(clk_50m),
	.rst_n 				(sys_rst_n),
	
	.key_flag			(key_flag),
	.key_value			(key_value),
	
	.Threshold			(Threshold)
);
*/

//-------------------------------------
//LCD driver timing
wire	[10:0]	lcd_xpos;		//lcd horizontal coordinate
wire	[9:0]	lcd_ypos;		//lcd vertical coordinate
wire	[23:0]	lcd_data_in;	//lcd data input
wire  [7:0]		sys_data_out;
wire 	[7:0]		abs_sys_out;
assign abs_sys_out = sys_data_out1 > sys_data_out2 ? sys_data_out1 - sys_data_out2 : sys_data_out2 - sys_data_out1;
assign sys_data_out = abs_sys_out > 20 ? 255 : 0 ;

wire	lcd_clken;
wire	[7:0]	lcd_data;
Image_Handler 
#(
	.IMG_HDISP		(640),
	.IMG_VDISP		(480)
)
u_Image_Handler
(
	//global clock 
	.clk		(clk_vga),
	.rst_n		(sys_rst_n),
	
	//Image data prepared to be processed 
	.per_frame_href	(sys_rd1),
	.per_img_Gray 		(sys_data_out),
	  //Image data has been processed 
	.post_frame_href  (lcd_clken),
	.post_img_Gray		(lcd_data)
);

mark mark_inst(
	.clk(clk_vga),
	.rst_n(sys_rst_n),
	.lcd_xpos(lcd_xpos),
	.lcd_ypos(lcd_ypos),
	.sys_data_out1(sys_data_out1),
	.sys_data_out2(),
	.lcd_data(lcd_data),
	.lcd_clken(lcd_clken),

	.lcd_data_in(lcd_data_in)
);

//------------------------------------------------------------------------

wire [3:0] body_temp_int_one;
wire [3:0] body_temp_int_ten;
wire [3:0] body_temp_dec_one;
wire [3:0] body_temp_dec_ten;
wire [7:0] body_temp_int;
wire [7:0] body_temp_dec;
Body_temp_Process Body_temp_Process(
	.body_temp_data_in(dout_iic[302:288]),
					
	.body_temp_int_one(body_temp_int_one),
	.body_temp_int_ten(body_temp_int_ten),
	.body_temp_dec_one(body_temp_dec_one),
	.body_temp_dec_ten(body_temp_dec_ten),
	.body_temp_int(body_temp_int),
	.body_temp_dec(body_temp_dec)

);


wire 			uart_done;
wire [7:0] 	uart_data;
uart_rx uart_rx(
	.clk_50m(clk_50m),                  //系统时钟
	.rst_n(sys_rst_n),                //系统复位，低电平有效
    
	.uart_rxd(gy_mcu90640_txd),                 //UART接收端口
	.uart_done(uart_done),                //接收一帧数据完成标志信号
	.uart_data(uart_data) 
);

wire			en_data;
wire			clk_out;

wire [9:0]	data_cnt;
wire [15:0]	data_out;
Process Process(
	.clk_50m(clk_50m),
	.rst_n(sys_rst_n),
				
	.data_in(uart_data),
	.uart_done(uart_done),
	
	.en_data(en_data),
	.clk_out(clk_out),
	
	.Threshold(),	
	.data_cnt(data_cnt),
	.data_out(data_out)
);

wire [15:0] q;
wire [23:0] gymcu_data;
RAM	RAM_inst (
	.data ( data_out ),
	.wraddress ( data_cnt ),
	.wrclock ( clk_out ),
	.wren ( en_data ),
	
	.rdaddress ( rdaddress_2 ),
	.rdclock ( clk_vga ),
	.rden ( sys_rd2 ), 
	.q ( q )
	);

assign gymcu_data = {q[15:11],3'b000,q[10:5],2'b00,q[4:0],3'b000};
wire [7:0] hcount_2;
wire [6:0] vcount_2;
wire [11:0] rdaddress_2;
assign rdaddress_2 = (32-hcount_2[7:2]) + vcount_2[6:2]*32;

//---------------------------------------------------------------------------




wire [10:0] hcount_theme;
wire [10:0] vcount_theme;
wire [10:0] hcount_veneno;
wire [10:0] vcount_veneno;
wire [10:0] hcount_body_temp;
wire [10:0] vcount_body_temp;
wire [10:0] hcount_heart_rate;
wire [10:0] vcount_heart_rate;
wire [10:0] hcount_h2;
wire [10:0] vcount_h2;
wire [10:0] hcount_liquefied;
wire [10:0] vcount_liquefied;
wire [10:0] hcount_natural;
wire [10:0] vcount_natural;
wire [10:0] hcount_harmful;
wire [10:0] vcount_harmful;
wire [10:0] hcount_oxy;
wire [10:0] vcount_oxy;
wire [10:0] hcount_temp;
wire [10:0] vcount_temp;
wire [10:0] hcount_hum;
wire [10:0] vcount_hum;
wire [10:0] hcount_body_temp_dp;
wire [10:0] vcount_body_temp_dp;
wire [10:0] hcount_body_temp_unit;
wire [10:0] vcount_body_temp_unit;
wire [10:0] hcount_ppm;
wire [10:0] vcount_ppm;
wire [10:0] hcount_rh;
wire [10:0] vcount_rh;
wire [10:0] hcount_temp_unit;
wire [10:0] vcount_temp_unit;
wire [10:0] hcount_body_temp_int_ten;
wire [10:0] vcount_body_temp_int_ten;
wire [10:0] hcount_body_temp_int_one;
wire [10:0] vcount_body_temp_int_one;
wire [10:0] hcount_body_temp_dec_ten;
wire [10:0] vcount_body_temp_dec_ten;
wire [10:0] hcount_heart_rate_hun;
wire [10:0] vcount_heart_rate_hun;
wire [10:0] hcount_heart_rate_ten;
wire [10:0] vcount_heart_rate_ten;
wire [10:0] hcount_heart_rate_one;
wire [10:0] vcount_heart_rate_one;
wire [10:0] hcount_h2_ten;
wire [10:0] vcount_h2_ten;
wire [10:0] hcount_h2_one;
wire [10:0] vcount_h2_one;
wire [10:0] hcount_liquefied_ten;
wire [10:0] vcount_liquefied_ten;
wire [10:0] hcount_liquefied_one;
wire [10:0] vcount_liquefied_one;
wire [10:0] hcount_natural_ten;
wire [10:0] vcount_natural_ten;
wire [10:0] hcount_natural_one;
wire [10:0] vcount_natural_one;
wire [10:0] hcount_harmful_ten;
wire [10:0] vcount_harmful_ten;
wire [10:0] hcount_harmful_one;
wire [10:0] vcount_harmful_one;
wire [10:0] hcount_oxy_ten;
wire [10:0] vcount_oxy_ten;
wire [10:0] hcount_oxy_one;
wire [10:0] vcount_oxy_one;
wire [10:0] hcount_temp_ten;
wire [10:0] vcount_temp_ten;
wire [10:0] hcount_temp_one;
wire [10:0] vcount_temp_one;
wire [10:0] hcount_hum_ten;
wire [10:0] vcount_hum_ten;
wire [10:0] hcount_hum_one;
wire [10:0] vcount_hum_one;




wire lcd_request_theme;
wire lcd_request_veneno;

wire lcd_request_body_temp;
wire lcd_request_heart_rate;
wire lcd_request_h2;
wire lcd_request_liquefied;	
wire lcd_request_natural;
wire lcd_request_harmful;	
wire lcd_request_oxy;	
wire lcd_request_temp;	
wire lcd_request_hum;	

wire lcd_request_body_temp_dp;
wire lcd_request_body_temp_unit;
wire lcd_request_ppm;	
wire lcd_request_rh;
wire lcd_request_temp_unit;	

wire lcd_request_body_temp_int_ten;
wire lcd_request_body_temp_int_one;
wire lcd_request_body_temp_dec_ten;
wire lcd_request_heart_rate_hun;
wire lcd_request_heart_rate_ten;
wire lcd_request_heart_rate_one;
wire lcd_request_h2_ten;
wire lcd_request_h2_one;
wire lcd_request_liquefied_ten;
wire lcd_request_liquefied_one;
wire lcd_request_natural_ten;
wire lcd_request_natural_one;
wire lcd_request_harmful_ten;
wire lcd_request_harmful_one;
wire lcd_request_oxy_ten;
wire lcd_request_oxy_one;
wire lcd_request_temp_ten;
wire lcd_request_temp_one;
wire lcd_request_hum_ten;
wire lcd_request_hum_one;

LCD_Driver LCD_Driver(
		.clk(clk_vga),    			//33.3M
		.rst_n(sys_rst_n),
		.data_in(lcd_driver_data_in),   		//待显示数据
							
		.hcount_1(lcd_xpos),			//x坐标
		.vcount_1(lcd_ypos),			//y坐标
		.hcount_2(hcount_2),			//x坐标
		.vcount_2(vcount_2),			//y坐标
		.hcount_theme(hcount_theme),			//x坐标
		.vcount_theme(vcount_theme),			//y坐标
		.hcount_veneno(hcount_veneno),			//x坐标
		.vcount_veneno(vcount_veneno),			//y坐标
		.hcount_body_temp(hcount_body_temp),			//x坐标
		.vcount_body_temp(vcount_body_temp),			//y坐标
		.hcount_body_temp_int_ten(hcount_body_temp_int_ten),			//x坐标
		.vcount_body_temp_int_ten(vcount_body_temp_int_ten),			//y坐标
		.hcount_body_temp_int_one(hcount_body_temp_int_one),			//x坐标
		.vcount_body_temp_int_one(vcount_body_temp_int_one),			//y坐标
		.hcount_body_temp_dp(hcount_body_temp_dp),			//x坐标
		.vcount_body_temp_dp(vcount_body_temp_dp),			//y坐标
		.hcount_body_temp_dec_ten(hcount_body_temp_dec_ten),			//x坐标
		.vcount_body_temp_dec_ten(vcount_body_temp_dec_ten),			//y坐标
		.hcount_body_temp_unit(hcount_body_temp_unit),			//x坐标
		.vcount_body_temp_unit(vcount_body_temp_unit),			//y坐标
		.hcount_heart_rate(hcount_heart_rate),			//x坐标
		.vcount_heart_rate(vcount_heart_rate),			//y坐标
		.hcount_heart_rate_hun(hcount_heart_rate_hun),			//x坐标
		.vcount_heart_rate_hun(vcount_heart_rate_hun),			//y坐标
		.hcount_heart_rate_ten(hcount_heart_rate_ten),			//x坐标
		.vcount_heart_rate_ten(vcount_heart_rate_ten),			//y坐标
		.hcount_heart_rate_one(hcount_heart_rate_one),			//x坐标
		.vcount_heart_rate_one(vcount_heart_rate_one),			//y坐标
		.hcount_h2(hcount_h2),			//x坐标
		.vcount_h2(vcount_h2),			//y坐标
		.hcount_h2_ten(hcount_h2_ten),			//x坐标
		.vcount_h2_ten(vcount_h2_ten),			//y坐标
		.hcount_h2_one(hcount_h2_one),			//x坐标
		.vcount_h2_one(vcount_h2_one),			//y坐标
		.hcount_liquefied(hcount_liquefied),			//x坐标
		.vcount_liquefied(vcount_liquefied),			//y坐标
		.hcount_liquefied_ten(hcount_liquefied_ten),			//x坐标
		.vcount_liquefied_ten(vcount_liquefied_ten),			//y坐标
		.hcount_liquefied_one(hcount_liquefied_one),			//x坐标
		.vcount_liquefied_one(vcount_liquefied_one),			//y坐标
		.hcount_natural(hcount_natural),			//x坐标
		.vcount_natural(vcount_natural),			//y坐标
		.hcount_harmful(hcount_harmful),			//x坐标
		.vcount_harmful(vcount_harmful),			//y坐标
		.hcount_oxy(hcount_oxy),			//x坐标
		.vcount_oxy(vcount_oxy),			//y坐标
		.hcount_temp(hcount_temp),			//x坐标
		.vcount_temp(vcount_temp),			//y坐标
		.hcount_hum(hcount_hum),			//x坐标
		.vcount_hum(vcount_hum),			//y坐标
		.hcount_natural_ten(hcount_natural_ten	),	
		.vcount_natural_ten(vcount_natural_ten	),	
		.hcount_natural_one(hcount_natural_one	),	
		.vcount_natural_one(vcount_natural_one	),	
		.hcount_harmful_ten(hcount_harmful_ten	),	
		.vcount_harmful_ten(vcount_harmful_ten	),	
		.hcount_harmful_one(hcount_harmful_one	),	
		.vcount_harmful_one(vcount_harmful_one	),	
		.hcount_oxy_ten    (hcount_oxy_ten		),		
		.vcount_oxy_ten    (vcount_oxy_ten		),		
		.hcount_oxy_one    (hcount_oxy_one		),		
		.vcount_oxy_one    (vcount_oxy_one		),		
		.hcount_temp_ten   (hcount_temp_ten		),		
		.vcount_temp_ten   (vcount_temp_ten		),		
		.hcount_temp_one   (hcount_temp_one		),		
		.vcount_temp_one   (vcount_temp_one		),		
		.hcount_hum_ten    (hcount_hum_ten 		),		
		.vcount_hum_ten    (vcount_hum_ten 		),		
		.hcount_hum_one    (hcount_hum_one 		),		
		.vcount_hum_one    (vcount_hum_one 		),
		.hcount_ppm    (hcount_ppm 		),		
		.vcount_ppm    (vcount_ppm 		),		
		.hcount_rh    (hcount_rh 		),		
		.vcount_rh    (vcount_rh 		),
		.hcount_temp_unit    (hcount_temp_unit 		),		
		.vcount_temp_unit    (vcount_temp_unit 		),
		
		
		
		.lcd_request_1(sys_rd1),	//数据请求信号
		.lcd_request_2(sys_rd2),	//数据请求信号
		.lcd_request_theme(lcd_request_theme),	//数据请求信号
		.lcd_request_veneno(lcd_request_veneno),	//数据请求信号
		.lcd_request_body_temp(lcd_request_body_temp),	//数据请求信号	
		.lcd_request_body_temp_int_ten(lcd_request_body_temp_int_ten),	//数据请求信号	
		.lcd_request_body_temp_int_one(lcd_request_body_temp_int_one),	//数据请求信号	
		.lcd_request_body_temp_dp(lcd_request_body_temp_dp),	//数据请求信号	
		.lcd_request_body_temp_dec_ten(lcd_request_body_temp_dec_ten),	//数据请求信号	
		.lcd_request_body_temp_unit(lcd_request_body_temp_unit),	//数据请求信号	
		.lcd_request_heart_rate(lcd_request_heart_rate),	//数据请求信号	
		.lcd_request_heart_rate_hun(lcd_request_heart_rate_hun),	//数据请求信号	
		.lcd_request_heart_rate_ten(lcd_request_heart_rate_ten),	//数据请求信号	
		.lcd_request_heart_rate_one(lcd_request_heart_rate_one),	//数据请求信号	
		.lcd_request_h2(lcd_request_h2),	//数据请求信号	
		.lcd_request_h2_ten(lcd_request_h2_ten),	//数据请求信号	
		.lcd_request_h2_one(lcd_request_h2_one),	//数据请求信号	
		.lcd_request_liquefied(lcd_request_liquefied),	//数据请求信号
		.lcd_request_liquefied_ten(lcd_request_liquefied_ten),	//数据请求信号	
		.lcd_request_liquefied_one(lcd_request_liquefied_one),	//数据请求信号	
		.lcd_request_natural(lcd_request_natural),	//数据请求信号
		.lcd_request_harmful(lcd_request_harmful),	//数据请求信号
		.lcd_request_oxy(lcd_request_oxy),	//数据请求信号
		.lcd_request_temp(lcd_request_temp),	//数据请求信号
		.lcd_request_hum(lcd_request_hum),	//数据请求信号
		.lcd_request_natural_ten(lcd_request_natural_ten),	//数据请
		.lcd_request_natural_one(lcd_request_natural_one),	//数据请
		.lcd_request_harmful_ten(lcd_request_harmful_ten),	//数据请
		.lcd_request_harmful_one(lcd_request_harmful_one),	//数据请
		.lcd_request_oxy_ten    (lcd_request_oxy_ten    ),	//数据请求信号	
		.lcd_request_oxy_one    (lcd_request_oxy_one    ),	//数据请求信号	
		.lcd_request_temp_ten   (lcd_request_temp_ten   ),	//数据请求
		.lcd_request_temp_one   (lcd_request_temp_one   ),	//数据请求
		.lcd_request_hum_ten    (lcd_request_hum_ten    ),	//数据请求信号	
		.lcd_request_hum_one    (lcd_request_hum_one    ),	//数据请求信号
	   .lcd_request_ppm    (lcd_request_ppm    ),	//数据请求信号
      .lcd_request_rh    (lcd_request_rh    ),	//数据请求信号		
	   .lcd_request_temp_unit    (lcd_request_temp_unit    ),	//数据请求信号		
		
		
		
		.lcd_clk(lcd_clk),			//驱动时钟
		.lcd_de(lcd_de),			//使能
		.lcd_blank_n(lcd_blank_n),
		.lcd_hsync(lcd_hsync),
		.lcd_vsync(lcd_vsync),	
		.lcd_rgb({lcd_red, lcd_green ,lcd_blue}),   //TFT数据输出
		.lcd_pwm()
);


wire [23:0]	lcd_driver_data_in;

LCD_Display LCD_Display_inst(
	.clk_vga(clk_vga),
	.rst_n(rst_n),
	

		.hcount_theme(hcount_theme),			//x坐标
		.vcount_theme(vcount_theme),			//y坐标
		.hcount_veneno(hcount_veneno),			//x坐标
		.vcount_veneno(vcount_veneno),			//y坐标
		.hcount_body_temp(hcount_body_temp),			//x坐标
		.vcount_body_temp(vcount_body_temp),			//y坐标
		.hcount_body_temp_int_ten(hcount_body_temp_int_ten),			//x坐标
		.vcount_body_temp_int_ten(vcount_body_temp_int_ten),			//y坐标
		.hcount_body_temp_int_one(hcount_body_temp_int_one),			//x坐标
		.vcount_body_temp_int_one(vcount_body_temp_int_one),			//y坐标
		.hcount_body_temp_dp(hcount_body_temp_dp),			//x坐标
		.vcount_body_temp_dp(vcount_body_temp_dp),			//y坐标
		.hcount_body_temp_dec_ten(hcount_body_temp_dec_ten),			//x坐标
		.vcount_body_temp_dec_ten(vcount_body_temp_dec_ten),			//y坐标
		.hcount_body_temp_unit(hcount_body_temp_unit),			//x坐标
		.vcount_body_temp_unit(vcount_body_temp_unit),			//y坐标
		.hcount_heart_rate(hcount_heart_rate),			//x坐标
		.vcount_heart_rate(vcount_heart_rate),			//y坐标
		.hcount_heart_rate_hun(hcount_heart_rate_hun),			//x坐标
		.vcount_heart_rate_hun(vcount_heart_rate_hun),			//y坐标
		.hcount_heart_rate_ten(hcount_heart_rate_ten),			//x坐标
		.vcount_heart_rate_ten(vcount_heart_rate_ten),			//y坐标
		.hcount_heart_rate_one(hcount_heart_rate_one),			//x坐标
		.vcount_heart_rate_one(vcount_heart_rate_one),			//y坐标
		.hcount_h2(hcount_h2),			//x坐标
		.vcount_h2(vcount_h2),			//y坐标
		.hcount_h2_ten(hcount_h2_ten),			//x坐标
		.vcount_h2_ten(vcount_h2_ten),			//y坐标
		.hcount_h2_one(hcount_h2_one),			//x坐标
		.vcount_h2_one(vcount_h2_one),			//y坐标
		.hcount_liquefied(hcount_liquefied),			//x坐标
		.vcount_liquefied(vcount_liquefied),			//y坐标
		.hcount_liquefied_ten(hcount_liquefied_ten),			//x坐标
		.vcount_liquefied_ten(vcount_liquefied_ten),			//y坐标
		.hcount_liquefied_one(hcount_liquefied_one),			//x坐标
		.vcount_liquefied_one(vcount_liquefied_one),			//y坐标
		.hcount_natural(hcount_natural),			//x坐标
		.vcount_natural(vcount_natural),			//y坐标
		.hcount_harmful(hcount_harmful),			//x坐标
		.vcount_harmful(vcount_harmful),			//y坐标
		.hcount_oxy(hcount_oxy),			//x坐标
		.vcount_oxy(vcount_oxy),			//y坐标
		.hcount_temp(hcount_temp),			//x坐标
		.vcount_temp(vcount_temp),			//y坐标
		.hcount_hum(hcount_hum),			//x坐标
		.vcount_hum(vcount_hum),			//y坐标
		.hcount_natural_ten(hcount_natural_ten	),	
		.vcount_natural_ten(vcount_natural_ten	),	
		.hcount_natural_one(hcount_natural_one	),	
		.vcount_natural_one(vcount_natural_one	),	
		.hcount_harmful_ten(hcount_harmful_ten	),	
		.vcount_harmful_ten(vcount_harmful_ten	),	
		.hcount_harmful_one(hcount_harmful_one	),	
		.vcount_harmful_one(vcount_harmful_one	),	
		.hcount_oxy_ten    (hcount_oxy_ten		),		
		.vcount_oxy_ten    (vcount_oxy_ten		),		
		.hcount_oxy_one    (hcount_oxy_one		),		
		.vcount_oxy_one    (vcount_oxy_one		),		
		.hcount_temp_ten   (hcount_temp_ten		),		
		.vcount_temp_ten   (vcount_temp_ten		),		
		.hcount_temp_one   (hcount_temp_one		),		
		.vcount_temp_one   (vcount_temp_one		),		
		.hcount_hum_ten    (hcount_hum_ten 		),		
		.vcount_hum_ten    (vcount_hum_ten 		),		
		.hcount_hum_one    (hcount_hum_one 		),		
		.vcount_hum_one    (vcount_hum_one 		),
		.hcount_ppm    (hcount_ppm 		),		
		.vcount_ppm    (vcount_ppm 		),		
		.hcount_rh    (hcount_rh 		),		
		.vcount_rh    (vcount_rh 		),
		.hcount_temp_unit    (hcount_temp_unit 		),		
		.vcount_temp_unit    (vcount_temp_unit 		),
		
		
		
		.sys_rd1(sys_rd1),	//数据请求信号
		.sys_rd2(sys_rd2),	//数据请求信号
		.lcd_request_theme(lcd_request_theme),	//数据请求信号
		.lcd_request_veneno(lcd_request_veneno),	//数据请求信号
		.lcd_request_body_temp(lcd_request_body_temp),	//数据请求信号	
		.lcd_request_body_temp_int_ten(lcd_request_body_temp_int_ten),	//数据请求信号	
		.lcd_request_body_temp_int_one(lcd_request_body_temp_int_one),	//数据请求信号	
		.lcd_request_body_temp_dp(lcd_request_body_temp_dp),	//数据请求信号	
		.lcd_request_body_temp_dec_ten(lcd_request_body_temp_dec_ten),	//数据请求信号	
		.lcd_request_body_temp_unit(lcd_request_body_temp_unit),	//数据请求信号	
		.lcd_request_heart_rate(lcd_request_heart_rate),	//数据请求信号	
		.lcd_request_heart_rate_hun(lcd_request_heart_rate_hun),	//数据请求信号	
		.lcd_request_heart_rate_ten(lcd_request_heart_rate_ten),	//数据请求信号	
		.lcd_request_heart_rate_one(lcd_request_heart_rate_one),	//数据请求信号	
		.lcd_request_h2(lcd_request_h2),	//数据请求信号	
		.lcd_request_h2_ten(lcd_request_h2_ten),	//数据请求信号	
		.lcd_request_h2_one(lcd_request_h2_one),	//数据请求信号	
		.lcd_request_liquefied(lcd_request_liquefied),	//数据请求信号
		.lcd_request_liquefied_ten(lcd_request_liquefied_ten),	//数据请求信号	
		.lcd_request_liquefied_one(lcd_request_liquefied_one),	//数据请求信号	
		.lcd_request_natural(lcd_request_natural),	//数据请求信号
		.lcd_request_harmful(lcd_request_harmful),	//数据请求信号
		.lcd_request_oxy(lcd_request_oxy),	//数据请求信号
		.lcd_request_temp(lcd_request_temp),	//数据请求信号
		.lcd_request_hum(lcd_request_hum),	//数据请求信号
		.lcd_request_natural_ten(lcd_request_natural_ten),	//数据请
		.lcd_request_natural_one(lcd_request_natural_one),	//数据请
		.lcd_request_harmful_ten(lcd_request_harmful_ten),	//数据请
		.lcd_request_harmful_one(lcd_request_harmful_one),	//数据请
		.lcd_request_oxy_ten    (lcd_request_oxy_ten    ),	//数据请求信号	
		.lcd_request_oxy_one    (lcd_request_oxy_one    ),	//数据请求信号	
		.lcd_request_temp_ten   (lcd_request_temp_ten   ),	//数据请求
		.lcd_request_temp_one   (lcd_request_temp_one   ),	//数据请求
		.lcd_request_hum_ten    (lcd_request_hum_ten    ),	//数据请求信号	
		.lcd_request_hum_one    (lcd_request_hum_one    ),	//数据请求信号
	   .lcd_request_ppm    (lcd_request_ppm    ),	//数据请求信号
      .lcd_request_rh    (lcd_request_rh    ),	//数据请求信号		
	   .lcd_request_temp_unit    (lcd_request_temp_unit    ),	//数据请求信号		
		
	   .body_temp_int_one(body_temp_int_one),
		.body_temp_int_ten(body_temp_int_ten),
		.body_temp_dec_one(body_temp_dec_one),
		.body_temp_dec_ten(body_temp_dec_ten),
		
		.heart_rate_hun(heart_rate_hun),
		.heart_rate_ten(heart_rate_ten),
		.heart_rate_one(heart_rate_one),
		
		.h2_one(h2_one),       
		.h2_ten(h2_ten),      
		.liquefied_one(liquefied_one),
		.liquefied_ten(liquefied_ten),
		.natural_one(natural_one)  ,
		.natural_ten(natural_ten) , 
		.harmful_one(harmful_one)  ,
		.harmful_ten(harmful_ten)  ,
		.oxy_one(oxy_one)    ,   
		.oxy_ten(oxy_ten)   ,   
		.temp_one(temp_one)   ,   
		.temp_ten(temp_ten)  ,     
		.hum_one(hum_one)   ,     
		.hum_ten(hum_ten)   ,    
	
		.lcd_data_in(lcd_data_in),
		.gymcu_data(gymcu_data),	
 
		.lcd_driver_data_in(lcd_driver_data_in)			
		

);


wire    end_o;
wire [303:0] dout_iic;
sensor sensor(
		.clk(clk_50m),				//外部输入时钟
		.rst_n(rst_n),
		.int(int),

		.sda(sda),				//IIC的数据线
		.scl(scl),				//IIC的时钟线
		.end_o(end_o),			//结束信号  结束后会产生高电平
		.dout(dout_iic)				//输出数据
);


wire [11:0] dout_0;
wire [11:0] dout_1;
wire [11:0] dout_2;
wire [11:0] dout_3;
wire [11:0] dout_4;
wire [11:0] dout_5;
wire [11:0] dout_6;
wire [11:0] dout_7;

AD7928 AD7928(
	.clk(clk_adc),
	.rst_n(rst_n),
	
	.dout_0(dout_0),         //并行输出
	.dout_1(dout_1),
	.dout_2(dout_2),
	.dout_3(dout_3),
	.dout_4(dout_4),
	.dout_5(dout_5),
	.dout_6(dout_6),
	.dout_7(dout_7),
	.dout_vld(),     //数据有效信号，1为有效
					

					
	.adc_dout(adc_dout),     //adc输出（串行）
	.adc_din(adc_din),      //adc输入
	.adc_sclk(adc_sclk),     //adc时钟
	.adc_cs_n(adc_cs_n)      //adc片选信号
);

Oxygen Oxygen(
        .clk(clk_50m),		//外部输入时钟
        .rst_n(rst_n),
        .int(),
        .scl(o2_scl),		//IIC的时钟线
        .sda(o2_sda),		//IIC的数据线
		  .menb(menb)
);

DHT11_top   DHT11_inst(                                                          
	.clk(clk_50m),                                                                                      
	.data(dht11),
	.TxD(),
	.temperature_one(temp_one),
	.temperature_ten(temp_ten),
	.humidity_one(hum_one),   
	.humidity_ten(hum_ten)   
                   ); 

wire [3:0] heart_rate_hun;
wire [3:0] heart_rate_ten;
wire [3:0] heart_rate_one;

wire [3:0] h2_one;       
wire [3:0] h2_ten ;      
wire [3:0] liquefied_one;
wire [3:0] liquefied_ten;
wire [3:0] natural_one  ;
wire [3:0] natural_ten ; 
wire [3:0] harmful_one  ;
wire [3:0] harmful_ten  ;
wire [3:0] oxy_one    ;   
wire [3:0] oxy_ten   ;   
wire [3:0] temp_one   ;   
wire [3:0] temp_ten  ;     
wire [3:0] hum_one   ;       
wire [3:0] hum_ten   ;     


    qsys_system u0 (
	 
        .clk_clk               (clk_50m),               //            clk.clk
		  .reset_reset_n         (rst_n),          //          reset.reset_n
		  
        .ain_ch0_export        (dout_1),        //        ain_ch0.export
        .ain_ch1_export        (dout_0),        //        ain_ch1.export
        .ain_ch2_export        (dout_5),        //        ain_ch2.export
        .ain_ch3_export        (dout_4),        //        ain_ch3.export
        .ain_ch4_export        (dout_6),        //        ain_ch4.export
		  
		  .max30102_0_export     (dout_iic[47:24]),     //     max30102_0.export
        .max30102_1_export     (dout_iic[23:0]),     //     max30102_1.export

        .end_o_export          (end_o),          //          end_o.export
		  
        .heart_rate_hun_export (heart_rate_hun), // heart_rate_hun.export
        .heart_rate_one_export (heart_rate_one), // heart_rate_one.export
        .heart_rate_ten_export (heart_rate_ten), // heart_rate_ten.export
		  
        .h2_one_export         (h2_one       ),         //         h2_one.export
        .h2_ten_export         (h2_ten       ),         //         h2_ten.export		  
        .liquefied_one_export  (liquefied_one),  //  liquefied_one.export
        .liquefied_ten_export  (liquefied_ten),  //  liquefied_ten.export
        .natural_one_export    (natural_one  ),    //    natural_one.export
        .natural_ten_export    (natural_ten  ),    //    natural_ten.export
		  .harmful_one_export    (harmful_one  ),    //    harmful_one.export
        .harmful_ten_export    (harmful_ten  ),    //    harmful_ten.export
        .oxy_one_export        (oxy_one      ),        //        oxy_one.export
        .oxy_ten_export        (oxy_ten      )         //        oxy_ten.export
       
    );

assign bz = ((h2_a>8'd20)|(liquefied_a>8'd20)|(natural_a>8'd20)|(harmful_a>8'd20)|(oxy_a<8'd20)) ?0:1;
//assign bz = 1;


wire [7:0] heart_rate_a;
wire [7:0] h2_a;        
wire [7:0] liquefied_a; 
wire [7:0] natural_a;   
wire [7:0] harmful_a;   
wire [7:0] oxy_a;       
wire [7:0] temp_a;      
wire [7:0] hum_a;       


Arrangement Arrangement_inst(
	.heart_rate_hun(heart_rate_hun),
	.heart_rate_ten(heart_rate_ten),
	.heart_rate_one(heart_rate_one),
	.h2_ten(h2_ten),
	.h2_one(h2_one),
	.liquefied_ten(liquefied_ten),
	.liquefied_one(liquefied_one),
	.natural_ten(natural_ten),
	.natural_one(natural_one),
	.harmful_ten(harmful_ten),
	.harmful_one(harmful_one),
	.oxy_ten(oxy_ten),
	.oxy_one(oxy_one),
	.temp_ten(temp_ten),
	.temp_one(temp_one),
	.hum_ten(hum_ten),
	.hum_one(hum_one),
	
	.heart_rate_a(heart_rate_a),
	.h2_a(h2_a),
	.liquefied_a(liquefied_a),
	.natural_a(natural_a),
	.harmful_a(harmful_a),
	.oxy_a(oxy_a),
	.temp_a(temp_a),
	.hum_a(hum_a) 		
);

wire  [79:0]   data_final_1;
wire [159:0] 	data_final_2;
assign		 data_final_2={data_eeprom,80'b0};
assign       data_final_1={body_temp_int,body_temp_dec,heart_rate_a,h2_a,liquefied_a,natural_a,harmful_a,oxy_a,temp_a,hum_a};

wire txd_start;
wire [79:0]  data_eeprom;
EEPROM EEPROM_inst(
	.clk(clk_50m),				//外部输入时钟
	.rst_n(rst_n),
	.key(key_eeprom),				//按键
	.data_in(data_final_1),			//输入数据
	.sda(eeprom_sda),				//IIC的数据线
	.scl(eeprom_scl),				//IIC的时钟线
	.data_out(data_eeprom),		//数据输出
	.end_o(txd_start) 			//结束信号

);



PC2FPGA_UART_Test bt_inst(
	//global clock 50MHz
	.clk_50m(clk_50m),			//50MHz
	.rst_n(rst_n),

	//user interfaces 
	.txd_start(txd_start),
	.input_data(data_final_2),
	.fpga_txd(hc06_rxd),		//fpga 2 pc uart transfer
	.divide_clk()	//precise clock output
);	


key_control key_control_inst(
	.clk_50m(clk_50m),
	.rst_n(rst_n),
			
	.key_led(key_led),
	.key_sensor(key_sensor),
			
	.sensor_en(sensor_en),
	.led_p(led_p)		
); 
endmodule
