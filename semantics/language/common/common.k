require "syntax.k"
require "statement.k"

require "compat.k"
require "declaration.k"
require "bitsize.k"
require "bits.k"
require "typing.k"
require "literal.k"
require "compound-literal.k"
require "conversion.k"
require "promotion.k"
require "alloc.k"
require "symloc.k"

require "memory.k"

require "expression/additive-operators.k"
require "expression/assignment.k"
require "expression/bitwise.k"
require "expression/cast.k"
require "expression/conditional.k"
require "expression/eval.k"
require "expression/identifier.k"
require "expression/logical.k"
require "expression/members.k"
require "expression/multiplicative-operators.k"
require "expression/reference.k"
require "expression/relational.k"
require "expression/sizeof.k"
require "expression/unary-arithmetic.k"

module C11-COMMON
     imports COMPAT

     imports C-DECLARATION
     imports C-BITSIZE
     imports C-BITS
     imports C-TYPING
     imports C-LITERAL
     imports C-COMPOUND-LITERAL
     imports C-CONVERSION
     imports C-MEMORY-ALLOC
     imports C-SYMLOC
     imports C-PROMOTION

     imports C-MEMORY

     imports C-EXPRESSION-ADDITIVE-OPERATORS
     imports C-EXPRESSION-ASSIGNMENT
     imports C-EXPRESSION-BITWISE
     imports C-EXPRESSION-CAST
     imports C-EXPRESSION-CONDITIONAL
     imports C-EXPRESSION-EVAL
     imports C-EXPRESSION-IDENTIFIER
     imports C-EXPRESSION-LOGICAL
     imports C-EXPRESSION-MEMBERS
     imports C-EXPRESSION-MULTIPLICATIVE-OPERATORS
     imports C-EXPRESSION-REFERENCE
     imports C-EXPRESSION-RELATIONAL
     imports C-EXPRESSION-SIZEOF
     imports C-EXPRESSION-UNARY-ARITHMETIC
endmodule
