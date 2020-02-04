//
//  WeatherResponse.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

struct WeatherResponse {
    var locationName: String
    var temperature: Double
    
    var result: String {
        return "\(temperature) degrees in \(locationName)"
    }
}
