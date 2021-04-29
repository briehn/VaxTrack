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
    
    func setRecord(record: Record) {
        patientName.text = record.patientName
        vaccinatedDateLabel.text = record.vaccinatedDate
        dobLabel.text = record.patientDob
    }
    
}
