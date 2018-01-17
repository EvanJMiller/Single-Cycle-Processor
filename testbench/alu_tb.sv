/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "alu_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif ();
  // test program
  test PROG (CLK, aluif.tb);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.portA (aluif.portA),
    .\aluif.portB (aluif.portB),
    .\aluif.aluop (aluif.aluop),
    .\aluif.result (aluif.result),
    .\aluif.neg (aluif.neg),
    .\aluif.ovf (aluif.ovf),
    .\aluif.zero (aluif.zero)    
       
  );
`endif // !`ifndef MAPPED
endmodule
   
program test(
input logic CLK,	     
aluif.tb aluif
	     );
   
initial
  begin
     aluif.portA = 32'b0;
     aluif.portB = 32'b1;
     @(posedge CLK);
     
     
  end
 
endprogram
