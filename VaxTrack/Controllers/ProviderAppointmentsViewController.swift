//
//  ProviderAppointmentsViewController.swift
//  VaxTrack
//
//  Created by Joeun Kim on 5/3/21.
//

import UIKit

class ProviderAppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var database: Database = Database()
    var appointments: [Appointment] = []
    var patients: [Patient] = []
    
    var touchedCellBtnTag: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        createArray() // Array of appointments and corresponding providers
    }
    
    func createArray() {
        // Get all appointments set for the provider
        var tempAppointmemnts: [Appointment]? = []
        var error: MyError
        (tempAppointmemnts, error) = database.fetchAppointmentListForProvider(providerID: 0003)
        
        if tempAppointmemnts != nil {
            self.appointments = tempAppointmemnts!
            // Get provider info
            var tempPatients: [Patient] = []
            for appointment in appointments {
                let (patient, error) = database.fetchPatient(patientID:    appointment.patientID)
                tempPatients.append(patient!)
            }
            self.patients = tempPatients
        }
    }
    
    // Cancel appointment
    @IBAction func cancelBtnTouched(_ sender: UIButton) {
        touchedCellBtnTag = sender.tag
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = appointments[indexPath.row]
        let patient = patients[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "providerAppointmentCell", for: indexPath) as! providerAppointmentCell
        cell.setAppointment(appointment: appointment)
        cell.setPatientInfo(patient: patient)
        
        cell.cancelBtn.tag = indexPath.row
        
        return cell
    }
    

}
