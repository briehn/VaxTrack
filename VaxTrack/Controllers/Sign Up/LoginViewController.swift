//
//  LoginViewController.swift
//  Vaccine499
//
//  Created by Harp on 4/24/21.
//

import UIKit
//import Firebase
//import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
//        emailTextField.text = "will" //    will     shaun
//        passwordTextField.text = "will" // will     shaun
        loginButtonTapped(loginBtn)
    }
    
    

    @IBAction func loginButtonTapped(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        let vc = storyboard.instantiateViewController(identifier: "SignUp")
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
    
    
    func validateFields(){
        
        if(emailTextField.text?.isEmpty == true){
            print("Email is empty")
            return
        }
        
        if(passwordTextField.text?.isEmpty == true){
            print("Password is empty")
            return
        }
        
        loginUser()
        
    }
    /*
    func loginUser(){
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
            guard let strongSelf = self else {return}
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            self!.checkUserInfo()
        }
    }
    
    func checkUserInfo(){
        if Auth.auth().currentUser?.uid != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(identifier: "tabBarHome")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true)
        }
        
    }
    */
    func loginUser(){
        let (loginInfo, error) = Database.getInstance().fetchLogin(login: emailTextField.text!, password: passwordTextField.text!)
        if error.code != 0 || loginInfo == nil {
            print("Error: \(error.msg)")
        } else {
            Database.getInstance().uid = loginInfo!.uid
            ST_User.shared.userID = loginInfo!.uid
            ST_User.shared.userType = loginInfo!.type
        }
        self.checkUserInfo()
    }
    
    func checkUserInfo(){
        if Database.getInstance().uid != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(identifier: "TabBarHome") as? UITabBarController {
                // get user data and store
                if let uid = Database.getInstance().uid {
                    ST_User.shared.userID = uid
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
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
