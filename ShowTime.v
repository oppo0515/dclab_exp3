module showTime (
  _in[5:0], 
  dec1[3:0], 
  dec0[3:0]
);

  input [5:0] _in;
  output [3:0] dec1;
  output [3:0] dec0;
  reg [3:0] dec1;
  reg [3:0] dec0;

  always @(*) begin
    case(_in)
      6'd0:
        begin dec1 = 4'd0; dec0 = 4'd0; end
      6'd1:
        begin dec1 = 4'd0; dec0 = 4'd1; end
      6'd2:
        begin dec1 = 4'd0; dec0 = 4'd2; end
      6'd3:
        begin dec1 = 4'd0; dec0 = 4'd3; end
      6'd4:
        begin dec1 = 4'd0; dec0 = 4'd4; end
      6'd5:
        begin dec1 = 4'd0; dec0 = 4'd5; end
      6'd6:
        begin dec1 = 4'd0; dec0 = 4'd6; end
      6'd7:
        begin dec1 = 4'd0; dec0 = 4'd7; end
      6'd8:
        begin dec1 = 4'd0; dec0 = 4'd8; end
      6'd9:
        begin dec1 = 4'd0; dec0 = 4'd9; end
      6'd10:
        begin dec1 = 4'd1; dec0 = 4'd0; end
      6'd11:
        begin dec1 = 4'd1; dec0 = 4'd1; end
      6'd12:
        begin dec1 = 4'd1; dec0 = 4'd2; end
      6'd13:
        begin dec1 = 4'd1; dec0 = 4'd3; end
      6'd14:
        begin dec1 = 4'd1; dec0 = 4'd4; end
      6'd15:
        begin dec1 = 4'd1; dec0 = 4'd5; end
      6'd16:
        begin dec1 = 4'd1; dec0 = 4'd6; end
      6'd17:
        begin dec1 = 4'd1; dec0 = 4'd7; end
      6'd18:
        begin dec1 = 4'd1; dec0 = 4'd8; end
      6'd19:
        begin dec1 = 4'd1; dec0 = 4'd9; end
      6'd20:
        begin dec1 = 4'd2; dec0 = 4'd0; end
      6'd21:
        begin dec1 = 4'd2; dec0 = 4'd1; end
      6'd22:
        begin dec1 = 4'd2; dec0 = 4'd2; end
      6'd23:
        begin dec1 = 4'd2; dec0 = 4'd3; end
      6'd24:
        begin dec1 = 4'd2; dec0 = 4'd4; end
      6'd25:
        begin dec1 = 4'd2; dec0 = 4'd5; end
      6'd26:
        begin dec1 = 4'd2; dec0 = 4'd6; end
      6'd27:
        begin dec1 = 4'd2; dec0 = 4'd7; end
      6'd28:
        begin dec1 = 4'd2; dec0 = 4'd8; end
      6'd29:
        begin dec1 = 4'd2; dec0 = 4'd9; end
      6'd30:
        begin dec1 = 4'd3; dec0 = 4'd0; end
      6'd31:
        begin dec1 = 4'd3; dec0 = 4'd1; end
      default:
        begin dec1 = 4'd9; dec0 = 4'd9; end
    endcase
  end


endmodule
