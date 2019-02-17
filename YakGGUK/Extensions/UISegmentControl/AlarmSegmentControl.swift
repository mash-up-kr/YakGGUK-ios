//
//  AlarmSegmentControl.swift
//  YakGGUK
//
//  Created by 김선재 on 18/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

@IBDesignable
class AlarmSegmentControl: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
    }
    
    @IBInspectable
    var commaSeperateButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = UIColor.darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        buttons.removeAll()
        self.subviews.forEach { $0.removeFromSuperview() }
        
        let buttonTitles = commaSeperateButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttons.count)
        let selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    @objc
    func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() where btn == button {
            selectedSegmentIndex = buttonIndex
            
            let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
            
            UIView.animate(withDuration: 0.3) {
                self.selector.frame.origin.x = selectorStartPosition
            }
            
            btn.setTitleColor(selectorTextColor, for: .normal)
        }
        
        sendActions(for: .valueChanged)
    }
    
}
