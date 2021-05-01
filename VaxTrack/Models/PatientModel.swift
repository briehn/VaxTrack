//
//  PatientModel.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//
import Foundation

class PatientModel: NSObject {
    
    //properties
    
    var uid: Int?
    var nickname: String?
    var realname: String?
    var ssn: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init(uid: Int, nickname: String, realname: String, ssn: String) {
        
        self.uid = uid
        self.nickname = nickname
        self.realname = realname
        self.ssn = ssn
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "UID: \(uid), NickName: \(nickname), RealName: \(realname), SSN: \(ssn)"
        
    }
    
    static func parseJSON(_ datas:NSArray) -> NSObject? {
        if let data = datas[0] as? NSDictionary {
                    
                    //the following insures none of the JsonElement values are nil through optional binding
                    if let realname = data["realname"] as? String,
                        let uid = data["uid"] as? Int,
                        let nickname = data["nickname"] as? String,
                        let ssn = data["ssn"] as? String
                    {
                        let obj = PatientModel(
                            uid :uid,
                            nickname: nickname,
                            realname : realname,
                            ssn : ssn
                        )
                        return obj
                    }
       }
        return nil
    }

}

