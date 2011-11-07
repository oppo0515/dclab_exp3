`define DIG0 7'b1000000;
`define DIG1 7'b1111001;
`define DIG2 7'b0100100;
`define DIG3 7'b0110000;
`define DIG4 7'b0011001;
`define DIG5 7'b0010010;
`define DIG6 7'b0000010;
`define DIG7 7'b1011000;
`define DIG8 7'b0000000;
`define DIG9 7'b0010000;
`define DIGERR 7'b1111111;

module SevenSeg32(
	out10,
	out1,
	in
);
	output reg [6:0] out10;
	output reg [6:0] out1;
	input [4:0] in;
	case(in)
		5'd0 : begin out10 = DIG0; out1 = DIG0; end
		5'd1 : begin out10 = DIG0; out1 = DIG1; end
		5'd2 : begin out10 = DIG0; out1 = DIG2; end
		5'd3 : begin out10 = DIG0; out1 = DIG3; end
		5'd4 : begin out10 = DIG0; out1 = DIG4; end
		5'd5 : begin out10 = DIG0; out1 = DIG5; end
		5'd6 : begin out10 = DIG0; out1 = DIG6; end
		5'd7 : begin out10 = DIG0; out1 = DIG7; end
		5'd8 : begin out10 = DIG0; out1 = DIG8; end
		5'd9 : begin out10 = DIG0; out1 = DIG9; end
		5'd10: begin out10 = DIG1; out1 = DIG0; end
		5'd11: begin out10 = DIG1; out1 = DIG1; end
		5'd12: begin out10 = DIG1; out1 = DIG2; end
		5'd13: begin out10 = DIG1; out1 = DIG3; end
		5'd14: begin out10 = DIG1; out1 = DIG4; end
		5'd15: begin out10 = DIG1; out1 = DIG5; end
		5'd16: begin out10 = DIG1; out1 = DIG6; end
		5'd17: begin out10 = DIG1; out1 = DIG7; end
		5'd18: begin out10 = DIG1; out1 = DIG8; end
		5'd19: begin out10 = DIG1; out1 = DIG9; end
		5'd20: begin out10 = DIG2; out1 = DIG0; end
		5'd21: begin out10 = DIG2; out1 = DIG1; end
		5'd22: begin out10 = DIG2; out1 = DIG2; end
		5'd23: begin out10 = DIG2; out1 = DIG3; end
		5'd24: begin out10 = DIG2; out1 = DIG4; end
		5'd25: begin out10 = DIG2; out1 = DIG5; end
		5'd26: begin out10 = DIG2; out1 = DIG6; end
		5'd27: begin out10 = DIG2; out1 = DIG7; end
		5'd28: begin out10 = DIG2; out1 = DIG8; end
		5'd29: begin out10 = DIG2; out1 = DIG9; end
		5'd30: begin out10 = DIG3; out1 = DIG0; end
		5'd31: begin out10 = DIG3; out1 = DIG1; end
	endcase
endmodule

module SevenSeg(
	out,
	in
);
	output reg [6:0] out;
	input [3:0] in;

	always @ (*) begin
		case(in)
			4'd0: out = `DIG0;
			4'd1: out = `DIG1;
			4'd2: out = `DIG2;
			4'd3: out = `DIG3;
			4'd4: out = `DIG4;
			4'd5: out = `DIG5;
			4'd6: out = `DIG6;
			4'd7: out = `DIG7;
			4'd8: out = `DIG8;
			4'd9: out = `DIG9;
			default: out = `DIGERR;
		endcase
	end
endmodule

module Display(
	inTime,
	inRate,
	IS_SLOW,
	IS_RECORD,
	IS_PAUSE,

	SEVEN10,
	SEVEN1,
	PAUSE,
	REC,
	SLOW,
	NOT_USED,
	INTERP
);
	input [4:0] inTime;
	input [2:0] inRate;
	input IS_SLOW_SW;
	input RECORD_SW;
	input NORMAL_SPEED_SW;
	input INTERP_SW;
	input IS_PAUSE;
	output [6:0] SEVEN10,
	output [6:0] SEVEN1,
	output [6:0] PAUSE,
	output [6:0] RATIO,
	output [6:0] REC,
	output [6:0] SLOW,
	output [6:0] NOT_USED,
	output [6:0] INTERP

	assign IS_PAUSE = (pause? 7'hc: 7'h7f);     // P/nil
	assign IS_REC = (RECORD_SW? 7'h12: 7'h47);  // S/L
	assign IS_SLOW = (IS_SLOW_SW? 7'h12: 7'h0e);// S/F
	assign NOT_USED = 7'h7f;
	assign INTERP = (INTERP_SW? 7'h79: 7'h40);  // 1/0
	SevenSeg32(.in(inTime), .out10(SEVEN10), .out1(SEVEN1));
	SevenSeg ss1(.in(inRate), .out(RATIO));
endmodule

