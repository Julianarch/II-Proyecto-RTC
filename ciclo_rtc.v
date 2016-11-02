`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:41:03 09/22/2016 
// Design Name: 
// Module Name:    ciclo_rtc 
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
module ciclo_rtc(
	input wire clk, reset, EN_ciclo,
	input wire [5:0] duracion,
	output wire [5:0] ciclo,
	//salidas de prueba
	output wire [4:0] cuenta_int
    );
	 
	localparam tiempo = 6'd32;
	reg EN_cuenta;
	wire [4:0] cuenta;
	reg [5:0] ciclo_reg;
	
	contador_rtc cuenta_ciclo(.clk(clk), .reset(reset), .EN_cuenta(EN_cuenta), .tiempo(tiempo), .cuenta(cuenta));
	
	always @(posedge clk, posedge reset)
	if (reset)
		begin
			ciclo_reg <= 1'b0;
			EN_cuenta <= 1'b0;
		end
	else
		if (EN_ciclo)
			begin
				EN_cuenta <= 1'b1;
				
				if (cuenta==(tiempo-1) & ciclo_reg < (duracion-1)) ciclo_reg <= ciclo_reg + 1'b1;
				
				else if (cuenta != (tiempo-1) & ciclo_reg < (duracion-1)) ciclo_reg <= ciclo_reg;
				
				else if (cuenta == (tiempo-1) & ciclo_reg == (duracion-1)) ciclo_reg <= 1'b0;
				
				else if (cuenta != (tiempo-1) & ciclo_reg == (duracion-1)) ciclo_reg <= ciclo_reg;
				
				else ciclo_reg <= 0;
			end
		else
			begin
				ciclo_reg <= 1'b0;
				EN_cuenta<=1'b0;
			end
	
	assign ciclo = ciclo_reg;
	assign cuenta_int = cuenta;
endmodule
