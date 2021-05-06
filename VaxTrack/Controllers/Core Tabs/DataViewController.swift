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

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var pieChartView: UIView!
    
    let locationManager = CLLocationManager()
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var cityName: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
        cityNameLabel.text = cityName
        
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
    
    
    
    
    // TODO:- For later use in other VC
//    func getCoordinates(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> CLLocationCoordinate2D {
//            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return CLLocationCoordinate2D() }
//            print("locations = \(locValue.latitude) \(locValue.longitude)")
//        return CLLocationCoordinate2D.init(latitude: locValue.latitude, longitude: locValue.longitude)
//        }


}
