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
//        vaccinatedDateLabel.text = record.vaccinatedDate
//        vaccinatedDateLabel.text = "test"
        vaccinatedDateLabel.text = DateUtil.dateOnlyToString(date: record.vaccinatedDate, withFormat: "")
        dobLabel.text = patient.dob
    }
    
}
