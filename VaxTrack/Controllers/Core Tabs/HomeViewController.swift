//
//  ViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/22/21.
//

import UIKit

class HomeViewController: UIViewController, HomeModelProtocol {
    func dataDownloaded(type: String, obj: NSObject?) {
        if (obj == nil) {
            // there must be an error about db connection or php script
            notificationlabel.text = "oops, something went wrong"
        } else {
            // display uid
            let o = obj as? LoginModel
            notificationlabel.text = "welcome user \(o!.uid ?? -1)"
            // Please, consider the workflow for following db querys:
            // fetch user profile to display username
            // fetch user vaccines
            // fetch user appointments
        }
    }
    
    // here is a demo for fetching login information and displaying uid on the notification label
    @IBOutlet weak var notificationlabel: UILabel!
    let hm = HomeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        hm.delegate = self
        // Do any additional setup after loading the view.
        hm.downloadItems("login", ["login":"alice","password":"alice"])
    }


}

