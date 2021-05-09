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
            
            if let pat = patient {
                if let dob = pat.dob {
                    if let dobStr = DateUtil.dateFrom(dateString: dob) {
                        let dobDateOnly = DateUtil.dateOnlyToString(date: dobStr, withFormat: "")
                        dobLabel.text = dobDateOnly
                    }
                }
            }
            
            confirmBtn.isHidden = true
            vaccineNameTextField.text = record?.vaccineName
            manufacturerTextField.text = record?.manufacturer
        } else { // pending record
            virusTypeLabel.text = pendingVaccineRecord?.virusType
            dateLabel.text = DateUtil.dateOnlyToString(date: pendingVaccineRecord!.date, withFormat: "")
            
            if let pat = pendingPatient {
                if let dob = pat.dob {
                    if let dobStr = DateUtil.dateFrom(dateString: dob) {
                        let dobDateOnly = DateUtil.dateOnlyToString(date: dobStr, withFormat: "")
                        dobLabel.text = dobDateOnly
                    }
                }
            }
            
            confirmBtn.isHidden = false
        }
        
    }
    
    @IBAction func ConfirmBtnTouched(_ sender: UIButton) {
        // Store record into DB
        var vaccineNameInput = vaccineNameTextField.text
        var manufacturerInput = manufacturerTextField.text
        
    
        // Fetch vaccine id for the given virusType
        // TODO:- TEMP: vaccineID will be incremented from the last element in the list
        var newVaccineID: Int = 0
        let vaccines: [Vaccine]?
        (vaccines, _) = database.fetchVaccineListForProvider(providerID: pendingVaccineRecord!.providerID)
        if let vaccineList = vaccines {
            newVaccineID = vaccineList.last!.vaccineID
            for vaccine in vaccineList {
                print(vaccine)
                if vaccine.virusType == pendingVaccineRecord!.virusType {
                    newVaccineID = vaccine.vaccineID
                    break
                }
            }
            print("newVaccineID=\(newVaccineID)")
        }
        
        
        if let rec = pendingVaccineRecord {
            if let pat = pendingPatient {
                
                let newRecord = Record.init(recordID: 0, patientID: pat.uid, providerID: rec.providerID, vaccineID: newVaccineID, virusName: rec.virusType, vaccineName: vaccineNameInput, vaccinatedDate: rec.date, manufacturer: manufacturerInput)
                
                print("newRecord=\(newRecord.patientID), \(newRecord.providerID), \(newRecord.vaccineID), \(newRecord.virusType), \(String(describing: newRecord.vaccineName)), \(newRecord.vaccinatedDate), \(String(describing: newRecord.manufacturer))")
                
                
                // Store record into DB - NOT WORKED.
                database.storeRecord(record: newRecord)
                // Delete from appointment - WORKED
//                database.doneAppointment(appointmentID: (pendingVaccineRecord?.appointmentID)!)
            }
        }
        
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
