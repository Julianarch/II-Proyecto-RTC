`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:42 09/29/2016 
// Design Name: 
// Module Name:    contador_rtc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module contador_rtc(
	input wire clk, reset, EN_cuenta, 
	input wire [5:0] tiempo,
	output wire [4:0] cuenta
    );

	reg [4:0] cuenta_reg;
	
	always @(posedge clk, posedge reset)
	if (reset) cuenta_reg <= 1'b0;
	else
		begin
			if (EN_cuenta & cuenta_reg!=(tiempo-1)) cuenta_reg <= cuenta_reg + 1'b1;
			else cuenta_reg <= 1'b0;
		end
			
	assign cuenta = cuenta_reg;

endmodule