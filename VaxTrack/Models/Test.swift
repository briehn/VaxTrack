//
//  Test.swift
//  Capstone Project iOS
//
//  Created by Patrick on 5/7/21.
//
import UIKit

class Test {
    var testID: Int
    var providerID: Int
    var virusType: String?
    var testName: String?
    var expireDate: Date?
    var description: String?
    var document: UIImage?
    
    init(testID: Int, providerID: Int, virusType: String?, testName: String?, expireDate: Date?, description: String?) {
        self.testID = testID
        self.providerID = providerID
        self.virusType = virusType
        self.testName = testName
        self.expireDate = expireDate
        self.description = description
    }
    
    func toDict() -> [String:String] {
        return [
            "tid": JSONParser.toString(testID),
            "pid": JSONParser.toString(providerID),
            "virustype": JSONParser.toString(virusType),
            "name": JSONParser.toString(testName),
            "expiredate": JSONParser.toString(expireDate),
            "desc": JSONParser.toString(description)
        ]
    }

}
