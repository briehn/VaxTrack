//
//  JSONParser.swift
//  VaxTrack
//
//  Created by Joeun Kim on 5/2/21.
//

import Foundation

class JSONParser {
    static func parseLogin(_ datas:NSArray) -> LoginModel? {
        if datas.count > 0 {
            print(datas[0])
            if let data = datas[0] as? NSDictionary {
                if let type = data["type"] as? String,
                   let uid = data["targetid"] as? Int
                {
                    let obj = LoginModel(uid:uid, type:type)
                    return obj
                }
            }
        }
        return nil
    }
    
    static func parsePatients(_ datas:NSArray) -> [Patient]? {
        var arr = [Patient]()
        for i in 0..<datas.count {
            if let data = parsePatient(datas[i] as! NSDictionary) {
                arr.append(data)
            }
        }
        return arr
    }
    
    static func parsePatient(_ data:NSDictionary) -> Patient? {
        if data != nil {
            if let uid = data["uid"] as? Int,
               let firstName = data["firstname"] as? String,
               let lastName = data["lastname"] as? String,
               let recordIDs = data["recordID"] as? [Int],
               let appointmentIDs = data["appointmentID"] as? [Int],
               let dob = data["birthdate"] as? String
            {
                let obj = Patient(uid: uid, firstName: firstName, lastName: lastName, recordIDs: recordIDs, appointmentIDs: appointmentIDs, dob: dob)
                return obj
            }
        }
        return nil
    }
    
    static func parseProviders(_ datas:NSArray) -> [Provider]? {
        var arr = [Provider]()
        for i in 0..<datas.count {
            if let data = parseProvider(datas[i] as! NSDictionary) {
                arr.append(data)
            }
        }
        return arr
    }
    
    static func parseProvider(_ data:NSDictionary) -> Provider? {
        if data != nil {
            if let uid = data["pid"] as? Int,
               let firstName = data["firstname"] as? String,
               let lastName = data["lastname"] as? String,
               let organizationName = data["org"] as? String,
               let address = data["address"] as? String,
               let contactPhone = data["phone"] as? String,
               let contactEmail = data["email"] as? String,
               let website = data["website"] as? String,
               let office = data["office"] as? String,
               let officeHour = data["officehour"] as? String
            {
                let obj = Provider(uid: uid, firstName: firstName, lastName: lastName, organizationName: organizationName, address: address, contactPhone: contactPhone, contactEmail: contactEmail, website: website, office: office, officeHour: officeHour)
                return obj
            }
        }
        return nil
    }
    
    static func parseAdmins(_ datas:NSArray) -> [Admin]? {
        var arr = [Admin]()
        for i in 0..<datas.count {
            if let data = parseAdmin(datas[i] as! NSDictionary) {
                arr.append(data)
            }
        }
        return arr
    }
    
    static func parseAdmin(_ data:NSDictionary) -> Admin? {
        if data != nil {
            if let uid = data["aid"] as? Int,
               let firstName = data["firstname"] as? String,
               let lastName = data["lastname"] as? String
            {
                let obj = Admin(uid: uid, firstName: firstName, lastName: lastName)
                return obj
            }
        }
        return nil
    }
    
}
