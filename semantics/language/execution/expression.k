require "expression/function-call.k"
require "expression/inc-and-dec.k"
require "expression/sequencing.k"

module C-EXPRESSION-SYNTAX
     syntax K ::= "populateFromGlobal"
endmodule

module C-EXPRESSION
     imports C-EXPRESSION-FUNCTION-CALL
     imports C-EXPRESSION-INC-AND-DEC
     imports C-EXPRESSION-SEQUENCING
endmodule
