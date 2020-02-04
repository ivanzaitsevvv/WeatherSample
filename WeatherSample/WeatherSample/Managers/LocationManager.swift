//
//  LocationManager.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import CoreLocation

typealias LocationSuccessCallback = (Double, Double)->()
typealias LocationErrorCallback = (Error)->()
typealias LocationPermissionCallback = (Bool)->()

class LocationManager: NSObject {
    
    let locationManager = CLLocationManager()
    
    private var locationSuccessCallback: LocationSuccessCallback?
    private var locationErrorCallback: LocationErrorCallback?
    private var locationPermissionCallback: LocationPermissionCallback?
    
    override init() {
        super.init()
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        }
    }
    
    func requestAuthorization(completion: LocationPermissionCallback?) {
        locationPermissionCallback = completion
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation(success: LocationSuccessCallback?, error: LocationErrorCallback?) {
        locationSuccessCallback = success
        locationErrorCallback = error
        locationManager.requestLocation()
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationSuccessCallback?(location.coordinate.latitude, location.coordinate.longitude)
        }
        locationSuccessCallback = nil
        locationErrorCallback = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        locationErrorCallback?(error)
        locationSuccessCallback = nil
        locationErrorCallback = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status != .notDetermined else {
            return
        }
        
        locationPermissionCallback?(status == .authorizedWhenInUse)
        locationPermissionCallback = nil
    }
}
