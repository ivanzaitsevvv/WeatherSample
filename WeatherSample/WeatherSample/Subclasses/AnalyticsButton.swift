//
//  AnalyticsButton.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/4/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class AnalyticsButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(trackButtonClick), for: .touchUpInside)
    }
    
    @objc func trackButtonClick() {
        AnalyticsManager.trackButtonClickEvent(button: self)
    }
    
}
