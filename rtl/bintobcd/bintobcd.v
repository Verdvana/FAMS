module bintobcd(
						input [13:0] 			bin,  //10位二进制码
						
						output reg [3:0] 		one,  //个位
						output reg [3:0] 		ten,  //十位
						output reg [3:0] 		hun,  //百位		
					   output reg [3:0] 		tho  //千位
	
);

integer i;

always@(bin)
begin
	one=4'b0;
	ten=4'b0;
	hun=4'b0;
	tho=4'b0;
	
	for(i=13;i>=0;i=i-1)
	begin
		if(tho>=5)
			tho=tho+3;
		
		if(hun>=5)
			hun=hun+3;
			
		if(ten>=5)
			ten=ten+3;
		
		if(one>=5)
			one=one+3;
			
		tho=tho<<1;
		tho[0]=hun[3];			
		hun=hun<<1;
		hun[0]=ten[3];
		ten=ten<<1;
		ten[0]=one[3];
		one=one<<1;
		one[0]=bin[i];
		
	end
end

endmodule

