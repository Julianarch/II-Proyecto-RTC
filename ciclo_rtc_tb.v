`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:04:01 09/22/2016
// Design Name:   ciclo_rtc
// Module Name:   C:/Users/VMWIN7/Desktop/RTC/RTC_signal_control/ciclo_rtc_tb.v
// Project Name:  RTC_signal_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ciclo_rtc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ciclo_rtc_tb;

	// Inputs
	reg clk;
	reg reset;
	reg EN_ciclo;
	reg [5:0] duracion;

	// Outputs
	wire [5:0] ciclo;
	wire [5:0] cuenta_int;

	// Instantiate the Unit Under Test (UUT)
	ciclo_rtc uut (
		.clk(clk), 
		.reset(reset), 
		.EN_ciclo(EN_ciclo), 
		.duracion(duracion), 
		.ciclo(ciclo), 
		.cuenta_int(cuenta_int)
	);

always
	begin
		#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		EN_ciclo = 0;
		duracion = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		#100;
        
		// Add stimulus here
		EN_ciclo = 1;
		duracion = 5;
		#1605;
		
		duracion = 3;
		#1000;
		
		$stop;
	end
      
endmodule

