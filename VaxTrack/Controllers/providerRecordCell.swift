//
//  providerRecordCell.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class providerRecordCell: UITableViewCell {

    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var vaccinatedDateLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    func setRecord(record: Record, patient: Patient) {
        patientName.text = patient.lastName + ", " + patient.firstName
        vaccinatedDateLabel.text = DateUtil.dateOnlyToString(date: record.vaccinatedDate, withFormat: "")
        
        if let dob = patient.dob {
            if let dobStr = DateUtil.dateFrom(dateString: dob) {
                let dobDateOnly = DateUtil.dateOnlyToString(date: dobStr, withFormat: "")
                dobLabel.text = dobDateOnly
            }
        }
    }
    
    func setPendingRecord(pendingRecord: Appointment, patient: Patient) {
        patientName.text = patient.lastName + ", " + patient.firstName
        vaccinatedDateLabel.text = DateUtil.dateOnlyToString(date: pendingRecord.date, withFormat: "")
        
        if let dob = patient.dob {
            if let dobStr = DateUtil.dateFrom(dateString: dob) {
                let dobDateOnly = DateUtil.dateOnlyToString(date: dobStr, withFormat: "")
                dobLabel.text = dobDateOnly
            }
        }
    }
    
}
