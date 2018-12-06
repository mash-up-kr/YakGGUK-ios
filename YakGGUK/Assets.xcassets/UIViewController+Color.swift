//
//  UIViewController+Color.swift
//  YakGGUK
//
//  Created by juhee on 06/12/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func gradientColor(frame: CGRect) -> UIColor {
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = frame
        
        backgroundGradientLayer.colors =  [UIColor(named: "gradientLeading")!.cgColor, UIColor(named: "gradientTrailing")!.cgColor]
        UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
        backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: backgroundColorImage!)
    }
    
    func setBackgroundGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(named: "gradientLeading")!.cgColor, UIColor(named: "gradientTrailing")!.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        view.layer.insertSublayer(gradient, at: 0)
    }

    func setBackgGroundGradientView() {
        let backgroundView = UIView()
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundView, attribute: .leading, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backgroundView, attribute: .trailing, relatedBy: .equal, toItem: view.superview, attribute: .top, multiplier: 1, constant: 0)
            
            ])
        backgroundView.backgroundColor = gradientColor(frame: backgroundView.frame)
    }
}
