/*
 
 Evan Miller
 mill1576@purdue.edu
 
 */

`include "alu_if.vh" //ALU interface


module alu(
alu_if.alu alu	   
);

import cpu_types_pkg::*; //for ALU cases
   
   
logic carry;
   
assign alu.ovf = ({carry, alu.result[31]} == 2'b01) || ({carry, alu.result[31]} == 2'b10); //check for overflow, underflow
assign alu.zero = (alu.result == 31'b0); //check for zero
assign alu.neg = (alu.result < 31'b0); //check for negative
   
always_comb
begin
   alu.result = 0; //default value
   case(alu.aluop)
     ALU_ADD:
       begin
	  {carry, alu.result} = $signed(alu.portA) + $signed(alu.portB); //Add
       end
     ALU_SUB:
       begin
	  {carry,alu.result} = $signed(alu.portA) - $signed(alu.portB); //Sub
       end
     ALU_AND:
       begin
	  alu.result = alu.portA & alu.portB; //bitwise and
       end
     ALU_OR:
       begin
	  alu.result = alu.portA | alu.portB; //bitwise or
       end
     ALU_SLL:
       begin
	  alu.result = {alu.portA[30:0], 1'b0}; //logical shift left, could be portA<<1
       end
     ALU_SRL:
       begin
	  alu.result = {1'b0,portA[31:1]}; //logical shift right, could be portA>>1
       end
     ALU_XOR:
       begin
	  alu.result = alu.portA ^ alu.portB; //Xor
       end
     ALU_NOR:
       begin
	  alu.result = !(alu.portA | alu.portB); //Nor	  
       end
     ALU_SLT:
       begin
	  alu.result = ($signed(alu.portA) < $signed(alu.portB)) ? 32'h0 : 32'h1; //signed less than
       end
     ALU_SLTU:
       begin
	  alu.result = (alu.portA < alu.portB) ? 32'b1 : 32'b0;//unsigned less than
	  
       end
   
end   