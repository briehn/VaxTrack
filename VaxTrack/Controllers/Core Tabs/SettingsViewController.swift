//
//  SettingsViewController.swift
//  Vaccine499
//
//  Created by Harp on 4/25/21.
//

import UIKit
//import Firebase

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var dob: UITextView!
    @IBOutlet weak var number: UITextView!
    @IBOutlet weak var email: UITextView!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var organization: UITextView!
    @IBOutlet weak var website: UITextView!
    @IBOutlet weak var operationTime: UITextView!
    @IBOutlet weak var services: UITextView!
    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var numberLabel: UITextView!
    @IBOutlet weak var emailLabel: UITextView!
    @IBOutlet weak var addresslabel: UITextView!
    @IBOutlet weak var organizationLabel: UITextView!
    @IBOutlet weak var websiteLabel: UITextView!
    @IBOutlet weak var timeLabel: UITextView!
    @IBOutlet weak var serviceLabel: UITextView!
    
    var userType: ST_User.UserType = .PATIENT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signOut.isHidden = true //until figure out how to sign out and send to login storyboard
        
        if userType == .PATIENT {
            numberLabel.isHidden = true
            emailLabel.isHidden = true
            addresslabel.isHidden = true
            organizationLabel.isHidden = true
            websiteLabel.isHidden = true
            timeLabel.isHidden = true
            serviceLabel.isHidden = true
            number.isHidden = true
            email.isHidden = true
            address.isHidden = true
            organization.isHidden = true
            website.isHidden = true
            operationTime.isHidden = true
            services.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: Any) {
        performSegue(withIdentifier: "signOut", sender: sender)
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        //let auth = Auth.auth()
        
        do {
            //try auth.signOut()
            Database.getInstance().uid = nil
            self.dismiss(animated: true, completion: nil)
        //}catch let signOutError{
        //    print("Error \(signOutError.localizedDescription)")
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
