`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:17:25 09/23/2016 
// Design Name: 
// Module Name:    fsm_master 
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
module fsm_master(
	inout wire [7:0] RTC_BUS,
	input wire clk, reset,
	input wire [2:0] SWT,
	input wire swt4,
	input wire arriba, abajo, der, izq, 
	//salidas
	output wire CS,AD,WR,RD, 
 // vga
	output wire pixel_xlast, pixel_ylast,
	output wire [2:0] rgb_text,
	output wire hsync, vsync
	// fin vga
    );
	 
	 
	//reg [7:0] seg_reg;
	// realmente se ocupan
	wire dato, read, EN_signals;
	wire [7:0] addr_date;
	wire csu, wru, rdu, adu, ssu, llu;
	wire [2:0] ruta;
	wire [3:0] reg_select;
	wire [1:0] estado;
	wire [7:0] seg, min, hora;
	wire [7:0] dia, mes, year;
	wire [7:0] seg_timer, min_timer, hora_timer;
	
	wire [7:0] seg_bot, min_bot, hora_bot, dia_bot, mes_bot, year_bot;
	wire bot_ar, bot_ab, bot_der, bot_izq;
	
	//// vga
	wire video_on, pixel_tick;
	wire [9:0] pixel_x, pixel_y;
	reg [2:0] rgb_reg;
	wire [2:0] rgb_next;
	/// fin vga
	
	//salidas para prueba
	wire [5:0] ciclo_pr;
	wire [4:0] cuenta_pr;
	wire [1:0] cambio_pr;
	wire EN_ciclo_pr;
	wire [5:0] duracion_pr;
	wire inicializacion_pr;
	wire alarm_of;
	//wire activador_cuenta_signalspr;
	//wire [4:0] cuenta_signalspr; 

	Rebote rebotes(.clk(clk), .reset(reset), .arriba(arriba), .abajo(abajo), .der(der), .izq(izq), .bot_ar(bot_ar), .bot_ab(bot_ab), .bot_der(bot_der), .bot_izq(bot_izq));
	
	Botones boton (.clk(clk), .reset(reset), .estado(estado), .bot_izq(bot_izq), .bot_der(bot_der), .bot_ar(bot_ar), .bot_ab(bot_ab), 
	.seg_reg(seg), .min_reg(min), .hora_reg(hora), .dia_reg(dia), .mes_reg(mes), .year_reg(year), .seg_bot(seg_bot), .min_bot(min_bot), .hora_bot(hora_bot), .dia_bot(dia_bot), .mes_bot(mes_bot), .year_bot(year_bot));
	
	swt_control swt(.clk(clk), .reset(reset), .swt(SWT), .seg_reg(seg), .min_reg(min), .hora_reg(hora), .dia_reg(dia), .mes_reg(mes), .year_reg(year), .seg_timer_reg(seg_timer), .min_timer_reg(min_timer), .hora_timer_reg(hora_timer), .dato(dato), .read(read), .EN_signals(EN_signals), .addr_date(addr_date), .reg_select(reg_select), .estado(estado)/*, .ruta(ruta),
	.ciclo_pr(ciclo_pr), .cuenta_pr(cuenta_pr), .cambio_pr(cambio_pr), .EN_ciclo_pr(EN_ciclo_pr), .duracion_pr(duracion_pr), .inicializacion_pr(inicializacion_pr)*/);
	
	signals_rtc signals(.clk(clk), .reset(reset), .EN_signals(EN_signals), .read(read), .dato(dato), .CS(csu), .WR(wru), .RD(rdu), .AD(adu), .SS(ssu), .LL(llu)
	/*.activador_cuenta_pr(activador_cuenta_signalspr),*/ /*.cuenta_pr(cuenta_signalspr)*/);
	
	buffer triestado(.RTC_BUS(RTC_BUS), .EN_SS(ssu), .in(addr_date));
	
	prueba_registros registro(.clk(clk), .reset(reset), .LL_signal(llu), .swt4(swt4), .RTC_BUS(RTC_BUS), .reg_select(reg_select), .estado(estado), .seg_bot(seg_bot), .min_bot(min_bot), .hora_bot(hora_bot), .dia_bot(dia_bot), .mes_bot(mes_bot), .year_bot(year_bot), .seg(seg), .min(min), .hora(hora), .dia(dia), .mes(mes), .year(year), .seg_timer(seg_timer), .min_timer(min_timer), .hora_timer(hora_timer), .alarm_of(alarm_of));
//// vga 	
	VGA_sync vsync_prueba(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .video_on(video_on), .p_tick(pixel_tick), .pixel_x(pixel_x), .pixel_y(pixel_y));	
	 
	VGA_text vtext_unit (.clk(clk), .video_on(video_on), .alarm_of(alarm_of), .pixel_x(pixel_x), .pixel_y(pixel_y), .seg_reg(seg), .min_reg(min), .hora_reg(hora), .dia_reg(dia), .mes_reg(mes), .year_reg(year), .seg_timer_reg(seg_timer), .min_timer_reg(min_timer), .hora_timer_reg(hora_timer), .rgb_text(rgb_next), .pixel_xlast(pixel_xlast), .pixel_ylast(pixel_ylast));
	
	always @(posedge clk)
		if (pixel_tick)
			rgb_reg <= rgb_next;

	assign rgb_text = rgb_reg;
//// fin vga	
	assign CS = csu;
	assign AD = adu;
	assign WR = wru;
	assign RD = rdu;

endmodule
