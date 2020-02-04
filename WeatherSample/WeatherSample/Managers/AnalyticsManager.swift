//
//  AnalyticsManager.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/4/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import Firebase

class AnalyticsManager: NSObject {
    static func trackButtonClickEvent(button: UIButton) {
        guard let title = button.title(for: .normal) else {
            return
        }
        Analytics.logEvent("button_click", parameters: ["title" : title])
    }
}
