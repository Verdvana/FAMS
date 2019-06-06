module	SingleSensorDriver_MT9V034
#(
	parameter	CLOCK_MAIN	=	100_000000,
	parameter	CLOCK_I2C   =   100_000
)
(
	input				clk_ref,
	input				clk_cmos,
	input				rst_n,
	
	//cmos interface
	output				cmos_sclk,			//cmos i2c clock
	inout				cmos_sdat,			//cmos i2c data
	input				cmos_pclk,			//cmos pxiel clock
	output				cmos_xclk,			//cmos externl clock
	input				cmos_vsync,			//cmos vsync
	input				cmos_href,			//cmos hsync refrence
	input		[7:0]	cmos_data,			//cmos data

	//sensor data capture output
	output				cmos_zoom_vsync,	//cmos frame data vsync valid signal
	output				cmos_zoom_href,		//cmos frame data href vaild  signal
	output		[7:0]	cmos_zoom_Gray,		//cmos frame data output: 8 Bit raw data
	output		[7:0]	cmos_fps_rate,		//cmos image output rate
	
	//User Interface
	output				i2c_config_done
);



//----------------------------------------------
//----------------------------------------------
//i2c timing controller module of 16Bit
wire	[7:0]	i2c_config_index;
wire	[23:0]	i2c_config_data;
wire	[7:0]	i2c_config_size;
//wire			i2c_config_done;
wire	[15:0]	i2c_rdata;		//i2c register data
i2c_timing_ctrl_16bit
#(
	.CLK_FREQ	(CLOCK_MAIN),	//100 MHz
	.I2C_FREQ	(CLOCK_I2C)		//10 KHz(<= 400KHz)
)
u_i2c_timing_ctrl_16bit
(
	//global clock
	.clk				(clk_ref),		//100MHz
	.rst_n				(rst_n),		//system reset
			
	//i2c interface
	.i2c_sclk			(cmos_sclk),	//i2c clock
	.i2c_sdat			(cmos_sdat),	//i2c data for bidirection

	//i2c config data
	.i2c_config_index	(i2c_config_index),	//i2c config reg index, read 2 reg and write xx reg
	.i2c_config_data	({8'h90, i2c_config_data}),	//i2c config data
	.i2c_config_size	(i2c_config_size),	//i2c config data counte
	.i2c_config_done	(i2c_config_done),	//i2c config timing complete
	.i2c_rdata			(i2c_rdata)			//i2c register data while read i2c slave
);

//----------------------------------------------
//I2C Configure Data of MT9V034
I2C_MT9V034_Gray_Config	u_I2C_MT9V034_Gray_Config_sensor1
(
	.LUT_INDEX		(i2c_config_index),
	.LUT_DATA		(i2c_config_data),
	.LUT_SIZE		(i2c_config_size)
);



//assign	cmos_xclk = clk_cmos;
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
//cmos video image capture
wire			cmos_init_done = i2c_config_done/*sdram_init_done*/;	///cmos camera init done
wire			cmos_frame_vsync;	//cmos frame data vsync valid signal
wire			cmos_frame_href;	//cmos frame data href vaild  signal
wire	[7:0]	cmos_frame_Gray;	//cmos frame data output: 8 Bit raw data
CMOS_Capture_RAW_Gray	
#(
	.CMOS_FRAME_WAITCNT		(4'd10)				//Wait n fps for steady(OmniVision need 10 Frame)
)
u_CMOS_Capture_RAW_Gray_sensor1
(
	//global clock
	.clk_cmos				(clk_cmos),			//24MHz CMOS Driver clock input
	.rst_n					(rst_n & cmos_init_done),	//global reset

	//CMOS Sensor Interface
	.cmos_pclk				(cmos_pclk),  		//24MHz CMOS Pixel clock input
	.cmos_xclk				(cmos_xclk),		//24MHz drive clock
	.cmos_data				(cmos_data),		//8 bits cmos data input
	.cmos_vsync				(cmos_vsync),		//L: vaild, H: invalid
	.cmos_href				(cmos_href),		//H: vaild, L: invalid
	
	//CMOS SYNC Data output
	.cmos_frame_vsync		(cmos_frame_vsync),//cmos frame data vsync valid signal
	.cmos_frame_href		(cmos_frame_href),	//cmos frame data href vaild  signal
	.cmos_frame_data		(cmos_frame_Gray),	//cmos frame data output: 8 Bit raw data
	
	//user interface
	.cmos_fps_rate			(cmos_fps_rate)		//cmos image output rate
);


//--------------------------------------
//Sensor HSize zoom for 640
//wire			cmos_zoom_vsync;	//cmos frame data vsync valid signal
//wire			cmos_zoom_href;	//cmos frame data href vaild  signal
//wire	[7:0]	cmos_zoom_Gray;	//cmos frame data output: 8 Bit raw data
Sensor_Image_Zoom
#(
	.IMAGE_HSIZE	(640)
)
u_Sensor1_Image_Zoom
(
	//CMOS Sensor Interface
	.clk				(cmos_pclk),			//image pixel clock
	.rst_n				(rst_n),			//system reset
	
	.image_in_vsync		(cmos_frame_vsync),	//cmos frame data vsync valid signal
	.image_in_href		(cmos_frame_href),		//cmos frame data href vaild  signal
	.image_in_data		(cmos_frame_Gray),		//cmos frame data output: 8 Bit raw data
	.image_out_vsync	(cmos_zoom_vsync),		//cmos frame data vsync valid signal
	.image_out_href		(cmos_zoom_href),		//cmos frame data href vaild  signal
	.image_out_data		(cmos_zoom_Gray)		//cmos frame data output: 8 Bit raw data	
);

endmodule
