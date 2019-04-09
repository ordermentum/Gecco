//
//  AnnotationViewController.swift
//  Gecco
//
//  Created by yukiasai on 2016/01/19.
//  Copyright (c) 2016 yukiasai. All rights reserved.
//

import UIKit
import Gecco

class ViewController: UIViewController {
    //Delegate
    weak var delegate: WalkthroughViewControllerDelegate?
    
    //UI Elements
    var viewsArray: [SpotlightDictionary] = []
    
    //Data
    var walkthroughViewController: WalkthroughViewController = WalkthroughViewController(viewsArray: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup VIew
        self.view.backgroundColor = .red
        
        //Setup UI
        setupUI()
    }
    
    func setupUI() {
        //Add Start Button
        let startButton: UIButton = UIButton(frame: CGRect(x: 16, y: 40, width: 200, height: 30))
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("START TUTORIAL", for: .normal)
        startButton.addTarget(self, action: #selector(startTutorial), for: .touchUpInside)
        self.view.addSubview(startButton)
        
        //Add Image View
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        imageView.backgroundColor = .green
        self.view.addSubview(imageView)
        
        //Add Spotlight View
        var imageSpotlight: SpotlightDictionary = SpotlightDictionary()
        imageSpotlight.spotlight = Spotlight.Oval(center: imageView.center, diameter: 150)
        viewsArray.append(imageSpotlight)
        
        //Add Second Image View
        let secondImageView: UIImageView = UIImageView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        secondImageView.backgroundColor = .green
        self.view.addSubview(secondImageView)
        
        //Add Spotlight View
        var secondImageSpotlight: SpotlightDictionary = SpotlightDictionary()
        secondImageSpotlight.spotlight = Spotlight.RoundedRect(center: secondImageView.center, size: CGSize(width: 150, height: 150), cornerRadius: 15)
        viewsArray.append(secondImageSpotlight)
        
        //Add Third Image View
        let thirdImageView: UIImageView = UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        thirdImageView.backgroundColor = .green
        self.view.addSubview(thirdImageView)
        
        //Create Previous Button
        let previousButton: UIButton = UIButton(frame: CGRect(x: 100, y: 420, width: 100, height: 30))
        previousButton.setTitleColor(.white, for: .normal)
        previousButton.setTitle("Previous", for: .normal)
        
        //Create Helper View
        var previousHelperView: HelperView = HelperView()
        previousHelperView.isPreviousButton = true
        previousHelperView.view = previousButton
        
        //Add Spotlight View
        var thirdImageSpotlight: SpotlightDictionary = SpotlightDictionary()
        thirdImageSpotlight.spotlight = Spotlight.Oval(center: thirdImageView.center, diameter: 150)
        thirdImageSpotlight.helperView = previousHelperView
        viewsArray.append(thirdImageSpotlight)
        
        //Add Fourth Image View
        let fourthImageView: UIImageView = UIImageView(frame: CGRect(x: 100, y: 600, width: 100, height: 100))
        fourthImageView.backgroundColor = .blue
        self.view.addSubview(fourthImageView)
        
        //Add Spotlight View
        var fourthImageSpotlight: SpotlightDictionary = SpotlightDictionary()
        fourthImageSpotlight.spotlight = Spotlight.Rect(center: fourthImageView.center, size: CGSize(width: 150, height: 150))
        viewsArray.append(fourthImageSpotlight)
    }
    
    @objc func startTutorial() {
        //Create Walkthrough Controller
        walkthroughViewController = WalkthroughViewController(viewsArray: viewsArray)
        walkthroughViewController.subDelegate = self
        present(walkthroughViewController, animated: true, completion: nil)
    }
    
    @objc func previousAction() {
        walkthroughViewController.previous(true)
    }
}

extension ViewController: WalkthroughViewControllerDelegate {
    func walkthroughViewControllerPrevious(_ viewController: WalkthroughViewController, isInsideSpotlight: Bool) {
        //TODO
    }
    
    func walkthroughViewControllerWillPresent(_ viewController: WalkthroughViewController, animated: Bool) {
        //TODO
    }
    
    func walkthroughViewControllerWillDismiss(_ viewController: WalkthroughViewController, animated: Bool) {
        //TODO
    }
    
    func walkthroughViewControllerTapped(_ viewController: WalkthroughViewController, isInsideSpotlight: Bool) {
        //TODO
    }
    
    
}
