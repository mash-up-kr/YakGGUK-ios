//
//  UIView+Color.swift
//  YakGGUK
//
//  Created by 김선재 on 26/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setVerticalGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "gradientLeading")!.cgColor, UIColor(named: "gradientTrailing")!.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        layer.insertSublayer(gradient, at: 0)
    }
    
    func setHorizontalGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "gradientLeading")!.cgColor, UIColor(named: "gradientTrailing")!.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        layer.insertSublayer(gradient, at: 0)
    }
    
    func updateHorizontalGradientLayer() {
        guard let gradient = layer.sublayers?.first as? CAGradientLayer else {
            return
        }
        
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "gradientLeading")!.cgColor, UIColor(named: "gradientTrailing")!.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
    }
}
