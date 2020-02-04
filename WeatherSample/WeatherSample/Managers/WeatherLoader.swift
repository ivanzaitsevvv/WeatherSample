//
//  WeatherLoader.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

enum WeatherLoaderState {
    case notRunning
    case loading
    case finished
}

class WeatherLoader: NSObject {
    static let shared = WeatherLoader()
    
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    
    private let locationManager = LocationManager()
    
    var state: WeatherLoaderState = .notRunning {
        didSet {
            if state == .finished {
                NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notifications.weatherDidFinishLoading), object: nil)
            }
        }
    }
    
    private var response: WeatherResponse?
    private var error: Error?
    
    var result: String {
        if let response = response {
            return "\(response.temperature) degrees in \(response.locationName)"
        } else if let error = error {
            return error.localizedDescription
        } else {
            return ""
        }
    }
    
    func start() {
        guard state == .notRunning else {
            return
        }
        
        state = .loading
        
        DispatchQueue.global().async {
            let group = DispatchGroup()
            
            group.enter()
            self.locationManager.requestLocation(success: { [unowned self] (latitude, longitude) in
                
                self.latitude = latitude
                self.longitude = longitude
                group.leave()
            }) { error in
                self.error = error
                self.state = .finished
                return
            }
            
            group.wait()
            
            group.enter()
            NetworkManager.shared.weather(by: self.latitude, longitude: self.longitude, completion: { [unowned self] response, error in
                
                self.response = response
                self.error = error
                self.state = .finished
                group.leave()
            })
        }
    }
}
