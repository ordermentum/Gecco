//
//  WalkthroughViewController.swift
//  Gecco
//
//  Created by Brandon Stillitano on 9/4/19.
//  Copyright © 2019 yukiasai. All rights reserved.
//

import Foundation
import UIKit

open class WalkthroughViewController: SpotlightViewController {
    //Data
    var viewsArray: [SpotlightDictionary] = []
    var stepIndex: Int = 0

    convenience init() {
        self.init(viewsArray: [])
    }
    
    init(viewsArray: [SpotlightDictionary]) {
        self.viewsArray = viewsArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func next(_ labelAnimated: Bool) {
        //Move Annotation
        animateView(view: viewsArray[stepIndex].view, labelAnimated)
        
        //Move Spotlight
        if stepIndex < 1 {
            
        }
        spotlightView.appear(viewsArray[stepIndex].spotlight)
        
        //Update Data
        stepIndex += 1
    }
    
    func previous(_ labelAnimated: Bool) {
        //Update Data
        stepIndex -= 1
        
        //Move Annotation
        animateView(view: viewsArray[stepIndex].view, labelAnimated)
        
        //Move Spotlight
        spotlightView.appear(viewsArray[stepIndex].spotlight)
    }
    
    func animateView(view: UIView, _ animated: Bool) {
        view.animate(withDuration: animated ? 0.25 : 0) {
            view.alpha = index == self.stepIndex ? 1 : 0
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
