`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:50:13 09/16/2016
// Design Name:   contador_rtc
// Module Name:   C:/Users/VMWIN7/Desktop/contador/RTC_signal_control/Contador_rtc_tb.v
// Project Name:  RTC_signal_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: contador_rtc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Contador_rtc_tb;

	// Inputs
	reg clk;
	reg reset;
	reg EN_cuenta;
	reg [5:0] tiempo;
	// Outputs
	wire [5:0] cuenta;

	// Instantiate the Unit Under Test (UUT)
	contador_rtc uut (
		.clk(clk), 
		.reset(reset), 
		.EN_cuenta(EN_cuenta), 
		.cuenta(cuenta),
		.tiempo(tiempo)
	);

always
	begin
		#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		EN_cuenta = 0;
		tiempo = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		EN_cuenta = 1;
		tiempo = 32;
		#900;
		
		$stop;
	end
      
endmodule

