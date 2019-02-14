//
//  GradientDirection.swift
//  YakGGUK
//
//  Created by juhee on 06/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

enum GradientDirection {
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: 0, y: 1)
        case .vertical:
            return CGPoint(x: 0, y: 0)
        }
    }
    var endPoint : CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: 1, y: 1)
        case .vertical:
            return CGPoint(x: 1, y: 1)
        }
    }
}
