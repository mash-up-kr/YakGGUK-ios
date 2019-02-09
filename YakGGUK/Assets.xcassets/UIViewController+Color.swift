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
    func gradientLayer(direction: GradientDirection, frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor(named: "gradientLeading")!.cgColor, UIColor(named: "gradientTrailing")!.cgColor]
        gradient.startPoint = direction.startPoint
        gradient.endPoint = direction.endPoint
        return gradient
    }
    
    func horizontalGradientColor(frame: CGRect) -> UIColor {
        let gradient = gradientLayer(direction: .horizontal, frame: frame)
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: backgroundColorImage!)
    }
    
    func setVerticalGradientLayer() {
        let gradient = gradientLayer(direction: .vertical, frame: view.bounds)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func setHorizontalGradientLayer() {
        let gradient = gradientLayer(direction: .horizontal, frame: view.bounds)
        view.layer.insertSublayer(gradient, at: 0)
    }

    // MARK: FIXME UNUSED
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
        backgroundView.backgroundColor = horizontalGradientColor(frame: backgroundView.frame)
    }
}
