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
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var website: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    func setAppointment(appointment: Appointment) {
        virusName.text = appointment.virusType
        dateHeader.text = appointment.dateToString()
        date.text = appointment.dateToString()
        time.text = DateUtil.timeOnlyToString(date: appointment.date , withFormat: "")
    }
    
    func setProviderInfo(provider: Provider) {
        address.text = provider.address
        organization.text = provider.organizationName
        providerName.text = provider.firstName + " " + provider.lastName
        contactPhone.text = provider.contactPhone
        contactEmail.text = provider.contactEmail
        website.text = provider.website
    }
    
}
