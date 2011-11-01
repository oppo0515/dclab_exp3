module display( 
         inTime[5:0],
         inRate[3:0],
         sevsr [6:0],
         sevmt1[6:0],
         sevmt0[6:0]
);

  input [5:0] inTime;
  input [3:0] inRate;
  output [6:0] sevsr, sevmt1, sevmt0;

  wire [3:0] mt0, mt1, mr;
  wire [6:0] sevsr, sevmt1, sevmt0;


  showTime st(inTime, mt1, mt0);
  showRate sr(inRate, mr);

  SevenSeg mrate(sevsr, mr);
  SevenSeg mtime1(sevmt1, mt1);
  SevenSeg mtime0(sevmt0, mt0);











endmodule

