module Sram2Codec(
	dataStream,
	dataOut,
	dataIn,
	addrIn,
	write,
	read,
	on,
	clk,
	_WE,
	_CE,
	_OE,
	_LB,
	_UB,
	_Addr
);

	inout [15:0] dataStream;

	input write, read, on, clk;
	input [15:0] dataIn;
	input [17:0] addrIn;

	output reg _WE, _CE, _OE, _LB, _UB;
	output [15:0] dataOut;
	output [17:0] _Addr;

	assign _Addr = addrIn;

	always @(posedge clk) begin
		// Read
		dataOut = 16'bxxxxxxxxxxxxxxxx;
		dataStream = 16'bzzzzzzzzzzzzzzzz;
		_WE = 1'b0;
		_CE = 1'b0;
		_OE = 1'bx;
		_LB = 1'b0;
		_UB = 1'b0;

		if (read) begin
			_WE = 1'b1;
			_OE = 1'b0;
			dataOut = dataStraem;
		end

		// Write
		if (write) begin
			dataStraem = dataIn;
		end

		// Off
		if (~on) begin
			_CE = 1'b1;
		end
	end
endmodule
