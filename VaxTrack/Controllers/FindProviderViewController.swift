//
//  FindProviderViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//

import UIKit
import CoreLocation

class FindProviderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate {

    private var database: Database = Database()
    var providers: [Provider] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var touchedCellindex: Int?
    var distances: [Int] = []
    
    var virusTypeSearched: String?
    
    let locationManager = CLLocationManager()
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var currentAddressInCoordinates: CLLocation = CLLocation()
    
    // indicates if location should be updated
    var updateLocation : Bool = false
    
    var providerDistance: [Int : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentLocation()
        
        tableView.delegate = self
        tableView.dataSource = self
        createArray(virusTypeInput: "")
    }
    
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
    
    func createArray(virusTypeInput: String){
        self.distances.removeAll()
        
        var tempProviders: [Provider]? = []
        (tempProviders, _) = database.fetchProvidersWhoOffer(virusType: virusTypeInput)
        
        if let tempProviderList = tempProviders {
            self.distances.removeAll()
            for provider in tempProviderList {
                var providerAddressInCoordinates: CLLocation = CLLocation()

                if updateLocation == true {
                    getPlacemark(addressString: provider.address, callback: { [self] (location) in
                        providerAddressInCoordinates = location
                        
                        var tempDistance = self.currentAddressInCoordinates.distance(from: providerAddressInCoordinates)*0.000621371 // distance in miles
                        
                        var newDistance: Int = Int(Double(tempDistance).rounded())
                        
                        JLog("providerDistance[provider.uid]=\(providerDistance[provider.uid])")
                        
                        if self.providerDistance[provider.uid] == nil || self.updateLocation == true {
                            self.providerDistance[provider.uid] = newDistance
                        }
                        
                        
                        if provider == tempProviderList.last {
                            self.updateLocation = false
                        }
                    } )
                }
            }
        }
        
        providers = tempProviders!
    }
    
    func getCurrentLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // Update current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let coordinates = CLLocationCoordinate2D.init(latitude: locValue.latitude, longitude: locValue.longitude)
        currentAddressInCoordinates = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        self.updateLocation = true
        createArray(virusTypeInput: "")
    }
    
    func getPlacemark( addressString : String, callback: @escaping (CLLocation) -> Void) {
        var coord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    coord = location.coordinate // coordinates
                    callback(CLLocation(latitude: coord.latitude, longitude: coord.longitude))
                }
            }
        }
    }
    
    // Make an appointment
    @IBAction func makeAppointmentBtnTouched(_ sender: UIButton) {
        touchedCellindex = sender.tag
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

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
