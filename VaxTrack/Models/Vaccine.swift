//
//  Vaccine.swift
//  Capstone Project iOS
//
//  Created by Patrick on 5/3/21.
//
import UIKit

class Vaccine {
    var vaccineID: Int
    var providerID: Int
    var virusType: String?
    var vaccineName: String?
    var expireDate: String?
    var manufacturer: String?
    var description: String?
    var document: UIImage?
    var quantity: Int?
    var remain: Int?
    
    init(vaccineID: Int, providerID: Int, virusType: String?, vaccineName: String?, expireDate: String?, manufacturer: String?, description: String?) {
        self.vaccineID = vaccineID
        self.providerID = providerID
        self.virusType = virusType
        self.vaccineName = vaccineName
        self.expireDate = expireDate
        self.manufacturer = manufacturer
        self.description = description
    }
    
    init(vaccineID: Int, providerID: Int, virusType: String?, vaccineName: String?, expireDate: String?, manufacturer: String?, description: String?, quantity: Int?, remain: Int?) {
        self.vaccineID = vaccineID
        self.providerID = providerID
        self.virusType = virusType
        self.vaccineName = vaccineName
        self.expireDate = expireDate
        self.manufacturer = manufacturer
        self.description = description
        self.quantity = quantity
        self.remain = remain
    }
    
    func toDict() -> [String:String] {
        return [
            "vid": JSONParser.toString(vaccineID),
            "pid": JSONParser.toString(providerID),
            "virustype": JSONParser.toString(virusType),
            "name": JSONParser.toString(vaccineName),
            "expiredate": JSONParser.toString(expireDate),
            "manuf": JSONParser.toString(manufacturer),
            "desc": JSONParser.toString(description),
            "qty": JSONParser.toString(quantity),
            "remain": JSONParser.toString(remain)
        ]
    }

    
    
    
}
