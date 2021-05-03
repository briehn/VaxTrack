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
    var providerID: Int
    var virusType: String
    var vaccineName: String?
    var vaccinatedDate: String
    var manufacturer: String?
    var document: UIImage?
    
    init(recordID: Int, patientID: Int, providerID: Int, virusName: String, vaccineName: String, vaccinatedDate: String, manufacturer: String, expireDate: String, document: UIImage) {
        self.recordID = recordID
        self.patientID = patientID
        self.providerID = providerID
        self.virusType = virusName
        self.vaccineName = vaccineName
        self.vaccinatedDate = vaccinatedDate
        self.manufacturer = manufacturer
        self.document = document
    }
    
    
    
    
    
    
    // Test. Hard-coding.
//    init(recordID: Int, patientID: Int, providerID: Int, patientName: String, patientDob: String, virusName: String, vaccineName: String, vaccinatedDate: String, manufacturer: String, provider: String, organization: String, expireDate: String, document: UIImage) {
//        self.recordID = recordID
//        self.patientID = patientID
//        self.providerID = providerID
//        self.patientName = patientName
//        self.patientDob = patientDob
//        self.virusType = virusName
//        self.vaccineName = vaccineName
//        self.vaccinatedDate = vaccinatedDate
//        self.manufacturer = manufacturer
//        self.provider = provider
//        self.organization = organization
//        self.expireDate = expireDate
//        self.document = document
//    }
//    init(recordID: Int, patientID: Int, patientName: String, virusNmae: String, vaccinatedDate: String) {
//        self.recordID = recordID
//        self.patientID = patientID
//        self.patientName = patientName
//        self.virusType = virusNmae
//        self.vaccinatedDate = vaccinatedDate
//    }
//
//    init(recordID: Int, patientID: Int, providerID: Int, patientName: String, patientDob: String, virusName: String, vaccinatedDate: String) {
//        self.recordID = recordID
//        self.patientID = patientID
//        self.providerID = providerID
//        self.patientName = patientName
//        self.patientDob = patientDob
//        self.virusType = virusName
//        self.vaccinatedDate = vaccinatedDate
//    }

    
    
    
    
}
