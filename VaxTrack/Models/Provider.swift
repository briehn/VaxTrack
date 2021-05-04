//
//  Provider.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/29/21.
//
import Foundation
import CoreLocation

class Provider: NSObject {
    var uid: Int!
    var tag: String?
    var firstName: String!
    var lastName: String!
    var organizationName: String?
    var address: String!
    var contactPhone: String!
    var contactEmail: String?
    var website: String?
    var officeHourStart: String?
    var officeHourEnd: String?
    var services: [String]!
    var coordinates: CLLocation?

    init(tag: String?, firstName: String?, organizationName: String?) {
        self.tag = tag
        self.firstName = firstName
        self.organizationName = organizationName
    }
    
    init(uid: Int, tag: String?, firstName: String?, lastName: String?, organizationName: String?, address: String?, contactPhone: String?, contactEmail: String?, website: String?, officeHour:String?, officeHourStart:String?, officeHourEnd:String?, coordinates: CLLocation) {
        self.uid = uid
        self.tag = tag
        self.firstName = firstName
        self.lastName = lastName
        self.organizationName = organizationName
        self.address = address
        self.contactPhone = contactPhone
        self.contactEmail = contactEmail
        self.website = website
        self.officeHourStart = officeHourStart
        self.officeHourEnd = officeHourEnd
        self.coordinates = coordinates
    }
    
    init(uid: Int, tag: String?, firstName: String?, lastName: String?, organizationName: String?, address: String?, contactPhone: String?, contactEmail: String?, website: String?, officeHourStart:String?, officeHourEnd:String?) {
        self.uid = uid
        self.tag = tag
        self.firstName = firstName
        self.lastName = lastName
        self.organizationName = organizationName
        self.address = address
        self.contactPhone = contactPhone
        self.contactEmail = contactEmail
        self.website = website
        self.officeHourStart = officeHourStart
        self.officeHourEnd = officeHourEnd
    }
    
    func toDict() -> [String:String] {
        return [
            "pid": JSONParser.toString(uid),
            "tag": JSONParser.toString(tag),
            "firstname": JSONParser.toString(firstName),
            "lastname": JSONParser.toString(lastName),
            "org": JSONParser.toString(organizationName),
            "address": JSONParser.toString(address),
            "phone": JSONParser.toString(contactPhone),
            "email": JSONParser.toString(contactEmail),
            "website": JSONParser.toString(website),
            "officehourstart": JSONParser.toString(officeHourStart),
            "officehourend": JSONParser.toString(officeHourEnd)
        ]
    }
    
}
