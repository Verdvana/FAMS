`timescale 1ns/1ns
module key
#(
	parameter	KEY_WIDTH = 4
)
(
	//global clock
	input 							clk,     
	input 							rst_n,
	
	//key interface
	input 		[KEY_WIDTH-1:0] 	key_data,
	
	//user interface
	output 							key_flag,
	output	reg	[KEY_WIDTH-1:0]		key_value	//H Valid
);

//-----------------------------------
//Delay for 20ms
localparam DELAY_TOP = 20'd500_000;
//localparam DELAY_TOP = 20'd1000;		//Just for test
reg	[19:0]	delay_cnt;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		delay_cnt <= 0;
	else if(delay_cnt < DELAY_TOP)
		delay_cnt <= delay_cnt + 1'b1;
	else
		delay_cnt <= 0;
end
wire	delay_done = (delay_cnt == DELAY_TOP) ? 1'b1 : 1'b0;

//-----------------------------------
//Key scan via jitter detect. 
localparam	SCAN_DETECT1	=	3'd0;	
localparam	SCAN_JITTER1	=	3'd1;
localparam	SCAN_READ		=	3'd2;
localparam	SCAN_DETECT2	=	3'd3;
localparam	SCAN_JITTER2	=	3'd4;
reg	[2:0]	key_state;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		key_state <= SCAN_DETECT1;
		key_value <= {KEY_WIDTH{1'b0}};
		end
	else if(delay_done)
		begin
		case(key_state)
		SCAN_DETECT1:	//Detect if there is key down
			begin
			if(key_data != {KEY_WIDTH{1'b1}})
				key_state <= SCAN_JITTER1;
			else
				key_state <= SCAN_DETECT1;
			end
		SCAN_JITTER1:	//Delay 10 ms and detect again
			begin
			if(key_data != {KEY_WIDTH{1'b1}})
				key_state <= SCAN_READ;
			else
				key_state <= SCAN_DETECT1;
			end
		SCAN_READ:		//Save the detect key value
			begin
			key_value <= ~key_data; //lock the key_value
			key_state <= SCAN_DETECT2;
			end
		SCAN_DETECT2:	//Detect if the key is open
			begin
			if(key_data == {KEY_WIDTH{1'b1}})
				key_state <= SCAN_JITTER2;
			else
				key_state <= SCAN_DETECT2;
			end
		SCAN_JITTER2:	//Delay 10ms and detect again
			begin
			if(key_data == {KEY_WIDTH{1'b1}})
				key_state<=SCAN_DETECT1;
			else
				key_state<=SCAN_JITTER2;
			end
		endcase
		end
	else
		begin
		key_state <= key_state;
		key_value <= key_value;
		end
end

//---------------------------------------
//output the capture enable signal
assign key_flag = (key_state == 3'd4 && delay_done == 1'b1) ? 1'b1 : 1'b0;

endmodule