  /*****\\\\
 /       \\\\    main.swift
/  /\ /\  \\\\   (part of HexagenExamples)
\  \_X_/  ////
 \       ////    Copyright © 2015 Alice Atlas (see LICENSE.md)
  \*****////


import Hexagen
  
  if(true) {
    let counter = { (n: Int) in Gen<Int> { yield in
        for i in 0..<n {
            yield(i)
        }
        }}
    
    for i in counter(5) {
        print(i)
    }
    
    var c: Gen<Int>? = counter(5)
    for i in 0...3 {
        print(c!.next()!)
    }
    c!.forceClose()
    c = nil
    
    let doubler = { Coro<Int?, Int!> { yield in
        yield(nil)
        var ret: Int!
        while let val = yield(ret) {
            ret = val * 2
        }
        print("dun")
        }}
    
    func ok() {
        let x = doubler()
        x.start()
        for i in 0...3 {
            print(x.send(i))
        }
        x.send(nil)
        //x.send(nil)
    }
    ok()
  }else {
    let counter = { (n: Int) in Gen<Int> { yield in
        for i in 0..<n {
            yield(i)
        }
        }}
    
    for i in counter(5) {
        print(i)
    }
  }

