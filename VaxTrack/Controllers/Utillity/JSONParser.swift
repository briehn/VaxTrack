//
//  JSONParser.swift
//  VaxTrack
//
//  Created by Joeun Kim on 5/2/21.
//

import Foundation

class JSONParser {
    static func toString(_ s: String?) -> String {
        return s ?? ""
    }
    static func toString(_ i: Int?) -> String {
        if i == nil {
            return ""
        } else {
            return String(i!)
        }
    }
    static func toString(_ f: Float32?) -> String {
        if f == nil {
            return ""
        } else {
            return String(f!)
        }
    }
    static func toString(_ d: Date?) -> String {
        if d == nil {
            return ""
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            return dateFormatter.string(from: d!)
        }
    }

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
        if let uid = data["uid"] as? Int {
            let tag = data["tag"] as? String
            let firstName = data["firstname"] as? String
            let lastName = data["lastname"] as? String
            //let recordIDs = data["recordID"] as? [Int]
            //let appointmentIDs = data["appointmentID"] as? [Int]
            let dob = data["birthdate"] as? String
            let obj = Patient(uid: uid, tag: tag, firstName: firstName, lastName: lastName, dob: dob)
            return obj
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
        if let uid = data["pid"] as? Int {
            let tag = data["tag"] as? String
            let firstName = data["firstname"] as? String
            let lastName = data["lastname"] as? String
            let organizationName = data["org"] as? String
            let address = data["address"] as? String
            let contactPhone = data["phone"] as? String
            let contactEmail = data["email"] as? String
            let website = data["website"] as? String
            let officeHourStart = data["officehourstart"] as? String
            let officeHourEnd = data["officehourend"] as? String
            let obj = Provider(uid: uid, tag: tag, firstName: firstName, lastName: lastName, organizationName: organizationName, address: address, contactPhone: contactPhone, contactEmail: contactEmail, website: website, officeHourStart: officeHourStart, officeHourEnd: officeHourEnd)
            return obj
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
        if let uid = data["aid"] as? Int {
            let firstName = data["firstname"] as? String
            let lastName = data["lastname"] as? String
            let obj = Admin(uid: uid, firstName: firstName, lastName: lastName)
            return obj
        }
        return nil
    }
    
    static func parseVaccines(_ datas:NSArray) -> [Vaccine]? {
        var arr = [Vaccine]()
        for i in 0..<datas.count {
            if let data = parseVaccine(datas[i] as! NSDictionary) {
                arr.append(data)
            }
        }
        return arr
    }
    
    static func parseVaccine(_ data:NSDictionary) -> Vaccine? {
        if let vaccineID = data["vid"] as? Int {
            let providerID = data["pid"] as! Int
            let virusType = data["virustype"] as? String
            let vaccineName = data["name"] as? String
            let expireDate = data["expiretime"] as? String
            let manufacturer = data["manuf"] as? String
            let description = data["desc"] as? String
            //let document = data["docid"] as? Int
            //let quantity = data["qty"] as? Int
            //let remain = data["remain"] as? Int
            let obj = Vaccine(vaccineID: vaccineID, providerID: providerID, virusType: virusType, vaccineName: vaccineName, expireDate: expireDate, manufacturer: manufacturer, description: description)
            //, quantity: quantity, remain: remain)
            return obj
        }
        return nil
    }

    static func parseRecords(_ datas:NSArray) -> [Record]? {
        var arr = [Record]()
        for i in 0..<datas.count {
            if let data = parseRecord(datas[i] as! NSDictionary) {
                arr.append(data)
            }
        }
        return arr
    }
    
    static func parseRecord(_ data:NSDictionary) -> Record? {
        if let recordID = data["uvid"] as? Int {
            let patientID = data["uid"] as! Int
            let providerID = data["pid"] as! Int
            let vaccineID = data["vid"] as! Int
            let virusType = data["virustype"] as? String
            let vaccineName = data["name"] as? String
            let vaccinatedDate = data["applytime"] as? String
            let manufacturer = data["manuf"] as? String
            let obj = Record(recordID: recordID, patientID: patientID, providerID: providerID, vaccineID: vaccineID, virusName: virusType, vaccineName: vaccineName, vaccinatedDate: vaccinatedDate, manufacturer: manufacturer)
            return obj
        }
        return nil
    }

    static func parseAppointments(_ datas:NSArray) -> [Appointment]? {
        var arr = [Appointment]()
        for i in 0..<datas.count {
            if let data = parseAppointment(datas[i] as! NSDictionary) {
                arr.append(data)
            }
        }
        return arr
    }
    
    static func parseAppointment(_ data:NSDictionary) -> Appointment? {
        if let appointmentID = data["oid"] as? Int {
            let virusType = data["virustype"] as? String
            let appointtime = data["appointtime"] as! String
            let patientID = data["uid"] as! Int
            let providerID = data["pid"] as! Int
            let date = DateUtil.stringToDate(dateString: appointtime)
            let obj = Appointment(appointmentID: appointmentID, virusType: virusType, date: date!, patientID: patientID, providerID: providerID)
            return obj
        }
        return nil
    }

    static func parseNotifications(_ datas:NSArray) -> [Notification]? {
        var arr = [Notification]()
        for i in 0..<datas.count {
            if let data = parseNotification(datas[i] as! NSDictionary) {
                arr.append(data)
            }
        }
        return arr
    }
    
    static func parseNotification(_ data:NSDictionary) -> Notification? {
        if let id = data["id"] as? Int {
            let title = data["title"] as? String
            let content = data["content"] as? String
            let time = data["time"] as? String
            let obj = Notification(id: id, title: title, content: content, time: time)
            return obj
        }
        return nil
    }

}
