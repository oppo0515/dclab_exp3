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
	// seven seg.
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6
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
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6;

	inout [15:0] SRAM_DATA;

	wire pause;
	wire ratio = (NORMAL_SPEED_SW? 3'h1: RATIO_SW + 3'h1);

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

	Codec cd1(
		// TODO
		AUD_BCLK,       //audio
		AUD_DACLRCK,    //audio
		AUD_DACDAT,     //audio
		fast,           //control
		rate,           //control
		stop,			//control
		addr_fr_sram,   //sram
		data_fr_sram,   //sram
		read,           //sram
		AUD_ADCLRCK,    //audio
		AUD_ADCDAT,     //audio
		record,         //control
		stop,			//control
		addr_to_sram,   //sram
		data_to_sram,   //sram
		write           //sram
	);

	Display d1(
		.inTime(SRAM_ADDR[17:13]),
		.inRate(ratio),
		.IS_SLOW(IS_SLOW_SW),
		.IS_RECORD(RECORD_SW),
		.IS_PAUSE(pause),

		.SEVEN10(HEX6),
		.SEVEN1(HEX5),
		.PAUSE(HEX4),
		.REC(HEX3),
		.SLOW(HEX2),
		.NOT_USED(HEX1),
		.INTERP(HEX0)
	);

endmodule
