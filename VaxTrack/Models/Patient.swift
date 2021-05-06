//
//  PatientModel.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//
import Foundation

class Patient: NSObject {
    
    //properties
    var uid: Int!
    var firstName: String!
    var lastName: String!
    var recordIDs: [Int]?
    var appointmentIDs: [Int]?
    var dob: String!
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init(uid: Int, firstName: String?) {
        self.uid = uid
        self.firstName = firstName
    }
    init(uid: Int, firstName: String?, lastName: String?, dob: String?) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
    }
    init(uid: Int, firstName: String?, lastName: String?, recordIDs: [Int]?, appointmentIDs: [Int]?, dob: String?) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.recordIDs = recordIDs
        self.appointmentIDs = appointmentIDs
        self.dob = dob
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "UID: \(uid), FirstName: \(firstName), LastName: \(lastName), dob: \(dob)"
        
    }
    
    func toDict() -> [String:String] {
        return [
            "uid": JSONParser.toString(uid),
            "firstname": JSONParser.toString(firstName),
            "lastname": JSONParser.toString(lastName),
            "birthdate": JSONParser.toString(dob)
        ]
    }
    
    

}
