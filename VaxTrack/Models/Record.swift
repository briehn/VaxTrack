//
//  Record.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/27/21.
//
import UIKit

class Record: NSObject {
    var recordID: Int
    var patientID: Int
    var providerID: Int
    var vaccineID: Int
    var virusType: String
    var vaccineName: String?
    var vaccinatedDate: Date
    var manufacturer: String?
    var document: UIImage?
    
    init(recordID: Int, patientID: Int, providerID: Int, vaccineID: Int, virusName: String, vaccineName: String?, vaccinatedDate: Date, manufacturer: String?) {
        self.recordID = recordID
        self.patientID = patientID
        self.providerID = providerID
        self.vaccineID = vaccineID
        self.virusType = virusName
        self.vaccineName = vaccineName
        self.vaccinatedDate = vaccinatedDate
        self.manufacturer = manufacturer
    }

    init(recordID: Int, patientID: Int, providerID: Int, vaccineID: Int, virusName: String, vaccineName: String?, vaccinatedDate: Date, manufacturer: String?, document: UIImage) {
        self.recordID = recordID
        self.patientID = patientID
        self.providerID = providerID
        self.vaccineID = vaccineID
        self.virusType = virusName
        self.vaccineName = vaccineName
        self.vaccinatedDate = vaccinatedDate
        self.manufacturer = manufacturer
        self.document = document
    }
    
    
    
    
    
    
    // Test. Hard-coding.
//    init(recordID: Int, patientID: Int, providerID: Int, patientName: String?, patientDob: String?, virusName: String?, vaccineName: String?, vaccinatedDate: String?, manufacturer: String?, provider: String?, organization: String?, expireDate: String?, document: UIImage) {
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
//    init(recordID: Int, patientID: Int, patientName: String?, virusNmae: String?, vaccinatedDate: String) {
//        self.recordID = recordID
//        self.patientID = patientID
//        self.patientName = patientName
//        self.virusType = virusNmae
//        self.vaccinatedDate = vaccinatedDate
//    }
//
//    init(recordID: Int, patientID: Int, providerID: Int, patientName: String?, patientDob: String?, virusName: String?, vaccinatedDate: String) {
//        self.recordID = recordID
//        self.patientID = patientID
//        self.providerID = providerID
//        self.patientName = patientName
//        self.patientDob = patientDob
//        self.virusType = virusName
//        self.vaccinatedDate = vaccinatedDate
//    }

    func toDict() -> [String:String] {
        return [
            "uvid": JSONParser.toString(recordID),
            "uid": JSONParser.toString(patientID),
            "pid": JSONParser.toString(providerID),
            "vid": JSONParser.toString(vaccineID),
            "virustype": JSONParser.toString(virusType),
            "name": JSONParser.toString(vaccineName),
            "applytime": JSONParser.toString(vaccinatedDate),
            "manuf": JSONParser.toString(manufacturer)
            //"document": JSONParser.toString(document),
        ]
    }

    
    
    
}
