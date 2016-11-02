`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:13 09/16/2016 
// Design Name: 
// Module Name:    signals_rtc 
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
module signals_rtc(
	input wire clk, reset, EN_signals, read, dato,
	output wire CS, WR, RD, AD, SS, 
	output wire LL // señal creada para controlar instante en que guarde dato leido
	// SALIDAS DE PRUEBA
	//output wire activador_cuenta_pr,
	//output wire [4:0] cuenta_pr 
    );
	// parametros fijos
	localparam atraso =2;
	localparam bajo_cs_wr_rd =17;
	localparam bajo_ad =19;
	localparam transicion =32;
	localparam zup= 7;
	localparam zdown=20;
	//
	localparam tiempo= 6'd32;
	//
	
	reg EN_cuenta;
	reg cs_reg, wr_reg, rd_reg, ad_reg, ss_reg, ll_reg;
	wire [4:0] cuenta;

	
	
	contador_rtc ciclo_signals(.clk(clk), .reset(reset), .EN_cuenta(EN_cuenta), .tiempo(tiempo), .cuenta(cuenta));
	
	
	always @(posedge clk, posedge reset)
		if (reset)
			begin
				cs_reg<=1'b1;
				wr_reg<=1'b1;
				rd_reg<=1'b1;
				ad_reg<=1'b1;
				ss_reg<=1'b0;
				ll_reg<=1'b0;
				EN_cuenta<=1'b0;
			end
		else
			begin
				if (EN_signals)
					begin
						EN_cuenta <= 1'b1;
	// control AD
						if (cuenta < (bajo_ad-1) | cuenta >= (transicion-1))
							begin
								if (~dato) ad_reg<=0;
								else ad_reg<=1;
							end
						else ad_reg<=1; 
	// control CS, WR, RD
						if (cuenta >= (atraso-1) & cuenta < (bajo_cs_wr_rd-1))
							begin
								if (read)
									begin
										cs_reg<=0;
										wr_reg<=1;
										rd_reg<=0;
									end
								else
									begin
										cs_reg<=0;
										wr_reg<=0;
										rd_reg<=1;
									end
							end
						else if (cuenta >= (bajo_cs_wr_rd-1) & cuenta < (transicion-1))
							begin
								cs_reg<=1;
								wr_reg<=1;
								rd_reg<=1;
							end 
	// control SS
					if (~read)
						begin
							if (cuenta >= (zup-1) & cuenta < (zdown+7)) ss_reg<=1'b1;
							else ss_reg<=1'b0;
						end
					else ss_reg<=1'b0;
	// control LL
					if (read)
						begin
							if (cuenta >= (zup-2) & cuenta < (zdown-2)) ll_reg<=1'b1;
							else ll_reg<=1'b0;
						end
					else ll_reg<=1'b0;
			end	
					
				else
					begin
						cs_reg<=1'b1;
						wr_reg<=1'b1;
						rd_reg<=1'b1;
						ad_reg<=1'b1;
						ss_reg<=1'b0;
						ll_reg<=1'b0;
						EN_cuenta<=1'b0;
					end
			end
	
	assign CS = cs_reg;
	assign WR = wr_reg;
	assign RD = rd_reg;
	assign AD = ad_reg;
	assign SS = ss_reg;
	assign LL = ll_reg;
	//assigns prueba
	//assign activador_cuenta_pr = EN_cuenta;
	//assign cuenta_pr = cuenta;
	
endmodule
