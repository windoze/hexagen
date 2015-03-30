  /*****\\\\
 /       \\\\    Swift/Feed.swift
/  /\ /\  \\\\   (part of Hexagen)
\  \_X_/  ////
 \       ////    Copyright © 2015 Alice Atlas (see LICENSE.md)
  \*****////


public class Feed<T> {
    internal var head: RecurringPromise<T>? = RecurringPromise()
    
    public init(@noescape _ fn: (T -> Void, Void -> Void) -> Void) {
        fn({ self._post($0) }, { self._post(nil) })
    }
    
    private func _post(value: T?) {
        if let last = head {
            last._fulfill(value)
            head = last.successor
        } else {
            fatalError("sequence was already closed")
        }
    }
}

internal class RecurringPromise<T>: Promise<T?> {
    lazy internal var successor: RecurringPromise<T>? = RecurringPromise()
    
    private override init() {
        super.init()
        addHandler { [unowned self] value in
            if value == nil {
                self.successor = nil
            }
        }
    }
}
