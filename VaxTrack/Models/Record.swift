//
//  Record.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/27/21.
//

import UIKit

class Record {
    var recordID: Int
    var patientID: Int
    var providerID: Int?
    var patientName: String
    var patientDob: String?
    var virusName: String
    var vaccineName: String?
    var vaccinatedDate: String
    var manufacturer: String?
    var provider: String?
    var organization: String?
    var expireDate: String?
    var document: UIImage?
    
    init(recordID: Int, patientID: Int, providerID: Int, patientName: String, patientDob: String, virusName: String, vaccineName: String, vaccinatedDate: String, manufacturer: String, provider: String, organization: String, expireDate: String, document: UIImage) {
        self.recordID = recordID
        self.patientID = patientID
        self.providerID = providerID
        self.patientName = patientName
        self.patientDob = patientDob
        self.virusName = virusName
        self.vaccineName = vaccineName
        self.vaccinatedDate = vaccinatedDate
        self.manufacturer = manufacturer
        self.provider = provider
        self.organization = organization
        self.expireDate = expireDate
        self.document = document
    }
    init(recordID: Int, patientID: Int, patientName: String, virusNmae: String, vaccinatedDate: String) {
        self.recordID = recordID
        self.patientID = patientID
        self.patientName = patientName
        self.virusName = virusNmae
        self.vaccinatedDate = vaccinatedDate
    }
    
    init(recordID: Int, patientID: Int, providerID: Int, patientName: String, patientDob: String, virusName: String, vaccinatedDate: String) {
        self.recordID = recordID
        self.patientID = patientID
        self.providerID = providerID
        self.patientName = patientName
        self.patientDob = patientDob
        self.virusName = virusName
        self.vaccinatedDate = vaccinatedDate
    }

    
    
    
    
}
