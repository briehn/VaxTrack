//
//  AppointmentAvailableTimeCell.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class AppointmentAvailableTimeCell: UITableViewCell {

    @IBOutlet weak var availableTime: UILabel!
    
    func setTime(time: String) {
        availableTime.text = time
    }
    

}
