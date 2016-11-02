`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:36:17 09/22/2016 
// Design Name: 
// Module Name:    swt_control 
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
module swt_control(
	input wire clk, reset,
	input wire [2:0] swt,
	//REGISTROS
	input wire [7:0] seg_reg, min_reg, hora_reg,
	input wire [7:0] dia_reg, mes_reg, year_reg,
	input wire [7:0] seg_timer_reg, min_timer_reg, hora_timer_reg,
	//fin de REGISTROS
	output wire dato, read, EN_signals,
	output wire [7:0] addr_date,	
	output wire [3:0] reg_select,
	output wire [1:0] estado
	//salidas para prueba
	
	/*output wire [5:0] ciclo_pr, cuenta_pr,
	output wire [1:0] cambio_pr,
	output wire EN_ciclo_pr,
	output wire [5:0] duracion_pr,
	output wire inicializacion_pr,
	output wire [2:0] ruta*/
	
    );
		
	reg dato_reg, read_reg , EN_signals_reg;
	reg [7:0] addr_date_reg;
	reg [3:0] reg_select_reg;
	reg [1:0] estado_reg;
	
	reg [1:0] cambio;
	reg [2:0] ruta_reg;
	//banderas
	reg primer_eva;
	reg inicializacion;
	reg timer_bn;
	
	//señales de ciclo_ruta
	reg EN_ciclo;
	reg [5:0] duracion;
	wire [5:0] ciclo; 
	wire [4:0] cuenta_int;
	
	ciclo_rtc ciclo_ruta(.clk(clk), .reset(reset), .EN_ciclo(EN_ciclo), .duracion(duracion), .ciclo(ciclo), .cuenta_int(cuenta_int));
	
	
	always @(posedge clk, posedge reset)
		if (reset)
			begin
				dato_reg <= 1'b0;
				read_reg <= 1'b0;
				EN_signals_reg <= 1'b0;
				addr_date_reg <= 8'h00;
				EN_ciclo <= 1'b0;
				cambio <= 2'b0;
				ruta_reg <= 3'b000;
				primer_eva <= 1'b0;
				inicializacion <= 1'b1;
				reg_select_reg <= 4'd0;
				estado_reg <= 2'd0;
				duracion <= 6'd0;
				timer_bn <= 1'b0;
			end
		else
			begin
				case (swt)
					3'b000 : cambio <= cambio;
					3'b001 : cambio <= 2'b01;
					3'b010 : cambio <= 2'b10;
					3'b100 : cambio <= 2'b11;
					default : cambio <= cambio;
				endcase
				EN_ciclo <= 1'b1;
///////////////////////////////////inicializacion//////////////////////////////////////////////////////
				if (inicializacion)
					begin
						duracion <= 6'd37;
						if (ciclo == 6'd0 & cuenta_int == 6'd0 & primer_eva == 1'b0) primer_eva <=1'b1; // genero retraso necesario de un ciclo
						if (ciclo == 6'd0 & cuenta_int == 6'd0 & primer_eva == 1'b1)
							begin
								EN_signals_reg <= 1'b1;
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h02; // mandando direccion a status 02
							end
						else if (ciclo == 6'd0 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h10; // 8'b0001000 en bit de inicializacion 
							end
						else if (ciclo == 6'd1 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h02; // mandando direccion a status 02
							end	
						else if (ciclo == 6'd2 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //8'b0000000 en bit de inicializacion
							end				
						else if (ciclo == 6'd3 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h10; //enviando direccion 10 
							end	
						else if (ciclo == 6'd4 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'hD2; //enviando dato D2
							end
						else if (ciclo == 6'd5 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //envio direccion estatus 00
							end
						else if (ciclo == 6'd6 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //envio 00 se limpia time set lock y frecuency bit
							end
						else if (ciclo == 6'd7 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h20; //enviando direccion 20 1/100 seg
							end
						else if (ciclo == 6'd8 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd9 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h21; //enviando direccion 21 seg
							end
						else if (ciclo == 6'd10 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd11 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h22; //enviando direccion 22 min
							end
						else if (ciclo == 6'd12 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd13 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h23; //enviando direccion 23 hora
							end
						else if (ciclo == 6'd14 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd15 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h24; //enviando direccion 24 dia
							end
						else if (ciclo == 6'd16 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd17 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h25; //enviando direccion 25 mes
							end
						else if (ciclo == 6'd18 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd19 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h26; //enviando direccion 26 año
							end
						else if (ciclo == 6'd20 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd21 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h27; //enviando direccion 27 dia de la semana
							end
						else if (ciclo == 6'd22 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd23 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h28; //enviando direccion 28 numero de semana
							end
						else if (ciclo == 6'd24 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd25 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'hF1; //enviando direccion de comando f1
							end
						else if (ciclo == 6'd26 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								//addr_date_reg <= 8'h00; // transfiriendo datos a la reserva
							end
						/////////////////////////////////////////////////////////////////
						else if (ciclo == 6'd27 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h41; //enviando direccion 26 año
							end
						else if (ciclo == 6'd28 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd29 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h42; //enviando direccion 27 dia de la semana
							end
						else if (ciclo == 6'd30 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd31 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h43; //enviando direccion 28 numero de semana
							end
						else if (ciclo == 6'd32 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								addr_date_reg <= 8'h00; //escribiendo 00
							end
						else if (ciclo == 6'd33 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b0;
								read_reg <= 1'b0;
								addr_date_reg <= 8'hF2; //enviando direccion de comando f1
							end
						else if (ciclo == 6'd34 & cuenta_int == 6'd31)
							begin
								dato_reg <= 1'b1;
								read_reg <= 1'b0;
								//addr_date_reg <= 8'h00; // transfiriendo datos a la reserva
							end
						////////////////////////////////////////////////////////////////
						else if (ciclo == 6'd35 & cuenta_int == 6'd31)
							begin
								EN_signals_reg <= 1'b0;
							end
						else if (ciclo == 6'd36 & cuenta_int == 6'd29) 
							begin
							inicializacion <= 1'b0; 
							ruta_reg <= 3'b000;
							timer_bn <=1'b0;
							end
					end
//////////////////////////////////////evaluacion de swt//////////////////////////////////////
				else 
					begin
						if ((ciclo == (duracion-1) & cuenta_int == (6'd30))) // se evalua en cuenta_int para adelantar dato ruta un ciclo
							begin
								if ((seg_timer_reg==8'h00) & (min_timer_reg==8'h00) & (hora_timer_reg==8'h00) & (timer_bn==1'b1)) ruta_reg <= 3'b101;
								else if ((swt == 3'b000 & cambio == 2'b00) | (swt != 3'b000 & cambio != 2'b00))
									begin
										ruta_reg <= 3'b001;
										if (swt == 3'b000) estado_reg <= 2'b00;
										else if (swt == 3'b001) estado_reg <= 2'b01;
										else if (swt == 3'b010) estado_reg <= 2'b10;
										else if (swt == 3'b100) estado_reg <= 2'b11;
									end
								else if (swt == 3'b000 & cambio != 2'b00)
									begin
										if (cambio == 2'b01) ruta_reg <= 3'b010;
										else if (cambio == 2'b10) ruta_reg <= 3'b011;
										else if (cambio == 2'b11) ruta_reg <= 3'b100;
									end
							end
						else
							begin
								ruta_reg <= ruta_reg;
								duracion <= duracion;
							end					
//////////////////////////////evaluacion de rutas///////////////////////////////////////////////
///////////////////////////////// ruta 1. Solo lectura//////////////////////////////////////////
						if (ruta_reg == 3'b001)
							begin
								EN_signals_reg <= 1'b1; 
								duracion <= 6'd20; 
								if (ciclo == (duracion-1) & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'hF0; // se escribe direccion comando hF1 
									end
								else if (ciclo == 6'd0 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se pasan datos de reserva a ram
										reg_select_reg <= 4'd10; // basura_reg
									end
								else if (ciclo == 6'd1 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h21; // se escribe direccion de segundos h21
									end
								else if (ciclo == 6'd2 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se leen los segundos
										reg_select_reg <= 4'd1; // seg_reg
									end
								else if (ciclo == 6'd3 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h22; // se escribe direccion de minutos h22
									end
								else if (ciclo == 6'd4 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se leen los minutos
										reg_select_reg <= 4'd2; // min_reg
									end
								else if (ciclo == 6'd5 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h23; // se escribe direccion de hora h23
									end
								else if (ciclo == 6'd6 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se lee la hora
										reg_select_reg <= 4'd3; // hora_reg
									end	
								else if (ciclo == 6'd7 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h24; // se escribe direccion de dia h24
									end
								else if (ciclo == 6'd8 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se lee el dia
										reg_select_reg <= 4'd4; // dia_reg
									end
								else if (ciclo == 6'd9 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h25; // se escribe direccion de mes h25
									end
								else if (ciclo == 6'd10 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se lee el mes
										reg_select_reg <= 4'd5; // mes_reg
									end
								else if (ciclo == 6'd11 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h26; // se escribe direccion de año h26
									end
								else if (ciclo == 6'd12 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se lee el año
										reg_select_reg <= 4'd6; // year_reg
									end
								else if (ciclo == 6'd13 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h41; // se escribe direccion de seg_timer
									end
								else if (ciclo == 6'd14 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se leen los seg_timer
										reg_select_reg <= 4'd7; // seg_timer_reg
									end
								else if (ciclo == 6'd15 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h42; // se escribe direccion de min_timer
									end
								else if (ciclo == 6'd16 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se leen los min_timer
										reg_select_reg <= 4'd8; // min_timer_reg
									end
								else if (ciclo == 6'd17 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h43; // se escribe direccion de hora_timer
									end
								else if (ciclo == 6'd18 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b1; // se lee la hora_timer
										reg_select_reg <= 4'd9; // hora_timer_reg
									end
							end
//////////////////////////ruta 2. Se escribe hora min y seg/////////////////////////////////////////////
						else if (ruta_reg == 3'b010)
							begin
								duracion <= 6'd8;
								if (ciclo == (duracion-1) & cuenta_int ==6'd31)
									begin
										cambio <= 2'b00;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h21; // se escribe direccion de segundos h21
									end
								else if (ciclo == 6'd0 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= seg_reg; // se escribe dato de segundos
									end
								else if (ciclo == 6'd1 & cuenta_int ==6'd31)
									begin
										cambio <= 2'b00;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h22; // se escribe direccion de minutos h22
									end
								else if (ciclo == 6'd2 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= min_reg; // se escribe dato de minutos
									end
								else if (ciclo == 6'd3 & cuenta_int ==6'd31)
									begin
										cambio <= 2'b00;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h23; // se escribe direccion de hora h23
									end
								else if (ciclo == 6'd4 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= hora_reg; // se escribe dato de hora
									end
								else if (ciclo == 6'd5 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'hF1; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd6 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
									end
							end
///////////////////////////ruta 3. Se escribe dia mes año////////////////////////////////////////////
						else if (ruta_reg == 3'b011)
							begin
								duracion <= 6'd8;
								if (ciclo == (duracion-1) & cuenta_int ==6'd31)
									begin
										cambio <= 2'b00;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h24; // se escribe direccion de dia h24
									end
								else if (ciclo == 6'd0 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= dia_reg; // se escribe dato de dia
									end
								else if (ciclo == 6'd1 & cuenta_int ==6'd31)
									begin
										cambio <= 2'b00;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h25; // se escribe direccion de mes h25
									end
								else if (ciclo == 6'd2 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= mes_reg; // se escribe dato de mes
									end
								else if (ciclo == 6'd3 & cuenta_int ==6'd31)
									begin
										cambio <= 2'b00;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h26; // se escribe direccion de año h26
									end
								else if (ciclo == 6'd4 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= year_reg; // se escribe dato de hora
									end
								else if (ciclo == 6'd5 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'hF1; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd6 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
									end
							end
//////////////////////////////ruta 4. Se escribe timer//////////////////////////////////////////////////
						else if (ruta_reg == 3'b100)
							begin
								duracion <= 6'd6;
								timer_bn <= 1'b1;
								if (ciclo == (duracion-1) & cuenta_int ==6'd31)
									begin
										cambio <= 2'b00;
										EN_signals_reg <= 1'b1;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h41; // mandando direccion a status 02
									end
								else if (ciclo == 6'd0 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h00; // 8'b0001000 en bit de inicializacion 
									end
								else if (ciclo == 6'd1 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'hF2; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd2 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
										//addr_date_reg <= 8'h00;
									end
								else if (ciclo == 6'd3 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h00; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd4 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
										addr_date_reg <= 8'h08;
									end
							end
							/////////////////////////////////////////////////////
						else if (ruta_reg == 3'b101)
							begin
								duracion <= 6'd10;
								timer_bn <= 1'b0;
								if (ciclo == (duracion-1) & cuenta_int ==6'd31)
									begin
										EN_signals_reg <= 1'b1;
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h00; // mandando direccion a status 02
									end
								else if (ciclo == 6'd0 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h00; // 8'b0001000 en bit de inicializacion 
									end
								else if (ciclo == 6'd1 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h41; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd2 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
										addr_date_reg <= 8'h00;
									end
								else if (ciclo == 6'd3 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h42; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd4 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
										addr_date_reg <= 8'h00;
									end
								else if (ciclo == 6'd5 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'h43; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd6 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
										addr_date_reg <= 8'h00;
									end
								else if (ciclo == 6'd7 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b0;
										read_reg <= 1'b0;
										addr_date_reg <= 8'hF2; // se escribe direccion de comando de clock hF1
									end
								else if (ciclo == 6'd8 & cuenta_int == 6'd31)
									begin
										dato_reg <= 1'b1;
										read_reg <= 1'b0; // se pasan datos de ram a reserva
										//addr_date_reg <= 8'h00;
									end
							end
					end
			end
					
	assign dato = dato_reg;
	assign read = read_reg;
	assign EN_signals = EN_signals_reg;
	assign addr_date = addr_date_reg;
	assign reg_select = reg_select_reg;
	assign estado = estado_reg;
	// assigns de prueba
	/*assign ruta = ruta_reg;
	assign ciclo_pr = ciclo;
	assign cuenta_pr = cuenta_int;
	assign cambio_pr = cambio;
	assign EN_ciclo_pr = EN_ciclo;
	assign duracion_pr = duracion;
	assign inicializacion_pr = inicializacion;*/

endmodule
