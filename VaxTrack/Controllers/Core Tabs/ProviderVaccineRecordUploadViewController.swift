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
    
    @IBOutlet weak var virusTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var vaccineNameTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    
    @IBOutlet weak var documentUploadBtn: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        virusTypeLabel.text = record?.virusType
        dateLabel.text = record?.vaccinatedDate
        dobLabel.text = patient?.dob
    }
    
    @IBAction func ConfirmBtnTouched(_ sender: UIButton) {
        // Store record into DB
        var vaccineName = vaccineNameTextField.text
        var manufacturer = manufacturerTextField.text
        
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
