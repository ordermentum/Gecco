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
    @objc func walkthroughViewControllerWillPresent(_ viewController: WalkthroughViewController, animated: Bool)
    @objc func walkthroughViewControllerWillDismiss(_ viewController: WalkthroughViewController, animated: Bool)
    @objc func walkthroughViewControllerTapped(_ viewController: WalkthroughViewController, isInsideSpotlight: Bool)
    @objc func walkthroughViewControllerPrevious(_ viewController: WalkthroughViewController, isInsideSpotlight: Bool)
}

open class WalkthroughViewController: SpotlightViewController {
    //Delegate
    public weak var subDelegate: WalkthroughViewControllerDelegate?
    
    //Data
    var viewsArray: [SpotlightDictionary] = []
    var stepIndex: Int = -1

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
        
        //Setup Helper Views
        for spotlight: SpotlightDictionary in viewsArray {
            //Set Action
            if spotlight.helperView.view.isKind(of: UIButton.self) {
                if let button: UIButton = spotlight.helperView.view as? UIButton {
                    if spotlight.helperView.isPreviousButton {
                        button.addTarget(self, action: #selector(previous(_:)), for: .touchUpInside)
                    } else if spotlight.helperView.isNextButton {
                        button.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
                    }
                }
            } else {
                //Build Gesture Recognizer
                let previousGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(previous(_:)))
                let nextGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(next(_:)))
                
                //Set Action
                if spotlight.helperView.isPreviousButton {
                    spotlight.helperView.view.addGestureRecognizer(previousGestureRecognizer)
                } else if spotlight.helperView.isNextButton {
                    spotlight.helperView.view.addGestureRecognizer(nextGestureRecognizer)
                }
            }
            
            //Add View
            self.view.addSubview(spotlight.helperView.view)
        }
    }
    
    @objc public func next(_ labelAnimated: Bool = true) {
        //Update Data
        stepIndex += 1
        
        //Show/Hide Helper Views
        if viewsArray.count > stepIndex {
            animateView(view: viewsArray[stepIndex].helperView.view, labelAnimated)
        }
        
        //Move Spotlight
        if stepIndex < 1 {
            spotlightView.appear(viewsArray[stepIndex].spotlight, duration: viewsArray[stepIndex].duartion)
        } else if stepIndex == viewsArray.count {
            dismiss(animated: true, completion: nil)
            stepIndex = 0
        } else {
            spotlightView.move(viewsArray[stepIndex].spotlight, duration: viewsArray[stepIndex].duartion, moveType: viewsArray[stepIndex].moveType)
        }
    }
    
    @objc public func previous(_ labelAnimated: Bool = true) {
        //Update Data
        if stepIndex >= viewsArray.count {
            stepIndex = viewsArray.count - 1
        } else if stepIndex < 0 {
            stepIndex = 1
        }
        stepIndex -= 1
        
        //Show/Hide Helper Views
        if viewsArray.count > stepIndex {
            animateView(view: viewsArray[stepIndex].helperView.view, labelAnimated)
        }
        
        //Move Spotlight
        spotlightView.move(viewsArray[stepIndex].spotlight, duration: viewsArray[stepIndex].duartion, moveType: viewsArray[stepIndex].moveType)
    }
    
    func animateView(view: UIView, _ animated: Bool) {
        viewsArray.enumerated().forEach { index, viewObject in
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                viewObject.helperView.view.alpha = index == self.stepIndex ? 1 : 0
            }
        }
    }
}

extension WalkthroughViewController: SpotlightViewControllerDelegate {
    public func spotlightViewControllerWillPresent(_ viewController: SpotlightViewController, animated: Bool) {
        next(false)
    }
    
    public func spotlightViewControllerTapped(_ viewController: SpotlightViewController, isInsideSpotlight: Bool) {
        next(true)
    }
    
    public func spotlightViewControllerWillDismiss(_ viewController: SpotlightViewController, animated: Bool) {
        spotlightView.disappear()
    }
}
