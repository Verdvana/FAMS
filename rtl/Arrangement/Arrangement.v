module Arrangement(
		input		[3:0]	heart_rate_hun,
		input		[3:0] heart_rate_ten,
		input		[3:0] heart_rate_one,
		input		[3:0] h2_ten,
		input		[3:0] h2_one,
		input		[3:0] liquefied_ten,
		input		[3:0] liquefied_one,
		input		[3:0] natural_ten,
		input		[3:0] natural_one,
		input		[3:0] harmful_ten,
		input		[3:0] harmful_one,
		input		[3:0] oxy_ten,
		input		[3:0] oxy_one,
		input		[3:0] temp_ten,
		input		[3:0] temp_one,
		input		[3:0] hum_ten,
		input		[3:0] hum_one,
		
		output	[7:0] heart_rate_a,
		output	[7:0] h2_a,        
		output	[7:0] liquefied_a, 
		output	[7:0] natural_a,   
		output	[7:0] harmful_a,   
		output	[7:0] oxy_a,       
		output	[7:0] temp_a,      
		output	[7:0] hum_a        

		
		
);


wire[7:0] result_1;
MULT_1	MULT_1_inst_1 (
	.dataa ( h2_ten ),
	.datab ( 10 ),
	.result ( result_1 )
	);	
assign h2_a=result_1+h2_one;

wire[7:0] result_2;
MULT_1	MULT_1_inst_2 (
	.dataa ( liquefied_ten ),
	.datab ( 10 ),
	.result ( result_2 )
	);	
assign liquefied_a=result_2+liquefied_one;

wire[7:0] result_3;
MULT_1	MULT_1_inst_3 (
	.dataa ( natural_ten ),
	.datab ( 10 ),
	.result ( result_3 )
	);	
assign natural_a=result_3+natural_one;

wire[7:0] result_4;
MULT_1	MULT_1_inst_4 (
	.dataa ( harmful_ten ),
	.datab ( 10 ),
	.result ( result_4 )
	);	
assign harmful_a=result_4+harmful_one;

wire[7:0] result_5;
MULT_1	MULT_1_inst_5 (
	.dataa ( oxy_ten ),
	.datab ( 10 ),
	.result ( result_5 )
	);	
assign oxy_a=result_5+oxy_one;

wire[7:0] result_6;
MULT_1	MULT_1_inst_6 (
	.dataa ( temp_ten ),
	.datab ( 10 ),
	.result ( result_6 )
	);	
assign temp_a=result_6+temp_one;

wire[7:0] result_7;
MULT_1	MULT_1_inst_7 (
	.dataa ( hum_ten ),
	.datab ( 10 ),
	.result ( result_7 )
	);	
assign hum_a=result_7+hum_one;


wire[11:0] result_8;
MULT_2	MULT_2_inst_8 (
	.dataa ( heart_rate_hun ),
	.datab ( 100 ),
	.result ( result_8 )
	);	
wire[7:0] result_9;	
MULT_1	MULT_1_inst_9 (
	.dataa ( heart_rate_ten ),
	.datab ( 10 ),
	.result ( result_9 )
	);	

assign heart_rate_a = result_8 + result_9 + heart_rate_one;


endmodule
