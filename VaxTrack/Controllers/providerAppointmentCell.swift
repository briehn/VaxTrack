//
//  providerAppointmentCell.swift
//  VaxTrack
//
//  Created by Joeun Kim on 5/3/21.
//

import UIKit

class providerAppointmentCell: UITableViewCell {

    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var daysRemaining: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var virusType: UILabel!

    @IBOutlet weak var cancelBtn: UIButton!
    
    
    func setAppointment(appointment: Appointment) {
        date.text = appointment.dateToString()
        time.text = appointment.timeToString()
        virusType.text = appointment.virusType
        daysRemaining.text = appointment.daysRemaining()
    }
    
    func setPatientInfo(patient: Patient) {
        patientName.text = patient.lastName + ", " + patient.firstName
        dob.text = patient.dob
    }
}
