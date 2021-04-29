//
//  VaccineRecordDetailViewController.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class VaccineRecordDetailViewController: UIViewController {

    let database = Database()
    var record : Record?
    @IBOutlet weak var vaccine: UILabel!
    @IBOutlet weak var vaccinatedDate: UILabel!
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var provider: UILabel!
    @IBOutlet weak var office: UILabel!
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var document: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let record = record {
            // Vaccine Record Exists (from VaccineRecordViewController)
            vaccine.text = record.vaccineName
            vaccinatedDate.text = record.vaccinatedDate
            
            // Fetch Vaccination Details with Record ID
            database.fetchVaccinationRecordDetails(for: record.recordID)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
