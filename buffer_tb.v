`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:57:55 09/23/2016
// Design Name:   buffer
// Module Name:   C:/Users/VMWIN7/Desktop/RTC/RTC_signal_control/buffer_tb.v
// Project Name:  RTC_signal_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: buffer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module buffer_tb;

	// Inputs
	reg EN_SS;
	reg [7:0] in;


	// Bidirs
	wire [7:0] RTC_BUS;

	// Instantiate the Unit Under Test (UUT)
	buffer uut (
		.RTC_BUS(RTC_BUS), 
		.EN_SS(EN_SS), 
		.in(in)
	);

	initial begin
		// Initialize Inputs
		EN_SS = 0;
		in = 8'h29;

		// Wait 100 ns for global reset to finish
		#100;
		EN_SS = 1;
      #100;
		EN_SS =0;
		#100;
		in = 8'h16;
		#100;
		EN_SS=1;
		#100;
		// Add stimulus here
		$stop;
	end
      
endmodule

