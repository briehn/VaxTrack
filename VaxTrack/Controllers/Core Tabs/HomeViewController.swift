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
    var userType: ST_User.UserType = .PATIENT
    
    @IBOutlet weak var findProviderTabBar: UIView!
    @IBOutlet weak var vaccineFaqTabBar: UIView!
    
    
    override func viewDidLoad() {
        
        userType = ST_User.shared.userType
        print("userType=\(userType)")
        
        if userType == .PROVIDER {
            findProviderTabBar.isHidden = true
            vaccineFaqTabBar.isHidden = true
        }
    }
    
    @IBAction func vaccineRecordTabTouched(_ sender: Any) {
        if userType == .PATIENT {
            performSegue(withIdentifier: "patientVaccineRecordSegue", sender: nil)
        } else if userType == .PROVIDER {
            performSegue(withIdentifier: "providerVaccineRecordSegue", sender: nil)
        } else { // admin
        }
    }
    
    @IBAction func appointmentTabTouched(_ sender: Any) {
        if userType == .PATIENT {
            performSegue(withIdentifier: "patientAppointmentViewSegue", sender: nil)
        } else if userType == .PROVIDER {
            performSegue(withIdentifier: "providerAppointmentViewSegue", sender: nil)
        } else { // admin
        }
        
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

