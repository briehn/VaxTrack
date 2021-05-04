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
        createArray()
        
    }
    func createArray(){
        var dbReturn = database.fetchNearbyProviderListOffer(service: "")
        guard let resultProvider:[Provider] = dbReturn.0 else {
            return
        }
        
        var providersTemp = resultProvider

        var dictionary = Dictionary<Int, Array<Provider>>() // Key: distance, Value: array of Provider
        // Filter providers by distance. Provider with more than 100 miles away will be excluded from the array.
        for index in 0..<providersTemp.count {
            // Calculate distance by using coordinates
            var tempDistance = currentAddressInCoordinates.distance(from: providersTemp[index].coordinates!)*0.000621371 // distance in miles
            let distance = Int(Double(tempDistance).rounded()) // convert to Integer
            
            if(distance > 100) { // remove provider from the array
                // TODO: Possible index related error
                providersTemp.remove(at: index)
            } else { // There might be multiple providers with same distance
                if dictionary[distance] != nil {
                    // Same key with different value
                    dictionary[distance]!.append(providers[index])
                } else {
                    // First time key appears
                    dictionary[distance] = [providers[index]]
                }
            }
        }

        let keysSorted = Array(dictionary.keys).sorted(by: <) // sort by distance in ascending order
        
        var tempArrToReturn: [Provider] = []
        
        for key in keysSorted { // assign all members of
            if let providerValue = dictionary[key] {
                for provider in providerValue {
                    tempArrToReturn.append(provider)
                }
            }
        }

        providers = tempArrToReturn
    
        
//        // Test. Hard-cording.
//        var tempProviders: [Provoder] = []
//        let provider1 = Provider(uid: 0001, firstName: "Pradeep", lastName: "Atrey", organizationName: "UAlbany", address: "1400 Washington Ave, NY 12222", contactPhone: "1(646)-777-7777", contactEmail: "email@email.com", website: "www.website.com", office:"office1", officeHourStart: "09:00", officeHourEnd: "17:00")
//        let provider2 = Provider(uid: 0002, firstName: "Joeun", lastName: "Kim", organizationName: "UAlbany", address: "1400 Washington Ave, NY 12222", contactPhone: "1(777)-777-7777", contactEmail: "jkim@email.com", website: "www.website2.com", office: "office2", officeHourStart: "10:00", officeHourEnd: "12:00")
//        tempProviders.append(provider1)
//        tempProviders.append(provider2)
//        providers = tempProviders
        
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
