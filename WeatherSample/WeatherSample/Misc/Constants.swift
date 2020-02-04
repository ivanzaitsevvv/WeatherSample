//
//  Constants.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

struct Constants {
    struct UserDefaultsKeys {
        static let applicationLaunchCount = "applicationLaunchCount"
    }
    
    struct Segues {
        static let tutorialToLoadingSegue = "tutorialToLoadingSegue"
        static let tutorialToResultSegue = "tutorialToResultSegue"
        static let loadingToResultSegue = "loadingToResultSegue"
    }
    
    struct Network {
        static let weatherBaseURL = "https://openweathermap.org/data/2.5"
        static let weatherAPIKey = "000a1ae1cfcb63041b0ca1c053519bcc"
    }
    
    struct Notifications {
        static let weatherDidFinishLoading = "WeatherDidFinishLoading"
    }
}
