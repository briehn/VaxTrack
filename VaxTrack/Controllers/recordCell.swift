//
//  recordCell.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/26/21.
//

import UIKit

class recordCell: UITableViewCell {
    
    @IBOutlet weak var virusNameLabel: UILabel!
    @IBOutlet weak var vaccinatedDateLabel: UILabel!
    
    func setRecord(record: Record) {
        virusNameLabel.text = record.virusType
        vaccinatedDateLabel.text = record.vaccinatedDate
        
//        let mySub = (record.vaccinatedDate)?.prefix(10)
//        let s2 = record.vaccinatedDate?.dropLast(8)
//        let s3 = record.vaccinatedDate?.dropLast(8)
//
//        vaccinatedDateLabel.text = s3
//        let str = String(mySub)
//        vaccinatedDateLabel.text = mySub
        
    }

}
