//
//  DataViewController.swift
//  Capstone Project iOS
//
//  Created by Harp on 3/28/21.
//

import UIKit
import CoreLocation
//import Charts

class DataViewController: UIViewController, CLLocationManagerDelegate {

    var database: Database = Database()
    var patients: [Patient] = []
    var providers: [Provider] = []
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var pieChartView: UIView!
    
    let locationManager = CLLocationManager()
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var cityName: String = ""
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentLocation()
        cityNameLabel.text = cityName
        createArray()
        
        getPlacemark(addressString: "1400 Washington Ave, Albany, NY 12222")
        
    }
    
    func createArray() {
        let allProviders = database.fetchProvidersWhoOffer(virusType: "Covid-19")
        
        var populationByProviderLocation: [String : Int] = [:] // cityName : count
        
        var vaccinatedPopulationByProviderLocation: [String : Int] = [:] // cityName : count
        
        var allPatientIDs: [Int] = []
        var vaccinatedPatientIDs: [Int] = []
        
        if let providerList = allProviders.0 {
            for provider in providerList {
                JLog("providers.count=\(providerList.count)")
                // get provider's city name
                if let cn = getPlacemark(addressString: provider.address) {
                    let cityNameForProvider: String = cn
                    
                    // count covid-19 vaccinated patients by provider
                    let vaccinatedPatients = database.fetchVaccinationRecordsForProviderWithCovid19(providerID: provider.uid)
                    print("vaccinatedPatients=\(vaccinatedPatients)")
                    if vaccinatedPatients != nil {
                        JLog("vaccinatedPatients.count=\(vaccinatedPatients.count)")
                        for pat in vaccinatedPatients {
                            vaccinatedPatientIDs.append(pat.0) // patient id
                        }
                        if vaccinatedPopulationByProviderLocation[cityNameForProvider] != nil {
                            // key exists. sum up
                            vaccinatedPopulationByProviderLocation[cityNameForProvider]! += vaccinatedPatientIDs.count
                        } else {
                            // key doesn't exist. append new
                            vaccinatedPopulationByProviderLocation[cityNameForProvider] = vaccinatedPatientIDs.count
                        }
                    }
                    
                    // count population by provider
                    let allRecords = database.fetchVaccinationRecordsForProvider(providerID: provider.uid)
                    
                    if let patientList = allRecords.0 {
                        for patient in patientList {
                            if !allPatientIDs.contains(patient.patientID) { // ignore duplicate
                                allPatientIDs.append(patient.patientID)
                            }
                        }
                    }
                    if populationByProviderLocation[cityNameForProvider] != nil {
                        // key exists. sum up
                        populationByProviderLocation[cityNameForProvider]! += allPatientIDs.count
                    } else {
                        // key doesn't exist. append new
                        populationByProviderLocation[cityNameForProvider] = allPatientIDs.count
                    }
                }
            }
        }
        
        print("populationByProviderLocation=\(populationByProviderLocation)")
        print("vaccinatedPopulationByProviderLocation=\(vaccinatedPopulationByProviderLocation)")
        
        // sort dictionary by value in descending order
        let sortedOne = populationByProviderLocation.sorted { (first, second) -> Bool in return first.value > second.value
        }
        print("sortedOne=\(sortedOne)")
        
        
        
    }
    
    // Get address. Now only using locality
    func getAddress(fromLocation location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("error")
            } else if let placemarks = placemarks {
                for placemark in placemarks {
                    let address = placemark.locality
                    self.cityName = address!
                    self.cityNameLabel.text = self.cityName
                }
            }
        }
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
        self.coordinates = CLLocationCoordinate2D.init(latitude: locValue.latitude, longitude: locValue.longitude)
        
        if let location = locations.last {
            getAddress(fromLocation: location)
        }
    }
    
    func getPlacemark( addressString : String) -> String? {
        var cn: String = "" // city name
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    cn = placemark.locality! // city name
                    let coord = location.coordinate // coordinates
                    print(cn)
                }
            }
        }
        return cn
    }
    
    
    
    
    // TODO:- For later use in other VC
//    func getCoordinates(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> CLLocationCoordinate2D {
//            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return CLLocationCoordinate2D() }
//            print("locations = \(locValue.latitude) \(locValue.longitude)")
//        return CLLocationCoordinate2D.init(latitude: locValue.latitude, longitude: locValue.longitude)
//        }


}
