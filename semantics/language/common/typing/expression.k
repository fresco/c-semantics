module C-TYPING-EXPRESSION
     imports C-TYPING-SYNTAX
     imports C-TYPING-STRICTNESS-SYNTAX

     imports C-SYNTAX
     imports C-DYNAMIC-SYNTAX
     imports C-PROMOTION-SYNTAX
     imports C-DECLARATION-SYNTAX
     imports C11-SETTINGS-SYNTAX
     imports COMPAT-SYNTAX

     // FIXME need to automatically pad structs
     syntax K ::= "MYHOLE"

     syntax Set ::= "assignmentLabels" [function]
     rule assignmentLabels => 
          SetItem(l('_:=_))
          SetItem(l('_*=_))
          SetItem(l('_/=_))
          SetItem(l('_%=_))
          SetItem(l('_+=_))
          SetItem(l('_-=_))
          SetItem(l('_<<=_))
          SetItem(l('_>>=_))
          SetItem(l('_&=_))
          SetItem(l('_^=_))
          SetItem(l('_|=_))

     syntax Set ::= "typeStrictLeftBinaryOperators" [function] // [memo] 
     rule typeStrictLeftBinaryOperators => 
          SetItem(l('_<<_))
          SetItem(l('_>>_))
          SetItem(l('_*=_))
          SetItem(l('_/=_))
          SetItem(l('_%=_))
          SetItem(l('_+=_))
          SetItem(l('_-=_))
          SetItem(l('_<<=_))
          SetItem(l('_>>=_))
          SetItem(l('_&=_))
          SetItem(l('_^=_))
          SetItem(l('_|=_))
          SetItem(l('_++))
          SetItem(l('_--))
          SetItem(l('--_))
          SetItem(l('++_))
     
     rule <k> typeof(K:K) => evalToType ~> typeof(MYHOLE) ...</k>
          (.Bag => <type> K:K </type>)
          [structural]
     rule <k> evalToType ~> typeof(MYHOLE) => T ...</k>
          (<type> T:Type </type> => .Bag)
          [structural]

     // these are sort of artifacts of other things
     rule <type> emptyValue => t(.Set, void) ...</type> 
          [structural]
     rule <type> tv(_, T:Type) => T ...</type>
          [structural]
     rule <type> E1:K[E2:K] => *(E1 + E2) ...</type> 
          [structural]
     
     //! \begin{rulesGroup}
     /*@  \fromStandard{\source[n1570]{\para{6.5.7}{3}}}{
     The integer promotions are performed on each of the operands. The type of
     the result is that of the promoted left operand. \ldots
     }*/  
     rule <type> T:Type << _ => promote(T) ...</type>
          [structural]
     rule <type> T:Type >> _ => promote(T) ...</type>
          [structural]
     //! \end{rulesGroup}
     
     /*@ %\begin{rulesGroup}
     \fromStandard{\source[n1570]{\para{6.5.3.4}{5}}}{
     The value of the result of both operators is implementation-defined, and
     its type (an unsigned integer type) is \cinline{size_t}, defined in
     \header{<stddef.h>} (and other headers).
     }*/  
     rule <type> SizeofExpression(_) => cfg:sizeut ...</type>
          [structural]

     rule <type>
               t(S:Set, pointerType(T:Type)) + T':Type
               => t(S, pointerType(T))
          ...</type>
          when hasIntegerType(T')
          [structural]
     rule <type>
               T':Type + t(S:Set, pointerType(T:Type))
               => t(S, pointerType(T))
          ...</type>
          when hasIntegerType(T')
          [structural]
     rule <type>
               t(S:Set, pointerType(T:Type)) - T':Type
               => t(S, pointerType(T))
          ...</type>
          when hasIntegerType(T')
          [structural]
     rule <type>
               t(_, pointerType(_:Type)) - t(_, pointerType(_:Type))
               => cfg:ptrdiffut
          ...</type>
          [structural]
     rule <type>
               t(S:Set, arrayType(T:Type, _:Int)) + T':Type
               => t(S, pointerType(T))
          ...</type>
          when hasIntegerType(T')
          [structural]
     rule <type>
               T':Type + t(S:Set, arrayType(T:Type, _:Int))
               => t(S, pointerType(T))
          ...</type>
          when hasIntegerType(T')
          [structural]
     rule <type>
               t(S:Set, arrayType(T:Type, _:Int)) - T':Type
               => t(S, pointerType(T))
          ...</type>
          when hasIntegerType(T')
          [structural]

     // c99 6.4.5
     rule <type>
               Constant(StringLiteral(S:String)) 
               => t(.Set, arrayType(t(.Set, char), lengthString(S) +Int 1)) 
          ...</type>
          [structural]
     rule <type>
               Constant(WStringLiteral(L:KList)) 
               => t(.Set, arrayType(cfg:wcharut, (lengthKList L) +Int 1)) 
          ...</type>
          [structural]
          
     rule <type> K:K => T ...</type>
          <types>... K |-> T:Type ...</types>
          [structural]
     
     /*@ \fromStandard{\source[n1570]{\para{6.5.17}{2}}}{
     The left operand of a comma operator is evaluated as a void expression;
     there is a sequence point between its evaluation and that of the right
     operand. Then the right operand is evaluated; the result has its type and
     value.
     }*/
     rule <type> Comma(klist((_,, K:K))) => K ...</type>
          [structural]

     /*@ \fromStandard{\source[n1570]{\para{6.5.2.2}{5}}}{
     If the expression that denotes the called function has type pointer to
     function returning an object type, the function call expression has the
     same type as that object type, and has the value determined as specified
     in 6.8.6.4. Otherwise, the function call has type \cinline{void}.
     }*/
     rule [type-call-func]:
          <type> Call(T:Type, _) => innerType(T) ...</type>
          [structural]
          
     /*@ \fromStandard{\source[n1570]{\para{6.5.2.3}{3}}}{
     A postfix expression followed by the \cinline{.} operator and an
     identifier designates a member of a structure or union object. The value
     is that of the named member, and is an lvalue if the first expression is
     an lvalue. If the first expression has qualified type, the result has the
     so-qualified version of the type of the designated member.
     }*/
     rule [type-struct-dot]:
          <type> t(_, structType(S:Id)) . F:Id => T ...</type>
          <structs>...
               S |-> aggregateInfo(_, (_ F |-> T:KResult), _)
          ...</structs>
          [structural]
     rule [type-union-dot]:
          <type> t(_, unionType(S:Id)) . F:Id => T ...</type>
          <structs>...
               S |-> aggregateInfo(_, (_ F |-> T:KResult), _)
          ...</structs>
          [structural]

     /*@ \fromStandard{\source[n1570]{\para{6.5.3.2}{4}}}{
     The unary \cinline{*} operator denotes indirection. If the operand points
     to a function, the result is a function designator; if it points to an
     object, the result is an lvalue designating the object. If the operand has
     type ``pointer to type'', the result has type ``type''. \ldots
     }*/
     rule [type-deref-type]:
          <type> * T:Type => innerType(T) ...</type>
          [structural]

     rule [type-compound-literal]:
          <type> 
               CompoundLiteral(_, Spec:K, Decl:K, _)
               // sort of hackish, assumes cast will evaluate to type
               => Cast(Spec, Decl, emptyValue)
          ...</type>
          [structural]
     
     rule [type-assignment]:
          <type> 
               L:KLabel(K:K,, _)
               => K:K
          ...</type>
          when l(L) in assignmentLabels
          [structural]

     rule <type>
               L:KLabel(T:Type,, T':Type) 
               => usualArithmeticConversion(T, T')
          ...</type>
          when isArithBinConversionOp(L)
               andBool (hasIntegerType(T) orBool isFloatType(T))
               andBool (hasIntegerType(T') orBool isFloatType(T'))
          [structural]
          
     rule [type-ternary-arithmetic]:
          <type>
               _:K ? T:Type : T':Type 
               => usualArithmeticConversion(T, T')
          ...</type>
          when (hasIntegerType(T) orBool isFloatType(T))
               andBool (hasIntegerType(T') orBool isFloatType(T'))
          [structural]
     rule [type-ternary-identical]:
          <type> _:K ? T:Type : T:Type => T:Type ...</type>
          when notBool isArrayType(T)
          [structural]
          
     rule [type-ternary-array-left]: 
          <type>
               _:K ? (t(S:Set, arrayType(T:Type, _:Int))
               => t(S:Set, pointerType(T))) : _
          ...</type> 
          [structural]
     rule [type-ternary-array-right]: 
          <type>
               _:K ? _:K : (t(S:Set, arrayType(T:Type, _:Int))
               => t(S:Set, pointerType(T)))
          ...</type>
          [structural]
          
     // not safe, could be incompatible types
     rule [type-ternary-pointer]:
          <type>
               _ ? t(S:Set, pointerType(T:Type)) : t(_, pointerType(_:Type))
               => t(S, pointerType(T))
          ...</type>
          [structural]

     rule <type> L:KLabel(T:Type) => T ...</type> 
          when isArithUnaryOp(L)
               andBool isFloatType(T)
          [structural]
     rule <type> L:KLabel(T:Type) => promote(T) ...</type> 
          when isArithUnaryOp(L) andBool hasIntegerType(T)
          [structural]
     
     rule <type> L:KLabel(T:Type,, _:KList) => T ...</type>
          when isFloatType(T)
               andBool l(L) in typeStrictLeftBinaryOperators
          [structural]
     rule <type> L:KLabel(T:Type,, _:KList) => promote(T) ...</type>
          when hasIntegerType(T)
               andBool l(L) in typeStrictLeftBinaryOperators
          [structural]
          
     rule [type-inc-dec]:
          <type> L:KLabel(T:Type) => T ...</type>
          when isPointerType(T)
               andBool (
                    (L ==KLabel ('_++))
                    orBool (L:KLabel ==KLabel ('_--))
                    orBool (L:KLabel ==KLabel ('--_))
                    orBool (L:KLabel ==KLabel ('++_))
               )
          [structural]
     
     rule <type> !(_:K) => t(.Set, int) ...</type>
          [structural]
          
     rule <type> L:KLabel(_:K,, _:K) => t(.Set, int) ...</type>
          when (L:KLabel ==KLabel '_==_)
               orBool (L:KLabel ==KLabel '_!=_)
               orBool (L:KLabel ==KLabel '_&&_)
               orBool (L:KLabel ==KLabel '_||_)
          [structural]

     rule [type-address]:
          <type> & T:Type => t(.Set, pointerType(T)) ...</type>
          [structural]
          
     rule [ExpressionLoc-type]:
          <type> ExpressionLoc(K:K, L:CabsLoc) => K:K ...</type>
          <currentProgramLoc> _ => L:CabsLoc </currentProgramLoc>
          [structural]
endmodule

