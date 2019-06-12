`timescale 1ns/1ns 
module precise_divider
#(
	//DEVIDE_CNT = 100_000000/ (fo * 4)
	parameter DEVIDE_CNT=32'd6597070	//9600*16 hz	
)
(
	input 	clk,     // clock 100MHZ
	input 	rst_n,   // resert signal 
	
	output 	divide_clk, //divide frequence signal 
	output 	divide_clken //enable clock signal 
);
reg  [31:0]	 cnt;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		cnt<=0;
	else 
		cnt<=cnt+DEVIDE_CNT;
end 

reg cnt_equal;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		cnt_equal<=0;
	else if(cnt<32'h7FFF_FFFF)
		cnt_equal<=0;
	else 
		cnt_equal<=1;
end 

reg cnt_equal_r;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		cnt_equal_r<=0;
	else 
		cnt_equal_r<=cnt_equal;
end 
assign divide_clken=(~cnt_equal_r & cnt_equal) ? 1'b1:1'b0; //posedge 
assign divide_clk=cnt_equal_r;
endmodule 