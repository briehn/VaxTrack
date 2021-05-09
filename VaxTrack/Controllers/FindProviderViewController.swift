//
//  FindProviderViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//

import UIKit
import CoreLocation

class FindProviderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private var database: Database = Database()
    var providers: [Provider] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var touchedCellindex: Int?
    var currentAddressInCoordinates: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0) // TODO:- fix
    var distances: [Int] = []
//    var currentAddressInCoordinates: CLLocationCoordinate2D
    
    var virusTypeSearched: String?

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let txt = searchBar.text {
            if  txt.count <= 0 { // no input -> search all providers
                virusTypeSearched = ""
            } else { //input to search -> search providers who offer the vaccine for the input
                // Possible input: Covid-19, Flu, Hepatitis A, MMR, Shingles
                virusTypeSearched = txt
            }
            createArray(virusTypeInput: virusTypeSearched!)
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        createArray(virusTypeInput: "")
        
    }
    func createArray(virusTypeInput: String){
        
        var tempProviders: [Provider]? = []
        var error: MyError
        (tempProviders, error) = database.fetchProvidersWhoOffer(virusType: virusTypeInput)
        

        
//        var providersTemp = resultProvider
//
//        var dictionary = Dictionary<Int, Array<Provider>>() // Key: distance, Value: array of Provider
//        // Filter providers by distance. Provider with more than 100 miles away will be excluded from the array.
//        for index in 0..<providersTemp.count {
//            // Calculate distance by using coordinates
//            var tempDistance = currentAddressInCoordinates.distance(from: providersTemp[index].coordinates!)*0.000621371 // distance in miles
//            let distance = Int(Double(tempDistance).rounded()) // convert to Integer
//            distances.append(distance)
//            if(distance > 100) { // remove provider from the array
//                // TODO: Possible index related error
//                providersTemp.remove(at: index)
//                distances.remove(at: index)
//            } else { // There might be multiple providers with same distance
//                if dictionary[distance] != nil {
//                    // Same key with different value
//                    dictionary[distance]!.append(providers[index])
//                } else {
//                    // First time key appears
//                    dictionary[distance] = [providers[index]]
//                }
//            }
//        }
//
//        let keysSorted = Array(dictionary.keys).sorted(by: <) // sort by distance in ascending order
//        distances.sort(by: <)
//        var tempArrToReturn: [Provider] = []
//
//        for key in keysSorted { // assign all members of
//            if let providerValue = dictionary[key] {
//                for provider in providerValue {
//                    tempArrToReturn.append(provider)
//                }
//            }
//        }
//
        providers = tempProviders!
        
//        self.providers = resultProviders
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    // Make an appointment
    @IBAction func makeAppointmentBtnTouched(_ sender: UIButton) {
        touchedCellindex = sender.tag
        print("touchedCellindex=\(touchedCellindex)")
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
        cell.distance.text = "calculating..."
//        cell.distance.text = String(distances[indexPath.row]) // pass distance calculated
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Preparing transition to Vaccine Detail Page
        if segue.identifier == "makeAppointmentSegue" {
            if let vc = segue.destination as? MakeAppointmentViewController {
                if let index = touchedCellindex {
                    vc.provider = providers[index]
                    vc.virusTypeSearched = virusTypeSearched!
                    
                }
            }
        }
    }
    

}
