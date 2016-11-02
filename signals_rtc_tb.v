`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:16:46 09/21/2016
// Design Name:   signals_rtc
// Module Name:   C:/Users/VMWIN7/Desktop/RTC/RTC_signal_control/signals_rtc_tb.v
// Project Name:  RTC_signal_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signals_rtc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module signals_rtc_tb;

	// Inputs
	reg clk;
	reg reset;
	reg EN_signals;
	reg read;
	reg dato;

	// Outputs
	wire CS;
	wire WR;
	wire RD;
	wire AD;
	wire SS;
	wire LL;
	wire activador_cuenta_pr;
	wire [5:0] cuenta_pr;

	// Instantiate the Unit Under Test (UUT)
	signals_rtc uut (
		.clk(clk), 
		.reset(reset), 
		.EN_signals(EN_signals), 
		.read(read), 
		.dato(dato), 
		.CS(CS), 
		.WR(WR), 
		.RD(RD), 
		.AD(AD), 
		.SS(SS), 
		.LL(LL),
		.activador_cuenta_pr(activador_cuenta_pr), 
		.cuenta_pr(cuenta_pr)
	);
always 
	begin
	#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		EN_signals = 0;
		read = 0;
		dato = 0;

		// Wait 100 ns for global reset to finish
				#100;
      reset = 0;
		#100;
		// Add stimulus here
		EN_signals = 1;
		read = 0;
		dato = 0;
		#320;
		/*
		activador_signals = 0;
		#10;*/
		
		EN_signals = 1;
		read = 1;
		dato = 1;
		#320;

		EN_signals = 1;
		read = 0;
		dato = 0;
		#320;
		
		EN_signals = 1;
		read = 0;
		dato = 1;
		#320;
				
		EN_signals = 0;
		read = 0;
		dato = 0;
		#320;
		
		$stop;
	end
      
endmodule

