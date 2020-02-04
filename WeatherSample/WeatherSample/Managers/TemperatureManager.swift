//
//  TemperatureManager.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/4/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class TemperatureManager: NSObject {
    static func celsiusToFahrenheit(degrees: Double) -> Double {
        return (degrees * 9/5) + 32
    }
    
    static func fahrenheitToCelsius(degrees: Double) -> Double {
        return (degrees - 32) * 5/9
    }
}
