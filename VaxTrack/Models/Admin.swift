//
//  Admin.swift
//  Capstone Project iOS
//
//  Created by Patrick on 5/3/21.
//
import Foundation

class Admin: NSObject {
    
    //properties
    var uid: Int!
    var firstName: String!
    var lastName: String!
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init(uid: Int, firstName: String?, lastName: String?) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "UID: \(uid), FirstName: \(firstName), LastName: \(lastName)"
        
    }
    
    func toDict() -> [String:String] {
        return [
            "aid": JSONParser.toString(uid),
            "firstname": JSONParser.toString(firstName),
            "lastname": JSONParser.toString(lastName)
        ]
    }
    
    

}
