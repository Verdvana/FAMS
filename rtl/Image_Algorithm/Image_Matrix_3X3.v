module Image_Matrix_3X3
#(
	parameter	[9:0]	IMG_HDISP = 10'd640, //640*480
	parameter	[9:0]	IMG_VDISP = 10'd480
)
(
	//global clock
	input 		clk,  	//cmos pixel clock
	input 		rst_n, 	//global reset
	
	//Image data input to be processed 
	input			per_image_clken,	//Prepared Image data vsync valid signal
	input 	[7:0]	per_image_Gray,	//Prepared Image gray input 
	//Image data output has been processed 
	output 		matrix_image_clken,	//Matrix Image data href valid signal
	
	output 	reg [7:0]	matrix_p11, matrix_p12, matrix_p13, //3X3 Matrix output 
	output  reg [7:0]	matrix_p21, matrix_p22, matrix_p23, 
	output 	reg [7:0]	matrix_p31, matrix_p32, matrix_p33
);


wire	[7:0]	data_p13;    //frame data of the 1th row  3th col 
wire	[7:0]	data_p23;	 //frame data of the 2th row  3th col 
reg		[7:0]	data_p33;	 //frame data of the 3th row  3th col 

always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		data_p33 <= 0;
	else 
		begin 
		if(per_image_clken)
			data_p33 <= per_img_Gray;
		else 
			data_p33 <= data_p33;
	end 
end 

//module of shift ram for raw data 
wire	shift_clk_en = per_image_clken;
Image_Line_Shift_RAM
#(
	.RAM_Length (IMG_HDISP)
)
u_Image_Line_Shift_RAM
(
	.clock		(clk),
	.clken		(shift_clk_en), //pixel enable clock 
	
	.shiftin 	(data_p33),	//current data input 
	.taps0x		(data_p23),	//Last row data 
	.taps1x		(data_p13),	//Last 2 row data 
	
	.shiftout	()
);
/*
	[data_p11	data_p12	data_p13]
	[data_p21   data_p22    data_p23]
	[data_p31	data_p32	data_p33] 
*/
reg	[2:0]	per_image_clken_r;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		per_image_clken_r <= 0;
	else 
		per_image_clken_r <= {per_image_clken_r[1:0],	per_image_clken};
end 

wire	read_image_clken	=	per_image_clken_r[0]|per_image_clken_r[1]; //RAM read valid signal 
assign	matrix_image_clken	= 	per_image_clken_r[2];

reg	[9:0]	pixel_cnt;
reg	[7:0]	data_p11, data_p12;
reg [7:0]	data_p22, data_p22;
reg [7:0]	data_p31, data_p32;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		begin 
		pixel_cnt <= 10'b0;
		data_p11 <= 8'b0;	data_p12 <= 8'b0;
		data_p21 <= 8'b0;	data_p22 <= 8'b0;
		data_p31 <= 8'b0; 	data_p32 <= 8'b0;
		{matrix_p11, matrix_p12, matrix_p13} <= 24'h0;
		{matrix_p21, matrix_p22, matrix_p23} <= 24'h0;
		{matrix_p31, matrix_p32, matrix_p33} <= 24'h0;
		end 
	else if(read_image_clken)
		begin 
		pixel_cnt <= ( pixel_cnt < IMG_HDISP ) ? pixel + 1'b1 : 10'd0;  // Pixel count
		{data_p11, data_p12} <= {};
		{data_p21, data_p22} <= {};
		{data_p31, data_p32} <=   
		end 
end   
