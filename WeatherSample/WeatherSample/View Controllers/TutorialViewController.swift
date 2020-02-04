//
//  TutorialViewController.swift
//  WeatherSample
//
//  Created by Ivan Zaitsev on 2/3/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var tutorialCollectionView: UICollectionView!
    @IBOutlet weak var tutorialNavigationButton: UIButton!
    
    private let tutorialTitles = ["Tutorial Screen 1",
                                  "Tutorial Screen 2"]
    
    private let locationManager = LocationManager()
    
    private var currentIndex: Int {
        return Int(tutorialCollectionView.contentOffset.x/tutorialCollectionView.bounds.width)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        locationManager.requestAuthorization { [unowned self] allowed in
            if allowed {
                self.tutorialNavigationButton.isEnabled = true
                WeatherLoader.shared.start()
            }
        }
    }
    
    func setup() {
        updateTutorialNavigationButton()
        tutorialNavigationButton.isEnabled = false
    }
    
    func updateTutorialNavigationButton() {
        let buttonTitle = currentIndex < tutorialTitles.count - 1 ? "Next" : "OK"
        tutorialNavigationButton.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func didClickTutorialNavigationButton() {
        if currentIndex < tutorialTitles.count - 1 {
            let indexPath = IndexPath(item: currentIndex + 1, section: 0)
            tutorialCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            
            if WeatherLoader.shared.state == .loading {
                performSegue(withIdentifier: Constants.Segues.tutorialToLoadingSegue, sender: self)
            } else if WeatherLoader.shared.state == .finished {
                performSegue(withIdentifier: Constants.Segues.tutorialToResultSegue, sender: self)
            }
        }
    }
    
}

extension TutorialViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorialTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = String(describing: TutorialCollectionViewCell.self)
        if
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TutorialCollectionViewCell,
            indexPath.item < tutorialTitles.count {
            
            cell.setup(with: tutorialTitles[indexPath.item])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
}

extension TutorialViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateTutorialNavigationButton()
    }
}
