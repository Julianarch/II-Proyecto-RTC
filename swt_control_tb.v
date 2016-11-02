`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:48:06 09/22/2016
// Design Name:   swt_control
// Module Name:   C:/Users/VMWIN7/Desktop/RTC/RTC_signal_control/swt_control_tb.v
// Project Name:  RTC_signal_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: swt_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module swt_control_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [2:0] swt;
	reg [7:0] seg_reg;

	// Outputs
	wire dato;
	wire read;
	wire EN_signals;
	wire [7:0] addr_date;
	wire [3:0] reg_select;
	wire [1:0] estado;
	wire [2:0] ruta;
	wire [5:0] ciclo_pr;
	wire [5:0] cuenta_pr;
	wire [1:0] cambio_pr;
	wire EN_ciclo_pr;
	wire [5:0] duracion_pr;
	wire inicializacion_pr;

	// Instantiate the Unit Under Test (UUT)
	swt_control uut (
		.clk(clk), 
		.reset(reset), 
		.swt(swt), 
		.seg_reg(seg_reg), 
		.dato(dato), 
		.read(read), 
		.EN_signals(EN_signals), 
		.addr_date(addr_date), 
		.reg_select(reg_select),
		.estado(estado),
		.ruta(ruta),
		.ciclo_pr(ciclo_pr), 
		.cuenta_pr(cuenta_pr),  
		.cambio_pr(cambio_pr), 
		.EN_ciclo_pr(EN_ciclo_pr),
		.duracion_pr(duracion_pr),
		.inicializacion_pr(inicializacion_pr)
	);
always 
	begin
		#5 clk =  ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		swt = 0;
		seg_reg = 8'h29;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		#10000;
        
		// Add stimulus here
		swt = 3'b001;
		#500;
		swt = 3'b000;
		#5000;
		
		$stop;
	end
      
endmodule

