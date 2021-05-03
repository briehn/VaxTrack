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
    
    static func parsePatient(_ datas:NSArray) -> Patient? {
        if datas.count > 0 {
            if let data = datas[0] as? NSDictionary {
            //the following insures none of the JsonElement values are nil through optional binding
                if let uid = data["uid"] as? Int,
                   let firstName = data["firstName"] as? String,
                   let lastName = data["lastName"] as? String,
                   let recordIDs = data["recordID"] as? [Int],
                   let appointmentIDs = data["appointmentID"] as? [Int],
                   let dob = data["dob"] as? String
                {
                    let obj = Patient(uid: uid, firstName: firstName, lastName: lastName,   recordIDs: recordIDs, appointmentIDs: appointmentIDs, dob: dob)
                    return obj
                }
            }
        }
        return nil
    }
    
    static func parseProvider(_ datas:NSArray) -> NSObject? {
        if datas.count > 0 {
            if let data = datas[0] as? NSDictionary {
//              if let uid = data["uid"] as? Int,
//                  let providerName = data["providerName"] as? String,
            }
        }
        return nil
    }
}