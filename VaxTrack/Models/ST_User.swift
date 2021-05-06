//
//  ST_User.swift
//  VaxTrack
//
//  Created by Joeun Kim on 5/5/21.
//

import Foundation

class ST_User {
    static var shared = ST_User()
    
    var userID: Int = 1
    
    private init() {
        
    }
    
    func printHello() {
        print("Hello World!")
    }
}
