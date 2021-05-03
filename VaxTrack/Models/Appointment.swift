//
//  Appointment.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/29/21.
//
import Foundation


class Appointment {
    var appointmentID: Int!
    var virusType: String!
    var date: Date!
    var patientID: Int!
    var providerID: Int!

    init(appointmentID: Int, virusType: String, date: Date, patientID: Int, providerID: Int) {
        self.appointmentID = appointmentID
        self.virusType = virusType
        self.date = date
        self.patientID = patientID
        self.providerID = providerID
    }
    
    func daysRemaining() -> String! {
        var components = DateComponents()
        components.hour = 0
        components.minute = 0
        let today = Calendar.current.date(from: components)
        
        let numberOfDaysBetween = Calendar.current.dateComponents([.day], from: today!, to: self.date).day
        
        return String(numberOfDaysBetween!)
    }
    
    
    func dateToString() -> String! {
        print("dateToString")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    func timeToString() -> String! {
        return nil
    }
}
