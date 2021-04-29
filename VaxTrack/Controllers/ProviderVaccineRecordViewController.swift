//
//  ProviderVaccineRecordViewController.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class ProviderVaccineRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var records: [Record] = []
    //    var records: [patientName: String, vacciatedDate: String, dob: String] = []
//
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        records = createArray()
    
    }
    
    func createArray() -> [Record] {
        var tempRecords: [Record] = []
        
        let record1 = Record(recordID: 0001, patientID: 0001, providerID: 0001, patientName: "Smith, James", patientDob: "1994-05-19", virusName: "Covid-19", vaccinatedDate: "2021-04-19")
        
        tempRecords.append(record1)
        
        return tempRecords
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = records[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "providerRecordCell") as! providerRecordCell
        cell.setRecord(record: record)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Preparing transition to Vaccine Detail Page
        if segue.identifier == "ProviderVaccineRecordDetail" {
            if let vc = segue.destination as? ProviderVaccineRecordUploadViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.record = records[indexPath.row]
                }
            }
        }
    }

}
