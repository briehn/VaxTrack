//
//  LoginModel.swift
//  Capstone Project iOS
//
//  Created by Patrick on 4/29/21.
//

import Foundation

class LoginModel: NSObject {
    
    //properties
    var uid: Int
    var type: ST_User.UserType
    
    //empty constructor
    override init()
    {
        uid = 0
        type = .UNKNOWN
    }
    
    init(uid: Int, type: String) {
        self.uid = uid
        switch type {
        case "U": self.type = .PATIENT
        case "P": self.type = .PROVIDER
        case "A": self.type = .ADMIN
        default: self.type = .UNKNOWN
        }
    }
    
    //prints object's current state
    override var description: String {
        return "UID: \(uid), Type: \(type)"
    }
}
