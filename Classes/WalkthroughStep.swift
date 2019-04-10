//
//  Point.swift
//  Gecco
//
//  Created by Brandon Stillitano on 9/4/19.
//  Copyright © 2019 yukiasai. All rights reserved.
//

import Foundation
import UIKit

public struct WalkthroughStep {
    public init() {
        // This initializer intentionally left empty
    }
    
    public var spotlight: SpotlightType = Spotlight.Oval.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    public var helperView: HelperView = HelperView()
    public var duration: TimeInterval = TimeInterval()
    public var moveType: SpotlightMoveType = SpotlightMoveType.direct
}

public struct HelperView {
    public init() {
        // This initializer intentionally left empty
    }
    
    public var view: UIView = UIView()
    public var isPreviousButton: Bool = false
    public var isNextButton: Bool = false
}
