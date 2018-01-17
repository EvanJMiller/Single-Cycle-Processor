/*
 
 Evan Miller
 mill1576@purdue.edu
 
*/
 
`ifndef ALU_IF_VH
 `define ALU_IF_VH


interface alu_if;
   import cpu_types_pkg::*;

   word_t portA, portB, result;
   logic [0:3] aluop;
   logic neg, ovf, zero

   modport alu(input portA, portB, aluop,
	       output neg, ovf, zero, result
	       );
   modport tb(input neg, ovf, zero, result,
	      output portA, portB, aluop
	      );
endinterface // alu_if

`endif
   
