/*
Evan Miller
mill`576@purdue.edu
*/

`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

//register_file_if rfif(); //instantiate the interface
parameter WORD_W    = 32;

module register_file(

input logic clk,
input logic nrst,
register_file_if.rf rfif

);

logic [WORD_W-1:0][WORD_W-1:0] regs;
logic [WORD_W-1:0][WORD_W-1:0] next_regs;
   

assign rfif.rdat1 = regs[rfif.rsel1];
assign rfif.rdat2 = regs[rfif.rsel2];
   
always_ff @(posedge clk, negedge nrst)
  begin
     if(!nrst)
       begin
	  regs <= '0; 
       end
     else
       begin
	  regs <= next_regs;
       end
  end

always_comb
  begin
     next_regs = regs;
     if(rfif.WEN & rfif.wsel != 0)
       begin
	  next_regs[rfif.wsel] = rfif.wdat;
       end
  end

endmodule // register_file

   
