//
//  VaccineRecordViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//

import UIKit

class VaccineRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let database: Database = Database()
    var records: [Record] = []
    var providers: [Provider] = []
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // From DB
        createArray()
    }
    
    func createArray() {
        // From DB
        let (records, err) = database.fetchVaccinationRecordsForPatient(patientID: ST_User.shared.userID)
        if records != nil {
            self.records = records!
        
            let (tmpPatient, err2) = database.fetchPatient(patientID: ST_User.shared.userID)
            self.patient = tmpPatient
        
            // Get provider info
            var tempProviders: [Provider] = []
            for record in records! {
                let (provider, err3) = database.fetchProvider(providerID: record.providerID)
                tempProviders.append(provider!)
            }
            self.providers = tempProviders
        }

    }

    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
    }
    
    // MARK: - Table View Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return records.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Section for Add New Button
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewCell") as! addNewCell
            return cell
        } else { // Section for existing Records
            let record = records[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell") as! recordCell
            cell.setRecord(record: record)
            
            return cell
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Preparing transition to Vaccine Detail Page
        if segue.identifier == "VaccineRecordDetail" {
            if let vc = segue.destination as? VaccineRecordDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.record = records[indexPath.row]
                    vc.provider = providers[indexPath.row]
                }
            }
        }
    }

}
