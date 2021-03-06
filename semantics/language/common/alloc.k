module C-MEMORY-ALLOC-SYNTAX
     syntax K ::= memblock(Int, Bag, Map)

     syntax K ::= writeString(SymLoc, String)
     syntax K ::= writeWString(SymLoc, KList)

     // fixme would be better to keep canonical
     syntax Int ::= getBitOffset(SymLoc) [function]
     syntax Int ::= getByteOffset(SymLoc) [function]

     syntax K ::= checkValidLoc(SymLoc)
     syntax K ::= checkDerefLoc(SymLoc)
     // TODO(chathhorn): error check
     syntax K ::= "checkValidLoc-aux" "(" SymLoc ")"

     syntax K ::= allocString(SymLoc, String)
     syntax K ::= allocWString(SymLoc, KList)

     syntax K ::= alloc(SymLoc, K) [strict(2)]
     syntax K ::= realloc(SymLoc, SymLoc, Int, Int)

     syntax K ::= zeroBlock(SymLoc)

     // deletes the base object from memory, given a location
     syntax K ::= deleteBlock(SymLoc)
     // deletes the base object from memory, given a location and it size (as a
     // check)
     syntax K ::= deleteSizedBlock(SymLoc, Int)

     syntax K ::= sizeofLocation(SymLoc)

     syntax K ::= "mconst"

     syntax K ::= makeUnwritable(SymLoc)
     syntax K ::= makeUnwritableSubObject(K)
     syntax K ::= makeUnwritableVar(K)

     syntax K ::= allocateType(SymLoc, Type)
     syntax K ::= allocateTypeIfAbsent(SymLoc, Type)
endmodule

module C-MEMORY-ALLOC
     imports C-MEMORY-ALLOC-SYNTAX

     imports C-SYNTAX
     imports C-DYNAMIC-SYNTAX
     imports C-SYMLOC-SYNTAX
     imports C-TYPING-SYNTAX
     imports C-BITS-SYNTAX
     imports C-BITSIZE-SYNTAX
     imports C11-SETTINGS-SYNTAX
     imports COMPAT-SYNTAX
     
     rule [write-string]:
          writeString(Loc:SymLoc, S:String)
          => Computation((* tv(Loc, t(.Set, pointerType(t(.Set, char))))) 
               := tv(ordChar(firstChar(S:String)), t(.Set, char)))
               ~> writeString(Loc +bytes 1, butFirstChar(S:String))
          when S:String =/=String ""
          [structural]
     // fixme this bare 4 needs to be updated to handle different size wchar_ts
     rule [write-wstring]:
          writeWString(Loc:SymLoc, (N:Int,, S:KList))
          => Computation((* tv(Loc, t(.Set, pointerType(cfg:wcharut)))) 
               := tv(N, cfg:wcharut))
               ~> writeWString(Loc +bytes 4, S)
          [structural] 
     rule [write-empty-string]:
          writeString(Loc:SymLoc, "")
          => Computation((* tv(Loc, t(.Set, pointerType(t(.Set, char))))) 
               := tv(0, t(.Set, char)))
          [structural]
     rule [write-wstring]:
          writeWString(Loc:SymLoc, .KList)
          => Computation((* tv(Loc, t(.Set, pointerType(cfg:wcharut)))) 
               := tv(0, cfg:wcharut))
          [structural] 

     rule allocateType(Loc:SymLoc, T:Type) 
          => alloc(Loc, byteSizeofType(T))
          [structural]
     rule [allocateTypeIfAbsent-absent]:
          <k> 
               allocateTypeIfAbsent(Loc:SymLoc, T:Type) 
               => alloc(Loc, byteSizeofType(T))
          ...</k>
          <mem> M:Map </mem>
          when notBool (SetItem(base(Loc)) in (keys M))
          [structural] 
     rule [allocateTypeIfAbsent-present]:
          <k> 
               allocateTypeIfAbsent(loc(Base:SymBase, 0, 0), _:Type) 
               => .K 
          ...</k>
          <mem>... Base |-> memblock(_, _, _) ...</mem>
          [structural]

     rule [alloc-lazy]:
          <k> alloc(loc(Base:SymBase, 0, 0), Len:TypedValue) => .K ...</k>
          <mem>... .Map => Base |-> memblock(value(Len), .Bag, .Map) ...</mem>
          [structural]
     
     syntax K ::= "realloc-aux" "(" Int "," SymLoc "," SymLoc "," Int "," Int ")"
     rule [realloc-start]:
          <k> 
               realloc(Old:SymLoc, New:SymLoc, OldLen:Int, NewLen:Int)
               => alloc(New, NewLen)
                    ~> realloc-aux(minInt(OldLen, NewLen), 
                         Old, New, OldLen, NewLen)
          ...</k>
          [structural]
          
     rule [realloc-found]:
          <k> 
               realloc-aux((SNatN:Int => SNatN:Int -Int 1), 
                    loc(OldBase:SymBase, 0, 0), 
                    loc(NewBase:SymBase, 0, 0), _, _)
          ...</k>
          <mem>... 
               OldBase |-> memblock(_, _, (_ N:Int |-> K:K))
               NewBase |-> memblock(_, _, (_ (.Map => SNatN:Int -Int 1 |-> K:K)))
          ...</mem>
          when (N ==Int SNatN -Int 1)
               andBool (SNatN >Int 0)
          [structural]   
          
     // fixme sNat
     rule [realloc-unfound]:
          <k> 
               realloc-aux((SNatN:Int => SNatN -Int 1), 
                    loc(OldBase:SymBase, 0, 0), loc(_:SymBase, 0, 0), _, _)
          ...</k>
          <mem>... OldBase |-> memblock(_, _, M:Map) ...</mem>
          when (notBool SNatN:Int -Int 1 in keys M:Map)
               andBool (SNatN >Int 0)
          [structural]
     rule [realloc-0]:
          realloc-aux(0, loc(OldBase:SymBase, 0, 0), _, OldLen:Int, _)
          => deleteSizedBlock(loc(OldBase, 0, 0), OldLen:Int) 
          [structural]   
          
     rule getBitOffset(loc(_, _, M:Int)) => M %Int cfg:bitsPerByte
     rule getByteOffset(loc(_, M:Int, N:Int)) => M +Int N /Int cfg:bitsPerByte
     
     // used by calloc
     rule <k> zeroBlock(loc(Base:SymBase, 0, 0)) => . ...</k>
          <mem>...
               Base |-> memblock(Len:Int, _, 
                    _ => Map((0 to Len) |-> piece(0, cfg:bitsPerByte)))
          ...</mem>
          [structural]
          
     rule <k> 
               sizeofLocation(loc(Base:SymBase, _:Int, _:Int)) 
               => tv(Len:Int, cfg:sizeut)
          ...</k>
          <mem>... Base |-> memblock(Len:Int, _, _) ...</mem>
          [structural]
          
     // c99 6.5:2 If a side effect on a scalar object is unsequenced relative
     // to either a different side effect on the same scalar object or a value
     // computation using the value of the same scalar object, the behavior is
     // undefined. If there are multiple allowable orderings of the
     // subexpressions of an expression, the behavior is undefined if such an
     // unsequenced side effect occurs in any of the orderings
     //
     // i take this to mean that if i write to a location twice or read from a
     // location after being written to, then it is a problem
          
     rule [alloc-string]:
          allocString(Loc:SymLoc, S:String)
          => allocateType(Loc, 
               t(.Set, arrayType(t(.Set, char), lengthString(S) +Int 1)))
               ~> writeString(Loc, S) ~> makeUnwritable(Loc)
          [structural]
     rule [alloc-wstring]:
          allocWString(Loc:SymLoc, S:KList)
          => allocateType(Loc, 
               t(.Set, arrayType(cfg:wcharut, 4 *Int (lengthKList S:KList +Int 1))))
               ~> writeWString(Loc, S:KList) ~> makeUnwritable(Loc)
          [structural] 
     
     rule [makeUnwritable-var]:
          <k> makeUnwritableVar(X:Id) => makeUnwritable(Loc)  ...</k>
          <env>... X:Id |-> Loc:SymLoc ...</env>
          [structural]
     // fixme shouldn't need both of these
     // fixme could do better with bitfields
     context makeUnwritableSubObject((HOLE => peval(HOLE)))
     rule [makeUnwritable-subobject]:
          <k> 
               makeUnwritableSubObject(
                    lval(loc(Base:SymBase, Offset:Int, _), _)) 
               => . 
          ...</k>
          <notWritable> 
               M:Map => M:Map[1 / loc(Base, Offset:Int, 0)] 
          </notWritable>
          [structural]
     rule [makeUnwritable]:
          <k> makeUnwritable(loc(Base:SymBase, 0, 0)) => . ...</k>
          <mem>... 
               Base |-> memblock(_, _ (.Bag => BagItem(mconst)), _) 
          ...</mem>
          [structural]

     
     rule checkValidLoc(Loc:SymLoc) => checkValidLoc-aux(ceilingLoc(Loc)) 
          [structural]
     rule checkDerefLoc(Loc:SymLoc) => checkValidLoc(Loc) 
          when Loc =/=K NullPointer
          [structural]
     
     rule [check-valid-loc-null]:
          checkValidLoc-aux(NullPointer) => . 
          [structural]
     // fixme could additionally use the type to check whether that type is
     // valid for that pointer
     rule [check-valid-loc]:
          <k> 
               checkValidLoc-aux(
                    loc(N:Int @ PtrThreadId:ThreadId, Offset:Int, 0)) 
               => . 
          ...</k>
          <mem>... N @ PtrThreadId |-> memblock(Len:Int, _, _) ...</mem>
          <threadId> MyThreadId:ThreadId </threadId>
          when (PtrThreadId ==K MyThreadId
               orBool (PtrThreadId ==K 0)
               orBool (PtrThreadId ==K allocatedDuration)
               ) // my thread, global memory, or allocated (malloced) memory
               andBool (Offset <=Int Len) // we're allowed to address one past
          [structural]
endmodule
