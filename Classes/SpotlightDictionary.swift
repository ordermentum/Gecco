//
//  Point.swift
//  Gecco
//
//  Created by Brandon Stillitano on 9/4/19.
//  Copyright © 2019 yukiasai. All rights reserved.
//

import Foundation
import UIKit

public struct SpotlightDictionary {
    public init() {
        // This initializer intentionally left empty
    }
    
    public var spotlight: SpotlightType = Spotlight.Oval.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    public var helperView: UIView = UIView()
    public var duartion: TimeInterval = TimeInterval()
    public var moveType: SpotlightMoveType = SpotlightMoveType.direct
}
