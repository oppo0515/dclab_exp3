module SevenSeg(
	out,
	in
);
	output reg [6:0] out;
	input [3:0] in;
	parameter DIG0 = 7'b1000000;
	parameter DIG1 = 7'b1111001;
	parameter DIG2 = 7'b0100100;
	parameter DIG3 = 7'b0110000;
	parameter DIG4 = 7'b0011001;
	parameter DIG5 = 7'b0010010;
	parameter DIG6 = 7'b0000010;
	parameter DIG7 = 7'b1011000;
	parameter DIG8 = 7'b0000000;
	parameter DIG9 = 7'b0010000;
	parameter DIGERR = 7'b1111111;

	always @ (*) begin
		case(in)
			4'd0:
				out = DIG0;
			4'd1:
				out = DIG1;
			4'd2:
				out = DIG2;
			4'd3:
				out = DIG3;
			4'd4:
				out = DIG4;
			4'd5:
				out = DIG5;
			4'd6:
				out = DIG6;
			4'd7:
				out = DIG7;
			4'd8:
				out = DIG8;
			4'd9:
				out = DIG9;
			default:
				out = DIGERR;
		endcase
	end
endmodule
