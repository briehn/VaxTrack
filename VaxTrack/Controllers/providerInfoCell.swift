//
//  providerInfoCell.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class providerInfoCell: UITableViewCell {

    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var makeAppointmentBtn: UIButton!
    
    
    func setProvider(provider: Provider) {
        providerName.text = provider.providerName
        distance.text = "3.2 miles" //TODO:- create a function to calculate distance
        address.text = provider.address
        contactPhone.text = provider.contactPhone
        contactEmail.text = provider.contactEmail
        website.text = provider.website
    }
    
}
