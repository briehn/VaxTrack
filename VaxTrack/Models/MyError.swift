//
//  MyError.swift
//  Capstone Project iOS
//
//  Created by Patrick on 5/3/21.
//
import Foundation

class MyError: Error {
    //properties
    var code: Int
    var msg: String?

    //empty constructor
    init() {
        code = 0
        msg = nil
    }
    
    init(_ code: Int) {
        self.code = code
    }
    
    init(_ code: Int, _ msg: String?) {
        self.code = code
        self.msg = msg
    }
    
    //prints object's current state
    var description: String {
        return "code: \(code), msg: \(msg ?? "")"
    }

}
