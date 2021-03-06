module C-SYMLOC-SYNTAX
     syntax K ::= firstLoc(K) [function]
     syntax SymBase ::= base(SymLoc) [function]

     syntax ThreadId ::= Int
     syntax ThreadId ::= "allocatedDuration"
     syntax SymBase ::= Int "@" ThreadId

     // Base, byte offset, bit offset
     syntax SymLoc ::= loc(SymBase, Int, Int) [klabel('loc)]
     syntax SymLoc ::= "NullPointer"

     syntax KResult ::= SymLoc

     syntax SymLoc ::= linc(SymLoc) [function]

     syntax SymLoc ::= SymLoc "+bits" Int [function]
     syntax SymLoc ::= SymLoc "+bytes" Int [function]

     syntax Bool ::= SymLoc ">bytes" SymLoc [function]
                   | SymLoc ">=bytes" SymLoc [function]
                   | SymLoc "<bytes" SymLoc [function]
                   | SymLoc "<=bytes" SymLoc [function]
                   | SymLoc "==bytes" SymLoc [function]

     // loc with possible bit offset returning base byte     
     syntax SymLoc ::= floorLoc(SymLoc) [function] 
     // loc with possible bit offset returning upperbounded byte     
     syntax SymLoc ::= ceilingLoc(SymLoc) [function]

     syntax Bool ::= sameBase(SymLoc, SymLoc) [function]
endmodule

module C-SYMLOC
     imports C-SYMLOC-SYNTAX

     imports C11-SETTINGS-SYNTAX

     rule firstLoc(ThreadId:Int) => loc(0 @ ThreadId:Int, 0, 0)
     
     rule base(loc(Base:SymBase, _, _)) => Base
     
     rule linc(loc(X:Int @ Th:ThreadId, ByOff:Int, BiOff:Int))
          => loc(X +Int 1 @ Th, ByOff, BiOff)

     rule loc(Base:SymBase, Offset:Int, BitOffset:Int) +bits N:Int
          => loc(Base, Offset, BitOffset +Int N)
     rule loc(Base:SymBase, Offset:Int, BitOffset:Int) +bytes N:Int
          => loc(Base, Offset +Int N, BitOffset)

     rule loc(_, A:Int, _) >bytes loc(_, B:Int, _) => A >Int B
     rule loc(_, A:Int, _) >=bytes loc(_, B:Int, _) => A >=Int B
     rule loc(_, A:Int, _) <bytes loc(_, B:Int, _) => A <Int B
     rule loc(_, A:Int, _) <=bytes loc(_, B:Int, _) => A <=Int B
     rule loc(_, A:Int, _) ==bytes loc(_, B:Int, _) => A ==Int B

     rule floorLoc(loc(Base:SymBase, Offset:Int, BitOffset:Int))
          => loc(Base, Offset:Int, 0)
          when BitOffset <Int cfg:bitsPerByte
     
     rule [ceilingLoc-null]: 
          ceilingLoc(NullPointer) => NullPointer

     rule [ceilingLoc]:
          ceilingLoc(loc(N:SymBase, R:Int, M:Int))
          => loc(N, (M /Int cfg:bitsPerByte) +Int R, 0)

     rule sameBase(loc(A:SymBase, _, _), loc(B:SymBase, _, _))
          => A ==K B

     rule loc(Base:SymBase, Offset:Int, BitOffset:Int)
          => loc(Base, Offset +Int BitOffset /Int cfg:bitsPerByte,
               BitOffset %Int cfg:bitsPerByte)
          when BitOffset:Int >=Int cfg:bitsPerByte
          [structural, anywhere]
endmodule
