  /*****\\\\
 /       \\\\    Swift/Generator.swift
/  /\ /\  \\\\   (part of Hexagen)
\  \_X_/  ////
 \       ////    Copyright © 2015 Alice Atlas (see LICENSE.md)
  \*****////


public class Gen<OutType>: Coro<Void, OutType>, LazySequenceType, GeneratorType {
    public typealias Element=OutType;
    public typealias Generator=Gen<Element>;
    
    override public init(_ fn: (OutType -> Void) -> Void) {
        super.init(fn)
    }
    
    public func generate() -> Gen {
        return self
    }
    
    public func next() -> Element? {
        return _started ? send(()) : start()
    }
    
    public func map<U>(fn: OutType -> U) -> LazySequence<LazyMapSequence<Gen, U>> {
        //return lazy(self).map(fn)
        return lazy.map(fn);
    }
    
    public func filter(fn: OutType -> Bool) -> LazyFilterSequence<LazyFilterSequence<Gen>> {
        //return lazy(self).filter(fn)
        return lazy.filter(fn);
    }
}