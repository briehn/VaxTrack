//
//  SignUpViewController.swift
//  Vaccine499
//
//  Created by Harp on 4/24/21.
//

import UIKit
//import Firebase
//import FirebaseAuth

enum userType {
    case patient
    case provider
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var companyTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signUpUserType: userType = .patient
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (signUpUserType == .patient) {
            if let tf = companyTextField {
                tf.isHidden = true
            }
        }
    }

    
    @IBAction func userTypeBtnTouched(_ sender: UIButton) {
        if (sender.tag == 0) { // patient
            signUpUserType = .patient
        } else if (sender.tag == 1) { // provider
            signUpUserType = .provider
        }
        performSegue(withIdentifier: "SignUpSegue", sender: self)
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        if(emailTextField.text?.isEmpty == true){
            print("Missing email")
            return
        }
        if(passwordTextField.text?.isEmpty == true){
            print("Password Missing")
            return
        }
        signUp()
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "login")
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
/*
    func signUp(){
        // Firebase : create user with callback function
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            // creation error handling
            guard let user = authResult?.user, error == nil else{
                print("Error \(error?.localizedDescription)")
                return
            }

            // on creation success
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(identifier: "TabBarHome")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
            
        }
    }
*/
    func signUp(){
        var err: MyError
        // Register as a new user (provider or patient)
        switch signUpUserType {
        case .patient:
            print("asdfasdf")
            err = Database.getInstance().regPatientInfo(withEmail: emailTextField.text!, password: passwordTextField.text!)
        case .provider:
            print("qwerqwer")
            err = Database.getInstance().regProviderInfo(withEmail: emailTextField.text!, password: passwordTextField.text!, org: companyTextField.text!)
        }
        
        print("Reg Result Error Msg: \(err.msg!)")
        
        if err.code != 0 {
            print("Error \(err.msg!)")
            return
        }

        // on creation success
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(identifier: "TabBarHome")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
            
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpSegue" {
            if let vc = segue.destination as? SignUpViewController {
                vc.signUpUserType = self.signUpUserType
            }
        }
    }
}
