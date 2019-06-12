
module qsys_system (
	ain_ch0_export,
	ain_ch1_export,
	ain_ch2_export,
	ain_ch3_export,
	ain_ch4_export,
	clk_clk,
	end_o_export,
	h2_one_export,
	h2_ten_export,
	harmful_one_export,
	harmful_ten_export,
	heart_rate_hun_export,
	heart_rate_one_export,
	heart_rate_ten_export,
	liquefied_one_export,
	liquefied_ten_export,
	max30102_0_export,
	max30102_1_export,
	natural_one_export,
	natural_ten_export,
	oxy_one_export,
	oxy_ten_export,
	reset_reset_n);	

	input	[11:0]	ain_ch0_export;
	input	[11:0]	ain_ch1_export;
	input	[11:0]	ain_ch2_export;
	input	[11:0]	ain_ch3_export;
	input	[11:0]	ain_ch4_export;
	input		clk_clk;
	input		end_o_export;
	output	[3:0]	h2_one_export;
	output	[3:0]	h2_ten_export;
	output	[3:0]	harmful_one_export;
	output	[3:0]	harmful_ten_export;
	output	[3:0]	heart_rate_hun_export;
	output	[3:0]	heart_rate_one_export;
	output	[3:0]	heart_rate_ten_export;
	output	[3:0]	liquefied_one_export;
	output	[3:0]	liquefied_ten_export;
	input	[23:0]	max30102_0_export;
	input	[23:0]	max30102_1_export;
	output	[3:0]	natural_one_export;
	output	[3:0]	natural_ten_export;
	output	[3:0]	oxy_one_export;
	output	[3:0]	oxy_ten_export;
	input		reset_reset_n;
endmodule
