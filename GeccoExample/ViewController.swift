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
    //UI Elements
    var viewsArray: [SpotlightDictionary] = []
    
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
        imageSpotlight.helperView = UIView()
        viewsArray.append(imageSpotlight)
        
        //Add Second Image View
        let secondImageView: UIImageView = UIImageView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        secondImageView.backgroundColor = .green
        self.view.addSubview(secondImageView)
        
        //Add Spotlight View
        var secondImageSpotlight: SpotlightDictionary = SpotlightDictionary()
        secondImageSpotlight.spotlight = Spotlight.Oval(center: secondImageView.center, diameter: 150)
        secondImageSpotlight.helperView = UIView()
        viewsArray.append(secondImageSpotlight)
    }
    
    @objc func startTutorial() {
        //Create Walkthrough Controller
        let walkthroughController: WalkthroughViewController = WalkthroughViewController(viewsArray: viewsArray)
        present(walkthroughController, animated: true, completion: nil)
    }
}
