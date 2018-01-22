/*
 
 Evan Miller
 mill1576@purdue.edu
 
 */

`include "alu_if.vh" //ALU interface


module alu(
alu_if.alu alu	   
);

import cpu_types_pkg::*; //for ALU cases
   
   
 
//assign alu.ovf = ({alu.portA[30], alu.result[31]} == 3'b01) || ({carry, alu.result[31]} == 2'b10); //check for overflow, underflow
assign alu.zero = (alu.result == 32'h0); //check for zero
assign alu.neg = (alu.result[31]); //check for negative
   
always_comb
begin
   alu.result = 0; //default value
   alu.ovf = 0;
   
   case(alu.aluop)
     ALU_ADD:
       begin
	  alu.result = $signed(alu.portA) + $signed(alu.portB); //Add
	  alu.ovf = (~alu.portA[31] && ~alu.portB[31] && alu.result[31]) || (alu.portA[31] && alu.portB[31] && ~alu.result[31]);
       end
     ALU_SUB:
       begin
	  alu.result = $signed(alu.portA) - $signed(alu.portB); //Sub
	  alu.ovf = (alu.portA[31] && ~alu.portB[31] && ~alu.result[31]) || (~alu.portA[31] && alu.portB[31] && alu.result[31]);
	  
       end
     ALU_AND:
       begin
	  alu.result = (alu.portA & alu.portB); //bitwise and
       end
     ALU_OR:
       begin
	  alu.result = (alu.portA | alu.portB); //bitwise or
       end
     ALU_SLL:
       begin
	  alu.result = alu.portA << alu.portB; //logical shift left, could be portA<<1
       end
     ALU_SRL:
       begin
	  alu.result = alu.portA >> alu.portB; //logical shift right, could be portA>>1
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
	  alu.result = ($signed(alu.portA) < $signed(alu.portB)) ? 32'h1 : 32'h0; //signed less than
       end
     ALU_SLTU:
       begin
	  alu.result = (alu.portA < alu.portB) ? 32'b1 : 32'b0;//unsigned less than
	  
       end
     endcase
end

endmodule
