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
    
    @IBOutlet weak var virusNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var vaccineNameTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    
    @IBOutlet weak var documentUploadBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
