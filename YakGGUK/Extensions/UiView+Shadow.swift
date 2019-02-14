//
//  UiView+Shadow.swift
//  YakGGUK
//
//  Created by juhee on 06/12/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius * 2
        }
        set {
            layer.shadowRadius = newValue / 2.0
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
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
}
