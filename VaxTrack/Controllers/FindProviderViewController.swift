//
//  FindProviderViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//

import UIKit

class FindProviderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var database: Database = Database()
    var providers: [Provider] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cellDetailContainer: UIView!
    
    var detailContainerViewConstraint = NSLayoutConstraint() // height=0
    var detailContainerViewHeight: CGFloat!
    
    var touchedCellindex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        providers = createArray()
        
    }
    func createArray() -> [Provider] {
        var tempProviders: [Provider] = []
        
        let provider1 = Provider(providerID: 0001, providerName: "Dr. Atrey", organizationName: "UAlbany", address: "1400 Washington Ave, NY 12222", contactPhone: "1(646)-777-7777", contactEmail: "email@email.com", website: "www.website.com")
        let provider2 = Provider(providerID: 0002, providerName: "Dr. Kim", organizationName: "UAlbany", address: "1400 Washington Ave, NY 12222", contactPhone: "1(777)-777-7777", contactEmail: "jkim@email.com", website: "www.website2.com")
        
        tempProviders.append(provider1)
        tempProviders.append(provider2)
        
        return tempProviders
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        detailContainerViewHeight = cellDetailContainer.frame.height // height of expanded view
//        var constHeightEqualToZero: NSLayoutConstraint!
//        cellDetailContainer.translatesAutoresizingMaskIntoConstraints = false
//        constHeightEqualToZero = cellDetailContainer.heightAnchor.constraint(equalToConstant: 0)
//        detailContainerViewConstraint = constHeightEqualToZero
//        constHeightEqualToZero.isActive = true // collapse
    }
    
    // Make an appointment
    @IBAction func makeAppointmentBtnTouched(_ sender: UIButton) {
        touchedCellindex = sender.tag
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")
//        if(cellDetailContainer.frame.height == 0) {
//            if(detailContainerViewConstraint.constant == self.detailContainerViewHeight) {
//                UIView.animate(withDuration: 0.35, animations: {
//                    self.detailContainerViewConstraint.constant = 0
//                    self.view.layoutIfNeeded()
//                }, completion: {_ in
//                })
//            }
//            UIView.animate(withDuration: 0.35, animations: {
//                self.detailContainerViewConstraint.constant = self.detailContainerViewHeight
//                self.view.layoutIfNeeded()
//            }, completion: {_ in
//            })
//        } else {
//            UIView.animate(withDuration: 0.35, animations: {
//                self.detailContainerViewConstraint.constant = 0
//                self.view.layoutIfNeeded()
//            }, completion: {_ in
//            })
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let provider = providers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "providerInfoCell", for: indexPath) as! providerInfoCell
        cell.setProvider(provider: provider)
        cell.makeAppointmentBtn.tag = indexPath.row
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Preparing transition to Vaccine Detail Page
        if segue.identifier == "makeAppointmentSegue" {
            if let vc = segue.destination as? MakeAppointmentViewController {
                if let index = touchedCellindex {
                    vc.provider = providers[index]
                }
            }
        }
    }
    

}
