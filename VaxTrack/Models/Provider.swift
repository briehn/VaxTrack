//
//  Provider.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/29/21.
//

import Foundation

class Provider {
    var providerID: Int!
    var providerName: String!
    var organizationName: String?
    var address: String!
    var contactPhone: String!
    var contactEmail: String?
    var website: String?
    var services: [String]!

    init(providerID: Int, providerName: String, organizationName: String, address: String, contactPhone: String, contactEmail: String, website: String) {
        self.providerID = providerID
        self.providerName = providerName
        self.organizationName = organizationName
        self.address = address
        self.contactPhone = contactPhone
        self.contactEmail = contactEmail
        self.website = website
    }
}

