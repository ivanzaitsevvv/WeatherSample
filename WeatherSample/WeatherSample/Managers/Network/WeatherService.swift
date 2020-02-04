//
//  WeatherService.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import Moya

enum WeatherService {
    case weather(latitude: Double, longitude: Double)
}

extension WeatherService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Network.weatherBaseURL)!
    }
    
    var path: String {
        switch self {
        case .weather:
            return "/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .weather:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .weather(let latitude, let longitude):
            return .requestParameters(parameters: ["lat" : latitude, "lon" : longitude, "units" : "metric", "appid" : Constants.Network.weatherAPIKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
