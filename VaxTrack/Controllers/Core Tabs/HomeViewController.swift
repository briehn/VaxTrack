//
//  ViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/22/21.
//

import UIKit

enum UserType {
    case PATIENT
    case PROVIDER
    case ADMIN
}

class HomeViewController: UIViewController {
    
    let database: Database = Database()
    var providers: Provider?
    var patient: Patient?
    var userType: UserType = .PATIENT
    
    override func viewDidLoad() {
        let (tmpPatient, _) = database.fetchPatient(patientID: ST_User.shared.userID)
        let (tmpProvider, _) = database.fetchProvider(providerID: ST_User.shared.userID)
        
        if tmpPatient != nil {
            print("patient.")
            userType = .PATIENT
        } else if tmpProvider != nil {
            print("provider.")
            userType = .PROVIDER
        } else {
            print("admin")
            userType = .ADMIN
        }
    }
    
    @IBAction func vaccineRecordTabTouched(_ sender: Any) {
        if userType == .PROVIDER {
            print("provider!")
            performSegue(withIdentifier: "providerVaccineRecordSegue", sender: nil)
        } else if userType == .PATIENT {
            print("patient!")
            performSegue(withIdentifier: "patientVaccineRecordSegue", sender: nil)
        } else {
            print("admin!")
        }
    }
    
    @IBAction func appointmentTabTouched(_ sender: Any) {
        
    }
    
    @IBAction func testResultTabTouched(_ sender: Any) {
        
    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
//
    
    
    
    
    
    
    
    
    
    
    
    
    
    //func dataDownloaded(type: String, obj: NSObject?) {
    //    if (obj == nil) {
    //        // there must be an error about db connection or php script
    //        notificationlabel.text = "oops, something went wrong"
    //    } else {
    //        // display uid
    //        let o = obj as? LoginModel
    //        notificationlabel.text = "welcome user \(o!.uid ?? -1)"
    //        // Please, consider the workflow for following db querys:
    //        // fetch user profile to display username
    //        // fetch user vaccines
    //        // fetch user appointments
    //    }
   // }
    
//    // here is a demo for fetching login information and displaying uid on the notification label
//    @IBOutlet weak var notificationlabel: UILabel!
//    //let hm = DatabaseConnection()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//        //hm.delegate = self
//        // Do any additional setup after loading the view.
//        //hm.downloadItems("login", ["login":"alice","password":"alice"])
//    }


}

