
module qsys_system (
	clk_clk,
	end_o_export,
	heart_rate_export,
	heignt_dec_export,
	heignt_int_export,
	max30102_0_export,
	max30102_1_export,
	reset_reset_n,
	dig_t1_export,
	dig_t2_export,
	dig_t3_export,
	dig_p1_export,
	dig_p2_export,
	dig_p3_export,
	dig_p4_export,
	dig_p5_export,
	dig_p6_export,
	dig_p7_export,
	dig_p8_export,
	dig_p9_export,
	adc_t_export,
	adc_p_export);	

	input		clk_clk;
	input		end_o_export;
	output	[7:0]	heart_rate_export;
	output	[7:0]	heignt_dec_export;
	output	[7:0]	heignt_int_export;
	input	[23:0]	max30102_0_export;
	input	[23:0]	max30102_1_export;
	input		reset_reset_n;
	input	[15:0]	dig_t1_export;
	input	[15:0]	dig_t2_export;
	input	[15:0]	dig_t3_export;
	input	[15:0]	dig_p1_export;
	input	[15:0]	dig_p2_export;
	input	[15:0]	dig_p3_export;
	input	[15:0]	dig_p4_export;
	input	[15:0]	dig_p5_export;
	input	[15:0]	dig_p6_export;
	input	[15:0]	dig_p7_export;
	input	[15:0]	dig_p8_export;
	input	[15:0]	dig_p9_export;
	input	[23:0]	adc_t_export;
	input	[23:0]	adc_p_export;
endmodule
