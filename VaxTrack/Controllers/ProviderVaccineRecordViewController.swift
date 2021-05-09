//
//  ProviderVaccineRecordViewController.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class ProviderVaccineRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var database: Database = Database()
    var appointments: [Appointment] = []
    var records: [Record] = []
    var patients: [Patient] = []
    var provider: Provider?
    
    var pendingPatients: [Patient] = []
    var pendingVaccineRecordTypes: [Appointment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        createArray()
    
    }
    
    func createArray() {
        // From DB
        var tempPatients: [Patient] = []
        var (records, _) = database.fetchVaccinationRecordsForProvider(providerID: ST_User.shared.userID)
        if records != nil {
            self.records = records!
            
            (self.provider, _) = database.fetchProvider(providerID: ST_User.shared.userID)
        
            // Get provider info
            for record in records! {
                let (patient, error) = database.fetchPatient(patientID: record.patientID)
                tempPatients.append(patient!)
            }
            self.patients = tempPatients
        }
        
        
        // List patients who are pending for confirmation (fetched from appointment list)
        let (appointments, _) = database.fetchAppointmentListForProvider(providerID: ST_User.shared.userID)
        if appointments != nil {
            for appointment in appointments! {
                var newPatient: Patient?
                (newPatient, _) = database.fetchPatient(patientID: appointment.patientID)
                pendingPatients.append(newPatient!)
                pendingVaccineRecordTypes.append(appointment)
            }
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("records.count=\(records.count)")
        return records.count + pendingPatients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "providerRecordCell") as! providerRecordCell
        let totalCount = records.count + pendingPatients.count
        
        if indexPath.row < pendingPatients.count {
            let pendingRecord = pendingVaccineRecordTypes[indexPath.row] // TODO:- indexpath.row + records.count? //Not working
            let pendingPatient = pendingPatients[indexPath.row]
            cell.setPendingRecord(pendingRecord: pendingRecord, patient: pendingPatient)
        } else {
            let offset = pendingPatients.count
            let record = records[indexPath.row - offset]
            let patient = patients[indexPath.row - offset]
            
            cell.setRecord(record: record, patient: patient)
        }
        
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Preparing transition to Vaccine Detail Page
        if segue.identifier == "ProviderVaccineRecordDetail" {
            if let vc = segue.destination as? ProviderVaccineRecordUploadViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.provider = provider
                    if indexPath.row < pendingPatients.count {
                        vc.pendingPatient = pendingPatients[indexPath.row]
                        vc.pendingVaccineRecord = pendingVaccineRecordTypes[indexPath.row]
                        vc.isRecord = false
                    } else {
                        vc.record = records[indexPath.row - pendingPatients.count]
                        vc.patient = patients[indexPath.row - pendingPatients.count]
                        vc.isRecord = true
                    }
                    
                    
                }
            }
        }
    }

}
