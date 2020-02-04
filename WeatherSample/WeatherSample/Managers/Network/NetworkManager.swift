//
//  NetworkManager.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import Moya

typealias NetworkCompletionCallback<T> = (T?, Error?)->()

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    
    func weather(by latitude: Double, longitude: Double, completion: @escaping NetworkCompletionCallback<WeatherResponse>) {
        let provider = MoyaProvider<WeatherService>()
        provider.request(.weather(latitude: latitude, longitude: longitude)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let _ = try moyaResponse.filterSuccessfulStatusCodes()
                    if
                        let json = try moyaResponse.mapJSON() as? [String: Any],
                        let locationName = json["name"] as? String,
                        let main = json["main"] as? [String: Any],
                        let temperature = main["temp"] as? Double {
                        
                        completion(WeatherResponse(locationName: locationName, temperature: temperature), nil)
                        
                    } else {
                        let error = NSError(domain:"NetworkManager", code:0, userInfo:[ NSLocalizedDescriptionKey: "Could not parse network response."])
                        
                        completion(nil, error as Error)
                    }
                    
                }
                catch let error {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
                break
            }
        }
    }
    
    
}
