//
//  FindProviderViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//

import UIKit
import CoreLocation

class FindProviderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var database: Database = Database()
    var providers: [Provider] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var touchedCellindex: Int?
    var currentAddressInCoordinates: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0) // TODO:- fix
//    var currentAddressInCoordinates: CLLocationCoordinate2D
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        createArray()
        providers = createArray()
        
    }
    func createArray() -> [Provider]{
        var tempProviders: [Provider] = []
//        tempProviders = database.fetchNearbyProviderListOffer(service: "")!
//        var dictionary = Dictionary<CLLocationDistance, Array<Provider>>() // [CLLocationDistance : Provider]
//        // Filter providers by distance. Provider with more than 100 miles away will be excluded from the array.
//        for index in 0..<tempProviders.count {
//            let tempDistance = currentAddressInCoordinates.distance(from: tempProviders[index].coordinates!)*0.000621371 // distance in miles
//            if(tempDistance > 100) { // remove provider from the array
//                tempProviders.remove(at: index)
//            } else {
//                if dictionary[tempDistance] != nil {
//                    dictionary[tempDistance]?.append(tempProviders[index])
//                } else {
//                    dictionary[tempDistance] = [tempProviders[index]]
//                }
//            }
//        }
//
//        let temp = Array(dictionary.keys).sorted(by: <)
//
//        tempProviders = temp
//
//        self.providers = tempProviders
        
        // Test. Hard-cording.
        let provider1 = Provider(uid: 0001, firstName: "Pradeep", lastName: "Atrey", organizationName: "UAlbany", address: "1400 Washington Ave, NY 12222", contactPhone: "1(646)-777-7777", contactEmail: "email@email.com", website: "www.website.com")
        let provider2 = Provider(uid: 0002, firstName: "Joeun", lastName: "Kim", organizationName: "UAlbany", address: "1400 Washington Ave, NY 12222", contactPhone: "1(777)-777-7777", contactEmail: "jkim@email.com", website: "www.website2.com")
        tempProviders.append(provider1)
        tempProviders.append(provider2)
        
        return tempProviders
    }
    
    func sortProvidersByDistanceInASC(usortedProviders: [Provider]) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    // Make an appointment
    @IBAction func makeAppointmentBtnTouched(_ sender: UIButton) {
        touchedCellindex = sender.tag
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("You tapped me!")

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
