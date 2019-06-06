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
	
	


	output				led_p,
	
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
					
					output					sensor_en,
					output					menb,
					
					output					o2_scl,
					inout						o2_sda,
					
					inout						dht11,
					
					input				gy_mcu90640_txd
					
					

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
wire [7:0]	Threshold;  
Threshold_Adj u_Threshold_Adj
(
	.clk					(clk_50m),
	.rst_n 				(sys_rst_n),
	
	.key_flag			(key_flag),
	.key_value			(key_value),
	
	.Threshold			(Threshold)
);
//-------------------------------------
//LCD driver timing
wire	[11:0]	lcd_xpos;		//lcd horizontal coordinate
wire	[11:0]	lcd_ypos;		//lcd vertical coordinate
reg	[23:0]	lcd_data_in;	//lcd data input
wire  [7:0]		sys_data_out;
wire 	[7:0]		abs_sys_out;
assign abs_sys_out = sys_data_out1 > sys_data_out2 ? sys_data_out1 - sys_data_out2 : sys_data_out2 - sys_data_out1;
assign sys_data_out = abs_sys_out > Threshold ? 255 : 0 ;

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


reg [7:0]	frame_cnt;
always@(posedge clk_vga or negedge sys_rst_n)
begin 
	if(!sys_rst_n)
		frame_cnt <= 8'b0;
	else if(lcd_xpos ==1'b1 && lcd_ypos == 1'b1)
			frame_cnt <= frame_cnt + 1'b1;
	else if(frame_cnt == 8'd10)
		frame_cnt <= 8'b0;
	else 
		frame_cnt <= frame_cnt;
end 

reg [11:0]	xpos_max;
reg [11:0]	xpos_min;
reg [11:0]	ypos_max;
reg [11:0]	ypos_min;
reg [11:0]	r_xpos_max;
reg [11:0]	r_xpos_min;
reg [11:0]	r_ypos_max;
reg [11:0]	r_ypos_min;
always@(posedge clk_vga or negedge sys_rst_n)
begin 	
	if(!sys_rst_n)
		begin 
		xpos_max <= 11'd0;
		xpos_min <= 11'd640;
		ypos_max <= 11'd0;
		ypos_min <= 11'd480;
		end 
	else if(frame_cnt == 8'd10)
		begin 
		xpos_max <= 11'd0;
		xpos_min <= 11'd640;
		ypos_max <= 11'd0;
		ypos_min <= 11'd480;
		
		r_xpos_max <= xpos_max;
		r_xpos_min <= xpos_min;
		r_ypos_max <= ypos_max;
		r_ypos_min <= ypos_min;
		end
	else 
		begin 
		if(lcd_data)
			begin 
			if(xpos_max < lcd_xpos)
				xpos_max <= lcd_xpos;
			if(xpos_min >lcd_xpos)
				xpos_min <= lcd_xpos;
			if(ypos_max < lcd_ypos)
				ypos_max <= lcd_ypos;
			if(ypos_min >lcd_ypos)
				ypos_min <= lcd_ypos;
			end 
		end 
end 

always@(posedge clk_vga or negedge sys_rst_n)		
begin
	if(!sys_rst_n)
		lcd_data_in <= 0;
	else if(lcd_clken == 1'b1)
		begin 
		if((lcd_xpos == xpos_min && lcd_ypos > ypos_min && lcd_ypos < ypos_max)  || 
			(lcd_xpos == xpos_max && lcd_ypos > ypos_min && lcd_ypos < ypos_max)  || 
			(lcd_ypos == ypos_min && lcd_xpos > xpos_min && lcd_xpos < xpos_max)  || 
			(lcd_ypos == ypos_max && lcd_xpos > xpos_min && lcd_xpos < xpos_max) )
			lcd_data_in <= {8'd255,8'b0,8'b0};
		else 
			lcd_data_in <= {sys_data_out1,sys_data_out1,sys_data_out1};
		end 
	else
		lcd_data_in <= 24'd0;	
end


wire 			uart_done;
wire [7:0] 	uart_data;
uart_rx uart_rx(
	.clk_50m(clk_50m),                  //系统时钟
	.rst_n(rst_n),                //系统复位，低电平有效
    
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
	.rst_n(rst_n),
				
	.data_in(uart_data),
	.uart_done(uart_done),
	
	.en_data(en_data),
	.clk_out(clk_out),
	
	.Threshold(),	
	.data_cnt(data_cnt),
	.data_out(data_out)
);

wire [15:0] q;

RAM	RAM_inst (
	.data ( data_out ),
	.wraddress ( data_cnt ),
	.wrclock ( clk_out ),
	.wren ( en_data ),
	
	.rdaddress ( rdaddress ),
	.rdclock ( clk_tft ),
	.rden ( lcd_de ), 
	.q ( q )
	);


LCD_Driver LCD_Driver(
		.clk(clk_vga),    			//33.3M
		.rst_n(sys_rst_n),
		.data_in(lcd_data_in),   		//待显示数据
							
		.hcount(lcd_xpos),			//x坐标
		.vcount(lcd_ypos),			//y坐标
		.lcd_request(sys_rd1),	//数据请求信号
							
		.lcd_clk(lcd_clk),			//驱动时钟
		.lcd_de(lcd_de),			//使能
		.lcd_blank_n(lcd_blank_n),
		.lcd_hsync(lcd_hsync),
		.lcd_vsync(lcd_vsync),	
		.lcd_rgb({lcd_red, lcd_green ,lcd_blue}),   //TFT数据输出
		.lcd_pwm()
);

assign  led_p =0;

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

wire [39:0] tem_hum;
DHT11 DHT11(
        .clk_50m(clk_50m),
        .rst_n(rst_n),
		
        .data(dht11),
		
		
        .tem_hum(tem_hum)
);


qsys_system u0 (
        .clk_clk           (clk_50m),           //        clk.clk
        .reset_reset_n     (rst_n),     //      reset.reset_n
        
        .dig_t1_export     (dout_iic[287:272]),     //     dig_t1.export
        .dig_t2_export     (dout_iic[271:256]),     //     dig_t2.export
        .dig_t3_export     (dout_iic[255:240]),     //     dig_t3.export
        .dig_p1_export     (dout_iic[239:224]),     //     dig_p1.export
        .dig_p2_export     (dout_iic[223:208]),     //     dig_p2.export
        .dig_p3_export     (dout_iic[207:192]),     //     dig_p3.export
        .dig_p4_export     (dout_iic[191:176]),     //     dig_p4.export
        .dig_p5_export     (dout_iic[175:160]),     //     dig_p5.export
        .dig_p6_export     (dout_iic[159:144]),     //     dig_p6.export
        .dig_p7_export     (dout_iic[143:128]),     //     dig_p7.export
        .dig_p8_export     (dout_iic[127:112]),     //     dig_p8.export
        .dig_p9_export     (dout_iic[111:96]),     //     dig_p9.export
        .adc_t_export      (dout_iic[95:72]),      //      adc_t.export
        .adc_p_export      (dout_iic[71:48]),      //      adc_p.export
        .max30102_0_export (dout_iic[47:24]), // max30102_0.export
        .max30102_1_export (dout_iic[23:0]), // max30102_1.export
		  
		  .end_o_export        (end_o),         //        end_o.export
		  .body_temp_int_export (), // body_temp_int.export
        .body_temp_dec_export (), // body_temp_dec.export
        .heignt_int_export    (),    //    heignt_int.export
        .heignt_dec_export    (),
		  .heart_rate_export   ()
    );


endmodule
