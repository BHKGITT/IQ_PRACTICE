module Adder#(parameter CLK_DIVIDER = 4)
	(
		input CLK_IN,  // 200Mhz 
		input Reset_n,
		output CLK_OUT
	);
    reg       clk_div2;
    reg       clk_div3;
    reg       clk_div4;
    reg [1:0] cntr;

    // Divide by 2: 200 MHz / 2 = 100 MHz
    always @(posedge CLK_IN) begin
        if (!Reset_n)
            clk_div2 <= 1'b0;
        else
            clk_div2 <= ~clk_div2;
    end

    // Divide by 3: 200 MHz / 3 = 66.66 MHz
    // High for 1 input-clock cycle, low for 2 cycles
    always @(posedge CLK_IN) begin
        if (!Reset_n) begin
            cntr     <= 2'd0;
            clk_div3 <= 1'b0;
        end
        else begin
            if (cntr == 2'd0) begin
                clk_div3 <= 1'b1;
                cntr     <= cntr + 1'b1;
            end
            else if (cntr == 2'd1) begin
                clk_div3 <= 1'b0;
                cntr     <= cntr + 1'b1;
            end
            else begin
                cntr     <= 2'd0;
                clk_div3 <= 1'b0;
            end
        end
    end
    // Divide by 4: 200 MHz / 4 = 50 MHz
    always@(posedge CLK_IN)
    begin 
        if (!Reset_n) begin
            cntr     <= 2'd0;
            clk_div4 <= 1'b0;
        end
        else begin
            if (cntr < 2'd2) begin
                clk_div4 <= 1'b1;
                cntr     <= cntr + 1'b1;
            end
            else if (cntr < 2'd3) begin
                clk_div4 <= 1'b0;
                cntr     <= cntr + 1'b1;
            end
            else begin
                cntr     <= 2'd0;
                clk_div4 <= 1'b0;
            end
        end
    end 

    // Output selection
    assign CLK_OUT = (CLK_DIVIDER == 1) ? CLK_IN    :
                     (CLK_DIVIDER == 2) ? clk_div2  :
                     (CLK_DIVIDER == 3) ? clk_div3  :
                     (CLK_DIVIDER == 4) ? clk_div4  :
                                     1'b0;

endmodule
