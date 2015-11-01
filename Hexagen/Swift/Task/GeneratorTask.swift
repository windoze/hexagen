  /*****\\\\
 /       \\\\    Swift/Task/GeneratorTask.swift
/  /\ /\  \\\\   (part of Hexagen)
\  \_X_/  ////
 \       ////    Copyright © 2015 Alice Atlas (see LICENSE.md)
  \*****////


public final class AsyncGen<OutType, ReturnType>: Async<ReturnType> {
    private let feed: Feed<OutType>
    
    public init(queue: dispatch_queue_t = mainQueue, body: (OutType -> Void) -> ReturnType) {
        var post: (OutType -> Void)!
        var end: (Void -> Void)!
        feed = Feed<OutType> { (_post, _end) in
            post = _post
            end = _end
        }
        super.init(queue: queue, start: false, body: {
            let ret = body(post!)
            end()
            return ret
        })
    }
}

extension AsyncGen: LazySequenceType {
    public typealias Element=OutType;
    public typealias Generator=Subscription<OutType>;
    public func generate() -> Subscription<OutType> {
        let gen = feed.generate()
        if !started {
            start()
        }
        return gen
    }
    
    public func map<T>(fn: OutType -> T) -> LazySequence<LazyMapSequence<AsyncGen, T>> {
        return lazy.map(fn)
    }
    
    public func filter(fn: OutType -> Bool) -> LazySequence<LazyFilterSequence<AsyncGen>> {
        return lazy.filter(fn)
    }
}
