module ClockDivider#(paramter CLK_DIVIDER = 1)
	(
		input CLK_IN,
		input Reset_n;
		output CLK_OUT
	);
	reg[1:0] counter;
	reg      toggle;
	always@(posedge CLK_IN)
	begin 
		if(!Reset_n)
		begin
			counter <= CLK_DIVIDER-1;
			toggle  <= 1'b0;
		end 
		else begin 
			if(!counter)
			begin
				counter <= CLK_DIVIDER -1;
				toggle  <= !toggle;
			end 
			else
			begin
				counter <= counter - 1'b1;
			end 
		end 
	end 
	
	assign CLK_OUT = toggle;
endmodule

/*
  Formulae : 
      Fout = Fin /(2*CLK_DIVIDER)	  

*/
