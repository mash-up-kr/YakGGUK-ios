//
//  SettingView.swift
//  YakGGUK
//
//  Created by 김선재 on 26/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class SettingView: UIView {

    private var didUpdateConstraints = false
    
    private var settingViews: [UIView] = []
    
    private var current = 0
    
    private var progressView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var okButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("확인", for: .normal)
        
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 20.0)
        button.titleLabel?.textColor = UIColor.white
        
        button.titleLabel?.letterSpacing = 0.21
        
        button.layer.cornerRadius = 12.0
        
        button.layer.masksToBounds = false
        
        button.shadowOffset = CGSize(width: 0, height: 0)
        button.shadowColor = UIColor.black
        button.shadowOpacity = 0.5
        button.shadowBlur = 10.0
        
        button.layer.zPosition = 999
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(progressView)
        addSubview(backButton)
        addSubview(containerView)
        addSubview(okButton)
        
        updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                progressView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                progressView.heightAnchor.constraint(equalToConstant: 8.0)
            ])
            
            NSLayoutConstraint.activate([
                backButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20.0),
                backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
                backButton.widthAnchor.constraint(equalToConstant: 24.0),
                backButton.heightAnchor.constraint(equalToConstant: 24.0)
            ])
            
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60.0),
                containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                okButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
                okButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
                okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20.0),
                okButton.heightAnchor.constraint(equalToConstant: 64.0)
            ])
            
            let progressViewWidthConstraint = progressView.widthAnchor.constraint(equalToConstant: 10.0)
            progressViewWidthConstraint.identifier = "widthConstraint"
            progressViewWidthConstraint.isActive = true
            
            didUpdateConstraints.toggle()
        }
        
        super.updateConstraints()
    }
    
    func append(settingView: UIView) {
        settingViews.append(settingView)
    }
    
    func remove(index: Int) {
        settingViews.remove(at: index)
    }

    func removeAll() {
        settingViews.removeAll()
    }
    
    func count() -> Int {
        return settingViews.count
    }
    
    func reloadSettingViewContainer() {
        for settingView in containerView.subviews {
            settingView.removeFromSuperview()
        }
        
        for settingView in settingViews {
            containerView.addSubview(settingView)
            
            // FIXME: Constraint 오류 해결
//            settingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//            settingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
//            settingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
//            settingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        }
    }
    
    func next() {
        if current == settingViews.count - 1 {
            return
        }
        
        current += 1
        
        setProgressWidth(current: current)
    }
    
    func prev() {
        if current == 0 {
            return
        }
        
        current -= 1
        
        setProgressWidth(current: current)
    }
    
    func setProgressWidth(current: Int) {
        if settingViews.isEmpty {
            return
        }
        
        let width: Double = Double(self.bounds.width) / Double(settingViews.count) * Double(current + 1)
        
        if let constraint = progressView.constraints.filter({ $0.identifier == "widthConstraint" }).first {
            constraint.constant = CGFloat(width)
        }
        
        layoutIfNeeded()
        progressView.setHorizontalGradientLayer()
    }
    
    func setBackgroundGradient() {
        setProgressWidth(current: current)
        
        layoutIfNeeded()
        okButton.setHorizontalGradientLayer()
        okButton.layer.sublayers?.first?.cornerRadius = 12.0
    }
    
}
