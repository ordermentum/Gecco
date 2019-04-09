//
//  WalkthroughViewController.swift
//  Gecco
//
//  Created by Brandon Stillitano on 9/4/19.
//  Copyright © 2019 yukiasai. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol WalkthroughViewControllerDelegate: class {
    @objc optional func walkthroughViewControllerWillPresent(_ viewController: WalkthroughViewController, animated: Bool)
    @objc optional func walkthroughViewControllerWillDismiss(_ viewController: WalkthroughViewController, animated: Bool)
    @objc optional func walkthroughViewControllerTapped(_ viewController: WalkthroughViewController, isInsideSpotlight: Bool)
}

open class WalkthroughViewController: SpotlightViewController {
    //Data
    var viewsArray: [SpotlightDictionary] = []
    var stepIndex: Int = 0

    convenience init() {
        self.init(viewsArray: [])
    }
    
    public init(viewsArray: [SpotlightDictionary]) {
        self.viewsArray = viewsArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Delegate
        delegate = self
        
        //Add Views
        for spotlight: SpotlightDictionary in viewsArray {
            self.view.addSubview(spotlight.helperView)
        }
        
        //Start Walkhrough
        next(true)
    }
    
    func next(_ labelAnimated: Bool) {
        //Move Annotation
        animateView(view: viewsArray[stepIndex].helperView, labelAnimated)
        
        //Move Spotlight
        if stepIndex < 1 {
            spotlightView.appear(viewsArray[stepIndex].spotlight, duration: viewsArray[stepIndex].duartion)
        } else if stepIndex == viewsArray.count - 1 {
            dismiss(animated: true, completion: nil)
        } else {
            spotlightView.move(viewsArray[stepIndex].spotlight, duration: viewsArray[stepIndex].duartion, moveType: viewsArray[stepIndex].moveType)
        }
        
        //Update Data
        stepIndex += 1
    }
    
    func previous(_ labelAnimated: Bool) {
        //Move Annotation
        animateView(view: viewsArray[stepIndex].helperView, labelAnimated)
        
        //Move Spotlight
        spotlightView.move(viewsArray[stepIndex].spotlight, duration: viewsArray[stepIndex].duartion, moveType: viewsArray[stepIndex].moveType)
            
        //Update Data
        stepIndex -= 1
    }
    
    func animateView(view: UIView, _ animated: Bool) {
        viewsArray.enumerated().forEach { index, viewObject in
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                viewObject.helperView.alpha = index == self.stepIndex ? 1 : 0
            }
        }
    }
}

extension WalkthroughViewController: SpotlightViewControllerDelegate {
    private func spotlightViewControllerWillPresent(_ viewController: SpotlightViewController, animated: Bool) {
        next(false)
    }
    
    private func spotlightViewControllerTapped(_ viewController: SpotlightViewController, isInsideSpotlight: Bool) {
        next(true)
    }
    
    private func spotlightViewControllerWillDismiss(_ viewController: SpotlightViewController, animated: Bool) {
        spotlightView.disappear()
    }
}
