//
//  VaccineRecordAddNewViewController.swift
//  Capstone Project iOS
//
//  Created by Joeun Kim on 4/29/21.
//

import UIKit

class VaccineRecordAddNewViewController: UIViewController {

    @IBOutlet weak var virusNameSearchBar: UISearchBar!
    @IBOutlet weak var virusNameLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var manufactorer: UITextField!
    @IBOutlet weak var provider: UITextField!
    @IBOutlet weak var office: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func documentUploadBtn(_ sender: UIButton) {
    }
    @IBAction func addBtn(_ sender: UIButton) {
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
