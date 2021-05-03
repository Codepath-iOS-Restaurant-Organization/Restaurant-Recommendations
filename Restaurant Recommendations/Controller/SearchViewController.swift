//
//  SearchViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    var stringLon: String?
    var stringLat: String?

    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    

}

//Once got current user's location update the nil strings
extension SearchViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManger.stopUpdatingLocation()
        
        if let userLocation = locations.last {
            
            stringLon = String(userLocation.coordinate.longitude)
            stringLat = String(userLocation.coordinate.latitude)
            
        }
    }
}
