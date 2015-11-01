  /*****\\\\
 /       \\\\    Swift/Task/Subscription.swift
/  /\ /\  \\\\   (part of Hexagen)
\  \_X_/  ////
 \       ////    Copyright © 2015 Alice Atlas (see LICENSE.md)
  \*****////


extension Feed: SequenceType {
    public func generate() -> Subscription<T> {
        return Subscription<T>(head: head)
    }
}

public struct Subscription<T>: LazySequenceType, GeneratorType {
    public typealias Element=T;
    public typealias Generator=Subscription<T>
    
    private var head: RecurringPromise<T>?
    
    public func generate() -> Subscription<T> {
        return self
    }
    
    public mutating func next() -> Element? {
        if let promise = head {
            let value = <-promise
            head = promise.successor
            return value
        }
        return nil
    }
    
    public func map<U>(fn: T -> U) -> LazySequence<LazyMapSequence<Subscription, U>> {
        return lazy.map(fn)
    }
    
    public func filter(fn: T -> Bool) -> LazySequence<LazyFilterSequence<Subscription>> {
        return lazy.filter(fn)
    }
}
