//
//  TestResult.swift
//  Capstone Project iOS
//
//  Created by Patrick on 5/7/21.
//
import UIKit

class TestResult: NSObject {
    enum Result {
        case UNKNOWN
        case POSITIVE
        case NEGATIVE
    }
    var resultID: Int
    var patientID: Int
    var providerID: Int
    var testID: Int
    var virusType: String
    var testName: String?
    var testDate: Date
    var reportDate: Date?
    var result: Result
    var document: UIImage?
    
    init(resultID: Int, patientID: Int, providerID: Int, testID: Int, virusName: String, testName: String?, testDate: Date, reportDate: Date?, result: String?) {
        self.resultID = resultID
        self.patientID = patientID
        self.providerID = providerID
        self.testID = testID
        self.virusType = virusName
        self.testName = testName
        self.testDate = testDate
        self.reportDate = reportDate
        if result == nil {
            self.result = .UNKNOWN
        } else {
            switch result! {
            case "P": self.result = .POSITIVE
            case "N": self.result = .NEGATIVE
            default: self.result = .UNKNOWN
            }
        }
    }

    init(resultID: Int, patientID: Int, providerID: Int, testID: Int, virusName: String, testName: String?, testDate: Date, reportDate: Date?, result: String?, document: UIImage) {
        self.resultID = resultID
        self.patientID = patientID
        self.providerID = providerID
        self.testID = testID
        self.virusType = virusName
        self.testName = testName
        self.testDate = testDate
        self.reportDate = reportDate
        self.document = document
        if result == nil {
            self.result = .UNKNOWN
        } else {
            switch result! {
            case "P": self.result = .POSITIVE
            case "N": self.result = .NEGATIVE
            default: self.result = .UNKNOWN
            }
        }
    }
    
    func toDict() -> [String:String] {
        return [
            "utid": JSONParser.toString(resultID),
            "uid": JSONParser.toString(patientID),
            "pid": JSONParser.toString(providerID),
            "tid": JSONParser.toString(testID),
            "virustype": JSONParser.toString(virusType),
            "name": JSONParser.toString(testName),
            "testtime": JSONParser.toString(testDate),
            "reporttime": JSONParser.toString(reportDate),
            "result": JSONParser.toString(result)
            //"document": JSONParser.toString(document),
        ]
    }

    
    
    
}
