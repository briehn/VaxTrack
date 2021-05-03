//
//  SignUpViewController.swift
//  Vaccine499
//
//  Created by Harp on 4/24/21.
//

import UIKit
//import Firebase
//import FirebaseAuth

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var compantTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        // Firebase : create user with callback function
        let err = Database.getInstance().regPatientInfo(withEmail: emailTextField.text!, password: passwordTextField.text!)
        if err.code != 0 {
            print("Error \(err.msg)")
            return
        }

        // on creation success
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(identifier: "TabBarHome")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
            
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
