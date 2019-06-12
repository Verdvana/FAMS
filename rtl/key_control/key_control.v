module key_control(
			input				clk_50m,
			input				rst_n,
			
			input				key_led,
			input				key_sensor,
			
			output			sensor_en,
			output			led_p		
);


reg key_led_buf, key_led_rise;

always@(posedge clk_50m)
begin
   key_led_buf <= key_led;
   key_led_rise <= (~key_led_buf) & key_led;  
end


reg led_state;
always@(posedge clk_50m or negedge rst_n)
begin
	if(!rst_n)
		led_state<=0;
	
	else if(key_led_rise)
		led_state<=~led_state;
	
	else
		led_state<=led_state;
				
end

assign led_p = led_state;

//--------------------------------
reg key_sensor_buf, key_sensor_rise;

always@(posedge clk_50m)
begin
   key_sensor_buf <= key_sensor;
   key_sensor_rise <= (~key_sensor_buf) & key_sensor;  
end


reg sensor_state;
always@(posedge clk_50m or negedge rst_n)
begin
	if(!rst_n)
		sensor_state<=1;
	
	else if(key_sensor_rise)
		sensor_state<=~sensor_state;
	
	else
		sensor_state<=sensor_state;
				
end

assign sensor_en = sensor_state;


endmodule
