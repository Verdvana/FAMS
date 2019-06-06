`timescale 1ns/1ns
module Threshold_Adj
(
	//global clock
	input				clk,  		//100MHz
	input				rst_n,		//global reset
	
	//user interface
	input				key_flag,		//key down flag
	input		[1:0]	key_value,		//key control data
	
	output	reg	[7:0]	Threshold	//Threshold Grade output
);
reg [3:0] Threshold_Grade;
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		Threshold_Grade <= 8'h9;
	else if(key_flag)
		begin 
		case(key_value) 
			2'b01:	Threshold_Grade <= (Threshold_Grade == 0)  ? 8'b0 : Threshold_Grade - 1'b1;
			2'b10: 	Threshold_Grade <= (Threshold_Grade == 15) ? 8'hf : Threshold_Grade + 1'b1;
			default: ;
		endcase 
		end 
end 
always@(posedge clk or negedge rst_n)
begin 
	if(!rst_n)
		Threshold <= 8'd100;
	else 
	begin 
	case(Threshold_Grade)
	4'h0:	Threshold <= 8'd10;
	4'h1:	Threshold <= 8'd20;
	4'h2:	Threshold <= 8'd30;
	4'h3:	Threshold <= 8'd40;
	4'h4:	Threshold <= 8'd50;
	4'h5:	Threshold <= 8'd60;
	4'h6:	Threshold <= 8'd70;
	4'h7:	Threshold <= 8'd80;
	4'h8:	Threshold <= 8'd90;
	4'h9:	Threshold <= 8'd100;
	4'ha:	Threshold <= 8'd110;
	4'hb:	Threshold <= 8'd120;
	4'hc:	Threshold <= 8'd130;
	4'hd:	Threshold <= 8'd140;
	4'he:	Threshold <= 8'd150;
	4'hf:	Threshold <= 8'd160;
	default:;
	endcase
	end 
end 

endmodule 