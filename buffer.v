`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:03 09/22/2016 
// Design Name: 
// Module Name:    buffer 
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
module buffer(
	inout wire [7:0] RTC_BUS,
	input wire EN_SS,
	input wire [7:0] in
    );

	assign RTC_BUS = (EN_SS) ? in : 8'bzzzzzzzz;

endmodule
