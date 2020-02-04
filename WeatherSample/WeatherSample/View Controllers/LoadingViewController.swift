//
//  LoadingViewController.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotificationObserver()
        WeatherLoader.shared.start()
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(weatherDidLoad(_:)), name: NSNotification.Name(rawValue: Constants.Notifications.weatherDidFinishLoading), object: nil)
    }
    
    @objc func weatherDidLoad(_ notification: Notification) {
        performSegue(withIdentifier: Constants.Segues.loadingToResultSegue, sender: self)
    }

}
