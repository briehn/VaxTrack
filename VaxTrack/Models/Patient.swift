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
    
    init(uid: Int, firstName: String, lastName: String, recordIDs: [Int], appointmentIDs: [Int], dob: String) {
        
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
    
    

}
