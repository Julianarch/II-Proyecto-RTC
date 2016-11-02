`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:13:31 09/24/2016 
// Design Name: 
// Module Name:    prueba_registros 
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
module prueba_registros(
	input wire clk, reset, LL_signal, swt4,
	inout wire [7:0] RTC_BUS,
	input wire [3:0] reg_select,
	input wire [1:0] estado,
	//Registros usuario provenientes de botones
	
	input wire [7:0] seg_bot, min_bot, hora_bot,
	input wire [7:0] dia_bot, mes_bot, year_bot,
	
	//
	// registros de salida
	output wire [7:0] seg, min, hora,
	output wire [7:0] dia, mes, year,
	output wire [7:0] seg_timer, min_timer, hora_timer,
	output wire alarm_of
    );

	reg [7:0] seg_reg, min_reg, hora_reg, basura_reg;
	reg [7:0] dia_reg, mes_reg, year_reg;
	reg [7:0] seg_timer_reg, min_timer_reg, hora_timer_reg;
	
	reg [7:0] seg_fake, min_fake, hora_fake;
	reg alarm_of_reg;

	always @(posedge clk, posedge reset)
		if (reset)
			begin
				seg_reg <= 8'h00;
				min_reg <= 8'h00;
				hora_reg <= 8'h00;
				dia_reg <= 8'h00;
				mes_reg <= 8'h00;
				year_reg <= 8'h00;
				seg_timer_reg <= 8'h00;
				min_timer_reg <= 8'h00;
				hora_timer_reg <= 8'h00;
				basura_reg <= 8'h00;
				
				seg_fake <= 8'h00;
				min_fake <= 8'h00;
				hora_fake <= 8'h00;
				alarm_of_reg <= 1'b0;
			end
		else
			begin
				if (seg_timer_reg == 8'h01) alarm_of_reg <= 1'b1;
				else 
					begin
						if (swt4) alarm_of_reg <= 1'b0;
						else alarm_of_reg <= alarm_of_reg;
					end
				if (LL_signal == 1'b1)
					//if((seg_timer_reg==8'h00) & (min_timer_reg==8'h00) &(hora_timer_reg==8'h00)) seg_fake <= 8'h00;
					//else seg_fake <= seg_fake;
					if (estado == 2'b00)
						begin
							if((seg_timer_reg==8'h00) & (min_timer_reg==8'h00) &(hora_timer_reg==8'h00)) 
								begin
									seg_fake <= 8'h00;
									min_fake <= 8'h00;
									hora_fake <= 8'h00;
								end
							else 
								begin
									/*if((seg_timer_reg==8'h00) & (min_timer_reg==8'h00) &(hora_timer_reg!=8'h00))
										begin
											seg_fake <= 8'h59 + seg_fake;
											min_fake <= 8'h59;
											hora_fake <= hora_fake - 8'h01;
										end*/
									seg_fake <= seg_fake;
									min_fake <= min_fake;
									hora_fake <= hora_fake;
								end
							if (reg_select == 4'd10)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= RTC_BUS;
								end
							else if (reg_select == 4'd1)
								begin
									seg_reg <= RTC_BUS;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd2)
								begin
									seg_reg <= seg_reg;
									min_reg <= RTC_BUS;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd3)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= RTC_BUS;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd4)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= RTC_BUS;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd5)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= RTC_BUS;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd6)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= RTC_BUS;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd7)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									
									if (seg_fake!=8'h00) seg_timer_reg <= (seg_fake - RTC_BUS);
									else seg_timer_reg <= seg_timer_reg;
									//seg_timer_reg <= (8'h05 - RTC_BUS);
									//seg_timer_reg <= (seg_fake - RTC_BUS);
									
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd8)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									if (min_fake!=8'h00) min_timer_reg <= (min_fake - RTC_BUS);
									else min_timer_reg <= min_timer_reg;
									//min_timer_reg <= RTC_BUS;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd9)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									if (hora_fake!=8'h00) hora_timer_reg <= (hora_fake - RTC_BUS);
									else hora_timer_reg <= hora_timer_reg;
									//hora_timer_reg <= RTC_BUS;
									basura_reg <= basura_reg;
								end
							
						end
						
					else if (estado == 2'b01) // swt 1 esta encendido entonces se debe poner seg, min y hora a que guarden lo que de botonoes
						begin
							if((seg_timer_reg==8'h00) & (min_timer_reg==8'h00) &(hora_timer_reg==8'h00)) 
								begin
									seg_fake <= 8'h00;
									min_fake <= 8'h00;
									hora_fake <= 8'h00;
								end
							else 
								begin
									seg_fake <= seg_fake;
									min_fake <= min_fake;
									hora_fake <= hora_fake;
								end
							if (reg_select == 4'd10) // decir en todo estado 1 que seg min y hora tome los valores de botones
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
									
									seg_reg <= seg_bot;
									min_reg <= min_bot;
									hora_reg <= hora_bot;
										
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= RTC_BUS;
								end
							else if ((reg_select == 4'd1) | (reg_select == 4'd2) | (reg_select == 4'd3))
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
									
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
									
							else if (reg_select == 4'd4)
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
										
									dia_reg <= RTC_BUS;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd5)
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
									
									dia_reg <= dia_reg;
									mes_reg <= RTC_BUS;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd6)
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
									
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= RTC_BUS;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd7)
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
									
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									
									if (seg_fake!=8'h00) seg_timer_reg <= (seg_fake - RTC_BUS);
									else seg_timer_reg <= seg_timer_reg;
									//seg_timer_reg <= (8'h05 - RTC_BUS);
									//seg_timer_reg <= (seg_fake - RTC_BUS);
									
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd8)
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
									
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									if (min_fake!=8'h00) min_timer_reg <= (min_fake - RTC_BUS);
									else min_timer_reg <= min_timer_reg;
									//min_timer_reg <= RTC_BUS;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd9)
								begin
									/*seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;*/
									
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									if (hora_fake!=8'h00) hora_timer_reg <= (hora_fake - RTC_BUS);
									else hora_timer_reg <= hora_timer_reg;
									//hora_timer_reg <= RTC_BUS;
									basura_reg <= basura_reg;
								end
							
/////////////////////////////////////////////// swt2 ///////////////////////////////////////////////////
						end
					else if (estado == 2'b10) // swt 2
						begin
							if((seg_timer_reg==8'h00) & (min_timer_reg==8'h00) &(hora_timer_reg==8'h00)) 
								begin
									seg_fake <= 8'h00;
									min_fake <= 8'h00;
									hora_fake <= 8'h00;
								end
							else 
								begin
									/*if((seg_timer_reg==8'h00) & (min_timer_reg==8'h00) &(hora_timer_reg!=8'h00))
										begin
											seg_fake <= 8'h59 + seg_fake;
											min_fake <= 8'h59;
											hora_fake <= hora_fake - 8'h01;
										end*/
									seg_fake <= seg_fake;
									min_fake <= min_fake;
									hora_fake <= hora_fake;
								end
							if (reg_select == 4'd10)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									
									/*dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;*/
									
									dia_reg <= dia_bot;
									mes_reg <= mes_bot;
									year_reg <= year_bot;
									
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= RTC_BUS;
								end
							else if (reg_select == 4'd1)
								begin
									seg_reg <= RTC_BUS;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									
									/*dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;*/
									
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd2)
								begin
									seg_reg <= seg_reg;
									min_reg <= RTC_BUS;
									hora_reg <= hora_reg;
									
									/*dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;*/
									
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd3)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= RTC_BUS;
									
									/*dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;*/
									
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if ((reg_select == 4'd4) | (reg_select == 4'd5) | (reg_select == 4'd6))
									begin
										seg_reg <= seg_reg;
										min_reg <= min_reg;
										hora_reg <= hora_reg;
										
										/*dia_reg <= dia_reg;
										mes_reg <= mes_reg;
										year_reg <= year_reg;*/
										
										seg_timer_reg <= seg_timer_reg;
										min_timer_reg <= min_timer_reg;
										hora_timer_reg <= hora_timer_reg;
										basura_reg <= basura_reg;
									end
							
							else if (reg_select == 4'd7)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									
									/*dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;*/
									
									if (seg_fake!=8'h00) seg_timer_reg <= (seg_fake - RTC_BUS);
									else seg_timer_reg <= seg_timer_reg;
									//seg_timer_reg <= (8'h05 - RTC_BUS);
									//seg_timer_reg <= (seg_fake - RTC_BUS);
									
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd8)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									
									/*dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;*/
									
									seg_timer_reg <= seg_timer_reg;
									if (min_fake!=8'h00) min_timer_reg <= (min_fake - RTC_BUS);
									else min_timer_reg <= min_timer_reg;
									//min_timer_reg <= RTC_BUS;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd9)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									
									/*dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;*/
									
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									if (hora_fake!=8'h00) hora_timer_reg <= (hora_fake - RTC_BUS);
									else hora_timer_reg <= hora_timer_reg;
									//hora_timer_reg <= RTC_BUS;
									basura_reg <= basura_reg;
								end
									
						end
///////////////////////////////////////////////swt3//////////////////////////////////////////////////////////
					else if (estado == 2'b11)
						begin
							if (reg_select == 4'd10)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= RTC_BUS;
								end
							else if (reg_select == 4'd1)
								begin
									seg_reg <= RTC_BUS;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd2)
								begin
									seg_reg <= seg_reg;
									min_reg <= RTC_BUS;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd3)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= RTC_BUS;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd4)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= RTC_BUS;
									mes_reg <= mes_reg;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd5)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= RTC_BUS;
									year_reg <= year_reg;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if (reg_select == 4'd6)
								begin
									seg_reg <= seg_reg;
									min_reg <= min_reg;
									hora_reg <= hora_reg;
									dia_reg <= dia_reg;
									mes_reg <= mes_reg;
									year_reg <= RTC_BUS;
									seg_timer_reg <= seg_timer_reg;
									min_timer_reg <= min_timer_reg;
									hora_timer_reg <= hora_timer_reg;
									basura_reg <= basura_reg;
								end
							else if ((reg_select == 4'd7) | (reg_select == 4'd8) | (reg_select == 4'd9))
									begin
										seg_reg <= seg_reg;
										min_reg <= min_reg;
										hora_reg <= hora_reg;
										dia_reg <= dia_reg;
										mes_reg <= mes_reg;
										year_reg <= year_reg;
										//seg_timer_reg <= seg_timer_reg;
										seg_timer_reg <= seg_fake;
										//min_timer_reg <= min_timer_reg;
										min_timer_reg <= min_fake;
										//hora_timer_reg <= hora_timer_reg;
										hora_timer_reg <= hora_fake;
										basura_reg <= basura_reg;
										
										seg_fake <= 8'h05;
										min_fake <= 8'h00;
										hora_fake <= 8'h00;
									end
						end
				else
					begin
					seg_reg <= seg_reg;
					min_reg <= min_reg;
					hora_reg <= hora_reg;
					dia_reg <= dia_reg;
					mes_reg <= mes_reg;
					year_reg <= year_reg;
					seg_timer_reg <= seg_timer_reg;
					min_timer_reg <= min_timer_reg;
					hora_timer_reg <= hora_timer_reg;
					basura_reg <= basura_reg;
					seg_fake <= seg_fake;
					min_fake <= min_fake;
					hora_fake <= hora_fake;
					end
			end
	
	assign seg = seg_reg;
	assign min = min_reg;
	assign hora = hora_reg;
	assign dia = dia_reg;
	assign mes = mes_reg;
	assign year = year_reg;
	assign seg_timer = seg_timer_reg;
	assign min_timer = min_timer_reg;
	assign hora_timer = hora_timer_reg;
	assign alarm_of = alarm_of_reg;

endmodule
