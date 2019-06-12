module uart_transfer
(
    //global clock
	input	clk,
	input	rst_n,
	//uart interface 
	input	clken_16bps,
	output reg  txd,
	//user interface 
	input 	txd_en, 			//uart data transfer enable 
	input [7:0]	txd_data,      //uart transfer data 
	output reg	txd_flag       //uart data transfer done 
);

localparam	T_IDLE	=	2'b0; //test the flag to transfer data 
localparam	T_SEND	=	2'b1; //uart transfer data 
reg [1:0]	txd_state;		//uart transfer state
reg [3:0]	smp_cnt;	    //16 * clk_bps , the center for sample  
reg [4:0]	txd_cnt;		//txd data counter 
localparam	SMP_TOP		=	4'd15;
localparam	SMP_CENTER  =	4'd7;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		begin
		smp_cnt<=0;
		txd_cnt<=0;
		txd_state<=T_IDLE;
		end 
	else 
		begin 
		case(txd_state)
		T_IDLE:
			begin 
			smp_cnt <= 0;
			txd_cnt <= 0;
			if(txd_en == 1)
				txd_state <= T_SEND;
			else 
				txd_state <= T_IDLE;
			end
		T_SEND:
			begin 
			if(clken_16bps==1)
				begin
				smp_cnt <= smp_cnt + 1'b1;
				if(smp_cnt == SMP_TOP)
					begin 
					if(txd_cnt < 4'd9)
						begin 
						txd_cnt <= txd_cnt +1'b1;
						txd_state <= T_SEND;
						end 
					else 
						begin 
						txd_cnt <= 0;
						txd_state <= T_IDLE;
						end 
					end 
				else 
					begin
					txd_cnt <= txd_cnt;
					txd_state <= txd_state;
					end 
				end 
			else 
				begin 
				txd_cnt <= txd_cnt;
				txd_state <= txd_state;
				end 
			end 
		endcase
		end 
end 
always@(*)
begin
	if(txd_state == T_SEND)
		case(txd_cnt)
		4'd0:	txd = 0;
		4'd1:	txd = txd_data[0];
		4'd2:	txd = txd_data[1];
		4'd3:	txd = txd_data[2];
		4'd4:	txd = txd_data[3];
		4'd5:	txd = txd_data[4];
		4'd6:	txd = txd_data[5];
		4'd7:	txd = txd_data[6];
		4'd8:	txd = txd_data[7];
		4'd9:	txd = 1;
		default:txd = 1;
		endcase
	else
		txd = 1'b1;	//default state
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		txd_flag <= 0;
	else if(clken_16bps == 1 && txd_cnt == 4'd9 && smp_cnt == SMP_TOP)
		txd_flag <= 1;
	else 
		txd_flag <= 0;
end 
endmodule 
