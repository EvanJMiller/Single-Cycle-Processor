/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif.tb);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(

input logic CLK, 
output logic nRST,
register_file_if.tb rfif

);
   initial begin
   nRST = 0;
   rfif.WEN = 0;
   rfif.rsel1 = 0;
   rfif.rsel2 = 0;

   @(posedge CLK);
      nRST = 1;
      
   reset(); //test asynchronous reset
   
   write_regs(); //test wsel and wen, 0 register
   
      
   reset(); //test reset
   
   rfif.WEN = 0;   
   @(posedge CLK);
   write_regs(); //try writing to regs with wen low
   rfif.WEN = 1; //toggle wen
   @(posedge CLK);
   write_regs(); //try writing to regs again with wen high
      
   read_reg_1();
   read_reg_2();
            

   end

   
   //Reset all of the registers
   task reset();
      nRST = 0;
        @(posedge CLK);
      nRST = 1;
      rfif.WEN=1;
   endtask // reset

   //write to all of the registers
   task write_regs();
      //rfif.WEN = 1;
        for(int i=0 ; i<32; i++)
	begin
	   rfif.wdat = i+1; //set the value equal to the reg number
	   rfif.wsel = i;
	     @(posedge CLK);
	end
   endtask // write_regs

   //read from the first read port
   task read_reg_1();
      for(int i=0;i<32;i++)
	begin
	   rfif.rsel1 = i;
	     @(posedge CLK);
	   
	end
   endtask // read_reg_1

   //read from the second read port
   task read_reg_2();
     for(int i=0;i<32;i++)
	begin
	   rfif.rsel2 = i;
	     @(posedge CLK);
	end
   endtask // read_reg_1
   
      
      

   
endprogram
