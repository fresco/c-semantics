module C-DECLARATION-ZERO
     imports C-DECLARATION-SYNTAX

     imports C-SYNTAX
     imports C-DYNAMIC-SYNTAX
     imports C-TYPING-SYNTAX
     imports C-SYMLOC-SYNTAX

     // c1x 6.7.8:21 ... the remainder of the aggregate shall be initialized
     // implicitly the same as objects that have static storage duration
     rule <k> 
               initialize(X:Id, _:Type, K:K)
               => #if (F ==K file-scope) #then zero(X) #else (.) #fi 
                    ~> K
                    ~> sequencePoint
          ...</k>
          <currentFunction> F:Id </currentFunction>
          [structural] 

     rule <k>
               zero(Sym:K) => zeroType(Sym, unqualifyType(T))
          ...</k>
          <types>... Sym |-> T:Type ...</types>
          [structural] 
          
     syntax K ::= "zeroType" "(" K "," Type ")"
     
     rule zeroType(N:K, T:Type)
          => Computation(allowWrite(N) := tv(0, t(.Set, int)))
          when hasIntegerType(T)
          [structural] 
     rule zeroType(N:K, T:Type)
          => Computation(allowWrite(N) := tv(0.0, t(.Set, float)))
          when isFloatType(T)
          [structural] 
          
     syntax K ::= "zeroStruct" "(" K "," KList ")"
     
     // c1x 6.7.9:10 If an object that has automatic storage duration is not
     // initialized explicitly, its value is indeterminate. If an object that
     // has static or thread storage duration is not initialized explicitly,
     // then:
     // -- if it has pointer type, it is initialized to a null pointer;
     // -- if it has arithmetic type, it is initialized to (positive or
     // unsigned) zero;
     // -- if it is an aggregate, every member is initialized (recursively)
     // according to these rules, and any padding is initialized to zero bits;
     // -- if it is a union, the first named member is initialized
     // (recursively) according to these rules, and any padding is initialized
     // to zero bits;
     
     rule <k> 
               zeroType(N:K, t(_, structType(S:Id))) 
               => zeroStruct(N, Fields)
          ...</k>
          <structs>... S |-> aggregateInfo(Fields:KList, _, _) ...</structs> 
          [structural] 
          
     rule <k> zeroType(N:K, t(_, unionType(S:Id))) 
               => zeroType(N . F, T)
          ...</k>
          <structs>... 
               S |-> aggregateInfo((typedDeclaration(T:Type, F:Id),, _), _, _) 
          ...</structs> 
          [structural] 
          
     rule zeroStruct(Sym:K, (typedDeclaration(T:Type, F:Id),, L:KList)) 
          => zeroType(Sym . F, T) ~> zeroStruct(Sym, L) 
          [structural] 
     rule zeroStruct(_, .KList) => .
          [structural] 

     rule zeroType(Sym:K, T:Type) 
               => Computation(allowWrite(Sym) := tv(NullPointer, T))
          when isPointerType(T)
          [structural]
     rule zeroType(_, T:Type) => .
          when isFunctionType(T)
          [structural]
          
     // fixme snat
     rule zeroType(Sym:K, t(S:Set, arrayType(T:Type, Len:Int))) 
          => zeroType(Sym[Len -Int 1], T)
               ~> zeroType(Sym, t(S:Set, arrayType(T, Len -Int 1))) 
          when Len >Int 0
          [structural] 
     rule zeroType(_, t(_, arrayType(_:Type, 0))) => .
          [structural] 

     rule zeroType(_, t(_, flexibleArrayType(_:Type))) => .
          [structural]
endmodule

