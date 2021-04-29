//
//  appointmentCell.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class appointmentCell: UITableViewCell {

    @IBOutlet weak var virusName: UILabel!
    @IBOutlet weak var dateHeader: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var organization: UILabel!
    @IBOutlet weak var provider: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var website: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    func setAppointment(appointment: Appointment) {
        virusName.text = appointment.virusType
        dateHeader.text = appointment.daysRemaining()
        date.text = appointment.dateToString()
        time.text = appointment.timeToString()
        address.text = appointment.address
        organization.text = appointment.organizationName
        provider.text = appointment.providerName
        contactPhone.text = appointment.contactPhone
        contactEmail.text = appointment.contactEmail
        website.text = appointment.website
    }
    
}
