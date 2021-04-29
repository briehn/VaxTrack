//
//  Appointment.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/29/21.
//

import Foundation

class Appointment {
    var appointmentID: Int!
    var virusType: String!
    var date: String! // TODO:- change to Date
    var providerName: String!
    var organizationName: String?
    var address: String!
    var contactPhone: String!
    var contactEmail: String?
    var website: String?

    init(appointmentID: Int, virusType: String, date: String, providerName: String, organizationName: String, address: String, contactPhone: String, contactEmail: String, website: String) {
        self.appointmentID = appointmentID
        self.virusType = virusType
        self.date = date
        self.providerName = providerName
        self.organizationName = organizationName
        self.address = address
        self.contactPhone = contactPhone
        self.contactEmail = contactEmail
        self.website = website
    }
    
    func daysRemaining() -> String! {
        return nil
    }
    
    func dateToString() -> String! {
        return nil
    }
    
    func timeToString() -> String! {
        return nil
    }
}


