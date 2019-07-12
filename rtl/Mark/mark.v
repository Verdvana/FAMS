module mark(
    input           		clk,
    input           		rst_n,
    input   	[10:0]  	lcd_xpos,
    input   	[10:0]  	lcd_ypos,
    input   	[7:0]   	sys_data_out1,
    input   	[7:0]   	sys_data_out2,
	 input		[7:0]		lcd_data,
	 input					lcd_clken,

    output reg [23:0]	lcd_data_in
);


reg [7:0]	frame_cnt;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		frame_cnt <= 8'b0;
	else if(lcd_xpos ==1'b1 && lcd_ypos == 1'b1)
			frame_cnt <= frame_cnt + 1'b1;
	else if(frame_cnt == 8'd120)
		frame_cnt <= 8'b0;
	else 
		frame_cnt <= frame_cnt;
end 

reg [11:0]	xpos_max;
reg [11:0]	xpos_min;
reg [11:0]	ypos_max;
reg [11:0]	ypos_min;
always@(posedge clk or negedge rst_n)
begin 	
	if(!rst_n)
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
reg [11:0]	xpos_max_r;
reg [11:0]	xpos_min_r;
reg [11:0]	ypos_max_r;
reg [11:0]	ypos_min_r;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		begin 
		xpos_max_r <= 12'b0;
		xpos_min_r <= 12'b0;
		ypos_max_r <= 12'b0;
		ypos_min_r <= 12'b0;
		end 
	else if((xpos_max - xpos_min < 12'd26)  || (ypos_max - ypos_min < 12'd26) )
		begin 
		xpos_max_r <= xpos_max_r;
		xpos_min_r <= xpos_min_r;
		ypos_max_r <= ypos_max_r;
		ypos_min_r <= ypos_min_r;
		end 
	else if((xpos_max - xpos_min > 12'd500) || (ypos_max - ypos_min > 12'd300))
		begin 
		xpos_max_r <= 12'b0;
		xpos_min_r <= 12'b0;
		ypos_max_r <= 12'b0;
		ypos_min_r <= 12'b0;
		end 
	else
		begin 
		xpos_max_r <= xpos_max;
		xpos_min_r <= xpos_min;
		ypos_max_r <= ypos_max;
		ypos_min_r <= ypos_min;
		end 
end 
wire [11:0] x1;
wire [11:0] x2;
wire [11:0] y1;
wire [11:0] y2;

assign x1 = xpos_min_r - xpos_min_r % 20;
assign x2 = xpos_max_r - xpos_max_r % 20;
assign y1 = ypos_min_r - ypos_min_r % 20;
assign y2 = ypos_max_r - ypos_max_r % 20;

wire	[5:0] width;

assign width = 6'd2;

always@(posedge clk or negedge rst_n)		
begin
	if(!rst_n)
		lcd_data_in <= 0;
	else if(lcd_clken == 1'b1)
		begin 
		if( (lcd_xpos >  x1 - width && lcd_xpos <  x1 + width && lcd_ypos > y1 && lcd_ypos < y2) ||
			 (lcd_xpos >  x2 - width && lcd_xpos <  x2 + width && lcd_ypos > y1 && lcd_ypos < y2) ||
			 (lcd_ypos >  y1 - width && lcd_ypos <  y1 + width && lcd_xpos > x1 && lcd_xpos < x2) ||
			 (lcd_ypos >  y2 - width && lcd_ypos <  y2 + width && lcd_xpos > x1 && lcd_xpos < x2)
			)
			lcd_data_in <= {8'd255,8'b0,8'b0};
		else 
			lcd_data_in <= {sys_data_out1,sys_data_out1,sys_data_out1};
		end 
	else
		lcd_data_in <= 24'd0;	
end

endmodule
