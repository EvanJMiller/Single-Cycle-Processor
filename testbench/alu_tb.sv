/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "alu_if.vh"
`include "cpu_types_pkg.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

import cpu_types_pkg::*; //for ALU cases
   
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
alu_if.tb aluif
);
   
initial
  begin
     $display("\n ADD \n");
     test_ADD();
     $display("\n SUB \n");
     test_SUB();
      $display("\n AND \n");
     test_AND();
     $display("\n OR \n");     
     test_OR();
     $display("\n SLL \n");
     test_SLL();
     $display("\n SRL \n");
     test_SRL();
     $display("\n XOR \n");
     test_XOR();
     $display("\n NOR \n");
     test_NOR();
     $display("\n SLT \n");
     test_SLT();
     $display("\n SLT \n");
     test_SLTU();
     
     
     
     
     
     
     
     
     
     
end
     
   
   task test_ADD();
     
	aluif.portA = 32'h5;
	aluif.portB = 32'h5;
	aluif.aluop = ALU_ADD;
	@(posedge CLK); // 5 + 5
	$display("#1 A:%d B: %d OP: ADD Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );
	
	aluif.portA = 32'hfffffff0;
	aluif.portB = 32'hfffffff0;
	aluif.aluop = ALU_ADD;
	@(posedge CLK); 
	$display("#2 A:%d B: %d OP: ADD Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );

	aluif.portA = 32'h7fffffff;
	aluif.portB = 32'h7fffffff;
	aluif.aluop = ALU_ADD;
	@(posedge CLK); // -5 + -10
	$display("#3 A:%d B: %d OP: ADD Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );


	aluif.portA = 32'h8000000a;
	aluif.portB = 32'h8000000b;
	aluif.aluop = ALU_ADD;
	@(posedge CLK);
	$display("#4 A:%d B: %d OP: ADD Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );

		
	aluif.portA = 32'hfffffff0;
	aluif.portB = 32'h10;
	aluif.aluop = ALU_ADD;
	@(posedge CLK); // -5 + -10
	$display("#5 A:%d B: %d OP: ADD Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );

     endtask

     task test_SUB();
     
	aluif.portA = 32'h5;
	aluif.portB = 32'h5;
	aluif.aluop = ALU_SUB;
	@(posedge CLK); // 5 + 5
	$display("#6 A:%d B: %d OP: SUB Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );
	
	aluif.portA = 32'h8000000a;
	aluif.portB = 32'h7fffffff;
	aluif.aluop = ALU_SUB;
	@(posedge CLK); 
	$display("#7 A:%d B: %d OP: SUB Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );

	aluif.portA = 32'h7fffffff;
	aluif.portB = 32'h8000000a;
	aluif.aluop = ALU_SUB;
	@(posedge CLK); 
	$display("#8 A:%d B: %d OP: SUB Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );


	aluif.portA = 32'h8000000a;
	aluif.portB = 32'h8000000b;
	aluif.aluop = ALU_SUB;
	@(posedge CLK);
	$display("#9 A:%d B: %d OP: SUB Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );

		
	aluif.portA = 32'hfffffff0;
	aluif.portB = 32'h10;
	aluif.aluop = ALU_SUB;
	@(posedge CLK);
	$display("#10 A:%d B: %d OP: SUB Result: %d OVF: %b NEG: %b ZERO: %b", $signed(aluif.portA), $signed(aluif.portB),$signed(aluif.result), aluif.ovf, aluif.neg, aluif.zero );

     endtask // test_SUB

   task test_AND();
      for(int i = 0; i < 6; i++)
	begin
	   aluif.portA = $random;
	   aluif.portB = $random;
	   aluif.aluop = ALU_AND;
	   @(posedge CLK);
	   $display("#%d A: %b B: %b result: %b", i+10, aluif.portA, aluif.portB, aluif.result);
	   assert(aluif.result == (aluif.portA & aluif.portB))
	     else $display("AND not working correctly");
	   
	 end
      
   endtask // test_AND
      task test_OR();
      for(int i = 0; i < 6; i++)
	begin
	   aluif.portA = $random;
	   aluif.portB = $random;
	   aluif.aluop = ALU_OR;
	   @(posedge CLK);
	   $display("#%d A: %b B: %b result: %b", i+20, aluif.portA, aluif.portB, aluif.result);
	   assert(aluif.result == (aluif.portA | aluif.portB))
	     else $display("OR not working correctly");
	   
	 end
      
      endtask // test_OR
      task test_SLL();

	   aluif.portA = 32'h00000001;
	   aluif.portB = 32'h00000001;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("25");
	   
	   $display("A     : %b", aluif.portA);
	   $display("result: %b", aluif.result);
	   
	   aluif.portA = 32'h0000aa00;
	   aluif.portB = 32'h0000aa00;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("26");
	   
	   $display("A     : %b", aluif.portA);
	   $display("result: %b", aluif.result);
	   
	   aluif.portA = 32'h00a0a000;
	   aluif.portB = 32'h00a0a000;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("27");
	   
	   $display("A     : %b",aluif.portA);
	   $display("result: %b", aluif.result);
	   
	   aluif.portA = 32'h10000000;
	   aluif.portB = 32'h10000000;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("28");
	   
	   $display("A     : %b", aluif.portA);
	   $display("result: %b", aluif.result);
	   
      endtask // test_SLL
         task test_SRL();

	   aluif.portA = 32'h00000010;
	   aluif.portB = 32'h00000010;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("25");
	   
	   $display("A     : %b", aluif.portA);
	   $display("result: %b", aluif.result);
	   
	   aluif.portA = 32'h0000aa00;
	   aluif.portB = 32'h0000aa00;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("26");
	   
	   $display("A     : %b", aluif.portA);
	   $display("result: %b", aluif.result);
	   
	   aluif.portA = 32'h00a0a000;
	   aluif.portB = 32'h00a0a000;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("27");
	   
	   $display("A     : %b",aluif.portA);
	   $display("result: %b", aluif.result);
	   
	   aluif.portA = 32'h00000000;
	   aluif.portB = 32'h00000000;
	   aluif.aluop = ALU_SLL;
	   @(posedge CLK);
	   $display("28");
	   
	   $display("A     : %b", aluif.portA);
	   $display("result: %b", aluif.result);
	   
	 endtask // test_SRL
      task test_XOR();
      for(int i = 0; i < 6; i++)
	begin
	   aluif.portA = $random;
	   aluif.portB = $random;
	   aluif.aluop = ALU_XOR;
	   @(posedge CLK);
	   $display("#%d A: %b B: %b result: %b", i+20, aluif.portA, aluif.portB, aluif.result);
	   assert(aluif.result == (aluif.portA ^ aluif.portB))
	     else $display("AND not working correctly");
	   
	end // for (int i = 0; i < 6; i++)
	 endtask
      task test_NOR();
      for(int i = 0; i < 6; i++)
	begin
	   aluif.portA = $random;
	   aluif.portB = $random;
	   aluif.aluop = ALU_NOR;
	   @(posedge CLK);
	   $display("#%d A: %b B: %b result: %b", i+35, aluif.portA, aluif.portB, aluif.result);
	   assert(aluif.result == !(aluif.portA | aluif.portB))
	     else $display("NOR not working correctly");
	   
	 end
      
      endtask // test_NOR
      task test_SLT();
      for(int i = 0; i < 6; i++)
	begin
	   aluif.portA = $random;
	   aluif.portB = $random;
	   aluif.aluop = ALU_SLT;
	   @(posedge CLK);
	   $display("#%d A: %d B: %d result: %b", i+35, $signed(aluif.portA), $signed(aluif.portB), aluif.result);
	   assert(aluif.result == ($signed(aluif.portA) < $signed(aluif.portB)))
	     else $display("SLT not working correctly");
	   
	 end
      
      endtask // test_SLT

         task test_SLTU();
      for(int i = 0; i < 6; i++)
	begin
	   aluif.portA = $random;
	   aluif.portB = $random;
	   aluif.aluop = ALU_SLTU;
	   @(posedge CLK);
	   $display("#%d A: %d B: %d result: %b", i+35, $signed(aluif.portA), $signed(aluif.portB), aluif.result);
	   assert(aluif.result == (aluif.portA < aluif.portB))
	     else $display("SLTU not working correctly");
	   
	 end
      
      endtask // test_SLT
 
endprogram
