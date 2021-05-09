//
//  ProviderVaccineRecordUploadViewController.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/28/21.
//

import UIKit

class ProviderVaccineRecordUploadViewController: UIViewController {

    let database = Database()
    var record : Record?
    var patient : Patient?
    
    var provider : Provider?
    
    var isRecord = true
    
    var pendingPatient: Patient?
    var pendingVaccineRecord: Appointment?
    
    
    @IBOutlet weak var virusTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var vaccineNameTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    
    @IBOutlet weak var documentUploadBtn: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isRecord { // record history
            virusTypeLabel.text = record?.virusType
            dateLabel.text = DateUtil.dateOnlyToString(date: record!.vaccinatedDate, withFormat: "")
            dobLabel.text = patient?.dob
            confirmBtn.isHidden = true
            vaccineNameTextField.text = record?.vaccineName
            manufacturerTextField.text = record?.manufacturer
        } else { // pending record
            virusTypeLabel.text = pendingVaccineRecord?.virusType
            dateLabel.text = DateUtil.dateOnlyToString(date: pendingVaccineRecord!.date, withFormat: "")
            dobLabel.text = pendingPatient?.dob
            confirmBtn.isHidden = false
        }
        
    }
    
    @IBAction func ConfirmBtnTouched(_ sender: UIButton) {
        // Store record into DB
        var vaccineNameInput = vaccineNameTextField.text
        var manufacturerInput = manufacturerTextField.text
        
        record?.vaccineName = vaccineNameInput
        record?.manufacturer = manufacturerInput
        
//        database.storeRecord(record: record!)
        
        confirmBtn.isHidden = true // enable to edit record for the next use
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
