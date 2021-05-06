//
//  ST_User.swift
//  VaxTrack
//
//  Created by Joeun Kim on 5/5/21.
//

import Foundation

class ST_User {
    enum UserType {
        case UNKNOWN
        case PATIENT
        case PROVIDER
        case ADMIN
    }
    static var shared = ST_User()
    
    var userID: Int = 1
    var userType: UserType = .PATIENT
    
    private init() {
        
    }
    
    func printHello() {
        print("Hello World!")
    }
}
