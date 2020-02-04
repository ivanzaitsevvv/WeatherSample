//
//  ResultViewController.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        if let result = WeatherLoader.shared.response {
            resultLabel.text = "\(result.temperature) degrees in \(result.locationName)"
        } else if let error = WeatherLoader.shared.error {
            resultLabel.text = error.localizedDescription
        }
    }

}
