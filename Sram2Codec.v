module Sram2Codec(
  dataStream, 
  _LBIn, 
  _UBIn, 
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
  inout [7:0] _LBIn, _UBIn;

  input write, read, on, clk;
  input [17:0] addrIn;

  output reg _WE, _CE, _OE, _LB, _UB;
  output [17:0] _Addr;

  reg reg_write, reg_read, reg_on;
  reg [17:0] reg_addrIn;

  reg [7:0] high;

  reg [15:0] reg_DS, out_DS;
  reg [7:0] reg_LB, reg_UB, out_LB, out_UB;

  assign _Addr[17:0] = reg_addrIn[17:0];


  always @(posedge clk) begin

// Read
    if (read) begin
      _WE = 1'b1;
      _CE = 1'b0;
      _OE = 1'b0;
      _LB = 1'b0;
      _UB = 1'b0;
      reg_DS[7:0]  = _LBIn[7:0];
      reg_DS[15:8] = _UBIn[7:0];
    end

// Write
    if (write) begin
      _WE = 1'b0;
      _CE = 1'b0;
      _OE = 1'bx;
      _LB = 1'b0;
      _UB = 1'b0;
      reg_LB[7:0] = dataStream[7:0];
      reg_UB[7:0] = dataStream[15:8];
    end

// Off
    if (~on) begin
      _CE = 1'b1;
      reg_LB[7:0] = 8'bzzzzzzzz;
      reg_UB[7:0] = 8'bzzzzzzzz;
    end



  end

  assign _LBIn[7:0] = out_LB[7:0];
  assign _UBIn[7:0] = out_UB[7:0];
  assign dataStream[15:0] = out_DS[15:0];

  always @(negedge clk) begin

    if (write) begin
      out_LB[7:0] = reg_LB[7:0];
      out_UB[7:0] = reg_UB[7:0];
      out_DS[15:0] = 15'bzzzzzzzzzzzzzzz;
    end

    if (read) begin
      out_LB[7:0] = 8'bzzzzzzzz;
      out_UB[7:0] = 8'bzzzzzzzz;
      out_DS[15:0] = reg_DS[15:0];
    end

    if ( (write && read) || (~write && ~read) ) begin
      out_LB[7:0] = 8'bzzzzzzzz;
      out_UB[7:0] = 8'bzzzzzzzz;
      out_DS[15:0] = 15'bzzzzzzzzzzzzzzz;
    end



  end


endmodule

