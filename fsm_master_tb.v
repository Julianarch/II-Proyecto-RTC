`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:40:27 09/23/2016
// Design Name:   fsm_master
// Module Name:   C:/Users/VMWIN7/Desktop/RTC/RTC_signal_control/fsm_master_tb.v
// Project Name:  RTC_signal_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fsm_master
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fsm_master_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [2:0] SWT;

	// Outputs
	wire CS;
	wire AD;
	wire WR;
	wire RD;
	wire dato_p;
	wire read_p;
	wire EN_signals_p;
	wire [7:0] addr_date_p;
	wire [3:0] reg_select_p;
	wire [1:0] estado_p;
	wire SS_p;
	wire LL_p;
	wire [4:0] ciclo_p;
	wire [4:0] cuenta_p;
	wire [2:0] ruta_p;
	wire [1:0] cambio_p;
	wire EN_ciclo_p;
	wire [4:0] duracion_p;
	wire inicializacion_p;
	wire activador_cuenta_signalsp;
	wire [4:0] cuenta_signalsp;
	wire [7:0] seg_p;

	// Bidirs
	wire [7:0] RTC_BUS;

	// Instantiate the Unit Under Test (UUT)
	fsm_master uut (
		.RTC_BUS(RTC_BUS), 
		.clk(clk), 
		.reset(reset), 
		.SWT(SWT), 
		.CS(CS), 
		.AD(AD), 
		.WR(WR), 
		.RD(RD), 
		.dato_p(dato_p), 
		.read_p(read_p), 
		.EN_signals_p(EN_signals_p), 
		.addr_date_p(addr_date_p),
		.reg_select_p(reg_select_p),
		.estado_p(estado_p),
		.SS_p(SS_p), 
		.LL_p(LL_p),
		.ciclo_p(ciclo_p), 
		.cuenta_p(cuenta_p), 
		.ruta_p(ruta_p), 
		.cambio_p(cambio_p), 
		.EN_ciclo_p(EN_ciclo_p), 
		.duracion_p(duracion_p), 
		.inicializacion_p(inicializacion_p), 
		.activador_cuenta_signalsp(activador_cuenta_signalsp), 
		.cuenta_signalsp(cuenta_signalsp),
		.seg_p(seg_p)
	);
always 
	begin
		#5 clk = ~clk;
	end
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		SWT = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		#10000;
		SWT = 1;
		#100
		SWT = 0;
		#5000;
        
		// Add stimulus here
		$stop;
	end
      
endmodule

