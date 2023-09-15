//
//  LocationManager.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 12/09/23.
//

import SwiftUI
import CoreLocation

// Protocol to represent a geocoder
protocol CLGeocoderProtocol {
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void)
}

extension CLGeocoder: CLGeocoderProtocol { }

class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var lastSearchedCity: String?
    var geocoder: CLGeocoderProtocol
    
    init(geocoder: CLGeocoderProtocol = CLGeocoder()) {
        self.geocoder = geocoder
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {

            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                if let placemark = placemarks?.first {
                    let city = placemark.locality ?? ""
                    self?.lastSearchedCity = city
                }
            }
        }
    }
}
