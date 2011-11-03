module Main(
	CLK50,
	PAUSE_KEY,
	STOP_KEY,
	RATIO_SW,
	RECORD_SW,
	INTERP_SW,
	NORMAL_SPEED_SW,
	IS_SLOW_SW,
	ADCLRCK,
	ADCDAT,
	DACLRCK,
	BCLK,
	MCLK,
	I2C_SCLK,
	I2C_SDAT,
	DACDAT,
	SRAM_ADDR,
	SRAM_WE,
	SRAM_OE,
	SRAM_UB,
	SRAM_LB,
	SRAM_CE,
	SRAM_DATA,
	IS_PAUSE,
	RATIO,
	IS_REC,
	IS_SLOW,
	HEX1,
	HEX0
);
	input CLK50;
	input PAUSE_KEY;
	input STOP_KEY;
	input [2:0] RATIO_SW;
	input RECORD_SW;
	input INTERP_SW;
	input IS_SLOW_SW;
	input NORMAL_SPEED_SW;
	input ADCLRCK;
	input ADCDAT;
	input DACLRCK;
	input BCLK;

	output MCLK;
	output I2C_SCLK;
	output I2C_SDAT;
	output DACDAT;
	output [17:0] SRAM_ADDR;
	output SRAM_WE;
	output SRAM_OE;
	output SRAM_UB;
	output SRAM_LB;
	output SRAM_CE;
	output [6:0] IS_PAUSE;
	output [6:0] RATIO;
	output [6:0] IS_REC;
	output [6:0] IS_SLOW;
	output [6:0] HEX1;
	output [6:0] HEX0;

	inout [15:0] SRAM_DATA;

	wire pause;
	State s1(
		.CLK50(CLK50),
		.KEY(PAUSE_KEY),
		.state(pause)
	);

	Clock c1(
		.CLK50(CLK50),
		.ratio(RATIO_SW),
		.isNormalSpeed(NORMAL_SPEED_SW),
		.isSlow(IS_SLOW_SW),
		.interp(INTERP_SW),
		.pause(pause),
		.isRecord(RECORD_SW),
		.clkOut(MCLK)
	);
	assign IS_PAUSE = (pause? 7'hc: 7'h7f);
	assign IS_REC = (RECORD_SW? 7'h12: 7'h47);
	assign IS_SLOW = (IS_SLOW_SW? 7'h12: 7'h0e);
	assign HEX1 = 7'h7f;
	assign HEX0 = 7'h7f;
	wire [3:0] ratio_bin;
	assign ratio_bin = 
	(NORMAL_SPEED_SW? 3'h1: RATIO_SW + 3'h1);
	SevenSeg ss1(.in(ratio_bin), .out(RATIO));
endmodule
