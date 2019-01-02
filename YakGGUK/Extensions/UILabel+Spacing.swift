//
//  UILabel+Spacing.swift
//  YakGGUK
//
//  Created by 김선재 on 02/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    struct Holder {
        static var letterSpacing: CGFloat = CGFloat(0.0)
    }
    
    @IBInspectable var letterSpacing: CGFloat {
        get {
            return Holder.letterSpacing
        }
        set {
            let attributedString: NSMutableAttributedString
            
            if let appliedAttributedString = self.attributedText {
                attributedString = NSMutableAttributedString(attributedString: appliedAttributedString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
            }
            
            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
            
            Holder.letterSpacing = newValue
        }
    }
}
