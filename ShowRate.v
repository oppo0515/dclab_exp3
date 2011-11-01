module showRate (
  _in[3:0], 
  dec0[3:0]
);

  input [3:0] _in;
  output [3:0] dec0;
  reg [3:0] dec0;

  always @(*) begin
    case(_in)
      6'd1:
        dec0 = 4'd1;
      6'd2:
        dec0 = 4'd2;
      6'd3:
        dec0 = 4'd3;
      6'd4:
        dec0 = 4'd4;
      6'd5:
        dec0 = 4'd5;
      6'd6:
        dec0 = 4'd6;
      6'd7:
        dec0 = 4'd7;
      6'd8:
        dec0 = 4'd8;
      default:
        dec0 = 4'd0;
    endcase
  end


endmodule
